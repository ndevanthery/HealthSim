import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

void algo() {
  //results
  var resultAVC = 0,
      resultDiab = 0,
      resultCancer = 0;
  //standard score
  var alimH = 0.99,
      alimF = 1.35,
      alimFH = 1.17,
      sportH = 1.74,
      sportF = 1.95,
      sportFH = 1.84;
  // syst, glyc, chol, hdl
  List<double> difIfHigh = [ 40, 0.6, 2.9, -1.1],
      nbStandard = [ 110, 5.0, 3.0, 2.0];
  //questionnaire values
  var age = 22,
      glyc = -1.0,
      syst = -1.0,
      chol = -1.0,
      hdl = -1.0,
      alim = 2,
      sport = 1,
      weight = 68,
      height = 170,
      alcool = 0;
  //0=man 1=woman
  var gender = 1;
  //0=false 1=true
  var inf = 0,
      highSyst = 0,
      highGlyc = 0,
      highChol = 0,
      highHdl = 0,
      afinf = 0,
      diab = 0,
      avc = 0,
      afcancer = 0,
      smoke = 0;
  //BMI
  var bmi = weight / (height / 100 * height / 100);
  print(bmi);

  //put syst,glyc,chol,hdl value if needed
  if (syst == -1) {
    syst = nbStandard.elementAt(0) + difIfHigh.elementAt(0) * highSyst;
  }
  if (glyc == -1) {
    glyc = nbStandard.elementAt(1) + difIfHigh.elementAt(1) * highGlyc;
  }
  if (chol == -1) {
    chol = nbStandard.elementAt(2) + difIfHigh.elementAt(2) * highChol;
  }
  if (hdl == -1) {
    hdl = nbStandard.elementAt(3) + difIfHigh.elementAt(3) * highHdl;
  }
  resultAVC = riskAVC(inf, avc, afinf, age, smoke, syst, chol, hdl, gender, alim, alimH, alimF, alimFH, sport, sportH, sportF, sportFH, diab);
  resultDiab = riskDiabete(age, bmi, highSyst, highGlyc, sport, alim, gender);
  resultCancer = riskCancer(afcancer, smoke, bmi, sport, alcool, alim) as int;
  print("The risk of AVC is $resultAVC%.\n The risk of diabete is $resultDiab%.\n The risk of cancer is $resultCancer%");
}

int riskAVC(int inf, int avc, int afinf, int age, int smoke, double syst, double chol,
    double hdl, int gender, int alim, double alimH, double alimF, double alimFH , int sport,
    double sportH, double sportF, double sportFH, int diab) {
  //algo risk heart attack/infractus/avc
  var resultAVC = 0.0;
  //reduction risk
  var alimP = 0.65,
      sportP = 0.45;
  //if never had heart attack/infractus/avc
  if (inf == 0 && avc == 0) {
    //base calcul
    double baseAfinf = 1 + 0.3 * afinf;
    double baseAge = (age - 60) / 5,
        baseSmoke = smoke * 1.0,
        baseSyst = (syst - 120) / 20,
        baseChol = (chol - 6) / 1,
        baseHdl = (hdl - 1.3) / 0.5;
    double baseSmokeAge = baseAge * baseSmoke,
        baseSystAge = baseAge * baseSyst,
        baseCholAge = baseAge * baseChol,
        baseHdlAge = baseAge * baseHdl;
    double baseAlim, baseSport;

    //coefficients
    double coeffAge = 0,
        coeffSmoke = 0,
        coeffSyst = 0,
        coeffChol = 0,
        coeffHdl = -0,
        coeffSmokeAge = -0,
        coeffSystAge = -0,
        coeffCholAge = -0,
        coeffHdlAge = 0;

    if (gender == 0) {
      baseAlim = (alim - alimH) / 3;
      baseSport = (sport - sportH) / 3;
      //coefficients
      coeffAge = 0.3742;
      coeffSmoke = 0.6012;
      coeffSyst = 0.2777;
      coeffChol = 0.1458;
      coeffHdl = -0.2698;
      coeffSmokeAge = -0.0755;
      coeffSystAge = -0.0255;
      coeffCholAge = -0.0281;
      coeffHdlAge = 0.0426;
    }
    else {
      baseAlim = (alim - alimF) / 3;
      baseSport = (sport - sportF) / 3;
      //coefficients
      coeffAge = 0.4648;
      coeffSmoke = 0.7744;
      coeffSyst = 0.3131;
      coeffChol = 0.1002;
      coeffHdl = -0.2606;
      coeffSmokeAge = -0.1088;
      coeffSystAge = -0.0277;
      coeffCholAge = -0.0226;
      coeffHdlAge = 0.0613;
    }

    var sumAVC = baseAge * coeffAge + baseSmoke * coeffSmoke +
        baseSyst * coeffSyst + baseChol * coeffChol + baseHdl * coeffHdl +
        baseSmokeAge * coeffSmokeAge + baseSystAge * coeffSystAge +
        baseCholAge * coeffCholAge + baseHdlAge * coeffHdlAge;
    resultAVC = 1.0 - pow(0.9605, exp(sumAVC));
    resultAVC = 1.0 - exp(-exp(-0.5699 + 0.7476 * log(-log(1 - resultAVC))));
    resultAVC = resultAVC * baseAfinf;
    double riskAlim = resultAVC - (resultAVC * alimP * baseAlim);
    double riskSport = resultAVC - (resultAVC * sportP * baseSport);
    resultAVC = (riskSport + riskAlim) / 2 * 100;
  }
  //if had heart attack/infractus/avc
  else {
    //  base calcul
    var baseAlim = (alim - alimFH) / 3,
        baseSport = (sport - sportFH) / 3;
    //coefficients
    var coeffAge = 0.0116,
        coeffGender = 0.2148,
        coeffSmoke = 0.1754,
        coeffSyst = 0.0037,
        coeffDiab = 0.2465,
        coeffInf = 0.3399,
        coeffAvc = 0.0167,
        coeffChol = 0.4159,
        coeffHdl = -0.2989;
    var corr = -2.2094;

    double sumAVC = age * coeffAge + gender * coeffGender + smoke * coeffSmoke +
        syst * coeffSyst
        + diab * coeffDiab + inf * coeffInf + avc * coeffAvc + chol * coeffChol
        + hdl * coeffHdl + corr;
    sumAVC = 1.0 - pow(0.61789, exp(sumAVC - 2.0869));
    var riskAlim = sumAVC - (sumAVC * alimP * baseAlim);
    var riskSport = sumAVC - (sumAVC * sportP * baseSport);
    resultAVC = (riskAlim + riskSport) / 2 * 100;
  }

  return resultAVC.round();
}

int riskDiabete(int age, double bmi, int highSyst, int highGlyc, int sport,
    int alim, int gender ) {
  //diabete algo
  var resultDiab = 0;
  //score table
  var scoreTable = [2, 1.9333, 1.8667, 1.8, 1.7333, 1.6667, 1.6, 1.5333, 1.4667,
    1.4, 1.3333, 1.2667, 1.2, 1.1333, 1.2667, 1.2, 1.1333, 1.0667, 1, 0.9333,
    0.8667, 0.8, 0.7333, 0.6667, 0.6, 0.5333, 0.4667, 0.4, 0.3333, 0.2667, 0.2,
    0.1333, 0.0667, 0];

  //risk table
  var riskTableF = [0, 1, 1, 1, 1, 1, 1, 2, 3, 5, 7, 11, 15, 21, 28, 36, 46, 58,
        71, 86, 100, 100, 100],
      riskTableH = [0, 0, 0, 0, 0, 0, 1, 2, 4, 7, 11, 15, 21, 28, 36, 46, 58,71,
        86, 100, 100, 100, 100];

  //points
  var points = 3.0;

  if (age < 45) {
    points = 0;
  } else if (age <= 54) {
    points = 2;
  } else {
    points = 3;
  }

  if (bmi < 27) {
    points += 0;
  } else if (bmi >= 30) {
    points += 2;
  } else {
    points += 3;
  }

  if (highSyst == 1) {
    points += 2;
  }
  if (highGlyc == 1) {
    points += 5;
  }

  points += scoreTable.elementAt(sport * 10) + scoreTable.elementAt(alim * 10);


  if (points - points.round() != 0) {
    points += 1;
  }
  if (gender == 0) {
    resultDiab = riskTableH.elementAt(points.round());
  } else {
    resultDiab = riskTableF.elementAt(points.round());
  }

  return resultDiab;
}

Future<double> riskCancer(int afcancer, int smoke, double bmi, int sport, int alcool, int alim) async {
  print("in the riskCancer");
  int afinf = -6;
  afinf = await getAnswers();
  print("afinf : ${afinf.toString()}");
  //cancer algo
  //points calcul
  var sumCancer= afcancer + smoke + 0.0;

  sumCancer += ((bmi-25)/10)*0.5;
  sumCancer += (3-sport)/3*0.5;
  sumCancer += (4-alcool)/4*0.5;
  sumCancer += (3-alim)/3*0.5;

  var resultCancer = sumCancer/4.0*100 +9;

  return resultCancer.roundToDouble();

}
Future<int> getAnswers() async {
  var db = FirebaseFirestore.instance;
  int age = -9;
  await db.collection("users").doc("Guest").collection("questionnaires").where("date", isEqualTo: "${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}").get().then(
        (querySnapshot) {
      print("Successfully completed");
      for (var docSnapshot in querySnapshot.docs) {
        age = docSnapshot.data().values.first;
        print(" dans for age: $age");
        print('${docSnapshot.id} => ${docSnapshot.data()}');
        break;
      }
    },
    onError: (e) => print("Error completing: $e"),
  );
  print("age: $age");
  FutureOr<int> fAge =  Future(() => age);
  return fAge;
}