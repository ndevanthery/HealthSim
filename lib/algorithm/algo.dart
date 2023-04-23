import 'dart:math';
import 'package:healthsim/questionnaire/ModelAnswer.dart';

import '../questionnaire/questionnaire.dart';

double riskAVC(ModelAnswer resultQuestionnaire) {
  //standard score
  var alimH = 0.99,
      alimF = 1.35,
      alimFH = 1.17,
      sportH = 1.74,
      sportF = 1.95,
      sportFH = 1.84;

// syst, chol, hdl
  List<double> difIfHigh = [40, 2.9, -1.1], nbStandard = [110, 3.0, 2.0];

  var syst, chol, hdl;
//put value in syst, chol and hdl if don't have it
  if (resultQuestionnaire.syst == -1) {
    syst = nbStandard.elementAt(0) +
        difIfHigh.elementAt(0) * resultQuestionnaire.highSyst;
  } else {
    syst = resultQuestionnaire.syst;
  }
  if (resultQuestionnaire.chol == -1) {
    chol = nbStandard.elementAt(1) +
        difIfHigh.elementAt(1) * resultQuestionnaire.highChol;
  } else {
    chol = resultQuestionnaire.chol;
  }
  if (resultQuestionnaire.hdl == -1) {
    hdl = nbStandard.elementAt(2) +
        difIfHigh.elementAt(2) * resultQuestionnaire.highChol;
  } else {
    hdl = resultQuestionnaire.hdl;
  }

  var resultAVC = 0.0;
  //reduction risk
  var alimP = 0.65, sportP = 0.45;

  //if never had heart attack/avc
  if (resultQuestionnaire.inf == 0 && resultQuestionnaire.avc == 0) {
    //base calcul
    double baseAfinf = 1 + 0.3 * resultQuestionnaire.afinf;
    double baseAge = (resultQuestionnaire.age - 60) / 5,
        baseSmoke = resultQuestionnaire.smoke * 1.0,
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

    if (resultQuestionnaire.gender == 1) {
      baseAlim = (resultQuestionnaire.alim - alimH) / 3;
      baseSport = (resultQuestionnaire.sport - sportH) / 3;
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
    } else {
      baseAlim = (resultQuestionnaire.alim - alimF) / 3;
      baseSport = (resultQuestionnaire.sport - sportF) / 3;
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

    var sumAVC = baseAge * coeffAge +
        baseSmoke * coeffSmoke +
        baseSyst * coeffSyst +
        baseChol * coeffChol +
        baseHdl * coeffHdl +
        baseSmokeAge * coeffSmokeAge +
        baseSystAge * coeffSystAge +
        baseCholAge * coeffCholAge +
        baseHdlAge * coeffHdlAge;
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
    var baseAlim = (resultQuestionnaire.alim - alimFH) / 3,
        baseSport = (resultQuestionnaire.sport - sportFH) / 3;
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

    double sumAVC = resultQuestionnaire.age * coeffAge +
        resultQuestionnaire.gender * coeffGender +
        resultQuestionnaire.smoke * coeffSmoke +
        syst * coeffSyst +
        resultQuestionnaire.diab * coeffDiab +
        resultQuestionnaire.inf * coeffInf +
        resultQuestionnaire.avc * coeffAvc +
        chol * coeffChol +
        hdl * coeffHdl +
        corr;
    sumAVC = 1.0 - pow(0.61789, exp(sumAVC - 2.0869));
    var riskAlim = sumAVC - (sumAVC * alimP * baseAlim);
    var riskSport = sumAVC - (sumAVC * sportP * baseSport);
    resultAVC = (riskAlim + riskSport) / 2 * 100;
  }
  if(resultAVC>100) {
    resultAVC=100;
  }

  return resultAVC.roundToDouble();
}

double riskDiabete(ModelAnswer resultQuestionnaire) {
  //diabete algo
  var resultDiab = 0;
  //score table
  var scoreTable = [
    2,
    1.9333,
    1.8667,
    1.8,
    1.7333,
    1.6667,
    1.6,
    1.5333,
    1.4667,
    1.4,
    1.3333,
    1.2667,
    1.2,
    1.1333,
    1.0667,
    1,
    0.9333,
    0.8667,
    0.8,
    0.7333,
    0.6667,
    0.6,
    0.5333,
    0.4667,
    0.4,
    0.3333,
    0.2667,
    0.2,
    0.1333,
    0.0667,
    0
  ];

  //risk table
  var riskTableF = [
        0,
        1,
        1,
        1,
        1,
        1,
        1,
        2,
        3,
        5,
        7,
        11,
        15,
        21,
        28,
        36,
        46,
        58,
        71,
        86,
        100,
        100,
        100
      ],
      riskTableH = [
        0,
        0,
        0,
        0,
        0,
        0,
        1,
        2,
        4,
        7,
        11,
        15,
        21,
        28,
        36,
        46,
        58,
        71,
        86,
        100,
        100,
        100,
        100
      ];

  var bmi = resultQuestionnaire.weight /
      (resultQuestionnaire.height / 100 * resultQuestionnaire.height / 100);

  //points
  var points = 3.0;

  if (resultQuestionnaire.age < 45) {
    points += 0;
  } else if (resultQuestionnaire.age <= 54) {
    points += 2;
  } else {
    points += 3;
  }

  if (bmi < 27) {
    points += 0;
  } else if (bmi >= 30) {
    points += 2;
  } else {
    points += 3;
  }

  if (resultQuestionnaire.highSyst == 1) {
    points += 2;
  }
  if (resultQuestionnaire.glyc == 1) {
    points += 5;
  }

  points += scoreTable.elementAt(resultQuestionnaire.sport * 10) +
      scoreTable.elementAt(resultQuestionnaire.alim * 10);

  if (resultQuestionnaire.gender == 1) {
    resultDiab = riskTableH.elementAt(points.round());
  } else {
    resultDiab = riskTableF.elementAt(points.round());
  }

  if(resultDiab>100) {
    resultDiab=100;
  }

  return resultDiab * 1.0;
}

double riskBaseCancer(ModelAnswer resultQuestionnaire){
  //variables for correction for user age
  var maxAge=85, lifeRiskF=47.0, lifeRiskH=50.0;

  double normalPopulationRisk=0.0;

  //1 = Man / 0 = Woman
  if(resultQuestionnaire.gender==1){
    //calcul for correction for user age for a man
    normalPopulationRisk =lifeRiskH/10000*(maxAge-resultQuestionnaire.age);
  } else{
    //calcul for correction for user age for a woman
    normalPopulationRisk =lifeRiskF/10000*(maxAge-resultQuestionnaire.age);
  }
  normalPopulationRisk = normalPopulationRisk*100;
  return normalPopulationRisk;

}

double riskCancer(ModelAnswer resultQuestionnaire) {
  //cancer algo
  //do the riskBaseCancer for normal population
  var correctionAge= riskBaseCancer(resultQuestionnaire)/100;

  //base variables for calculs
  var afcancerF = [0.671384133654698, 1.30024926353954], afcancerH = [0.728388111407757, 1.31883958419197];
  var smokeF = [0.72,1.19], smokeH = [0.50,1.67];
  var alcoolF = [1.33374851388643,1.15,1.00,0.95,0.90], alcoolH = [1.16425276692004,1.08,1.00,0.95,0.90];
  var sportF = [1.34398368456832,1.00,0.90,0.80], sportH = [1.10257819297523,1.00,0.90,0.80];
  var alimFH = [1.10,1.05,1.00,0.95];

  var bmi = resultQuestionnaire.weight /
      (resultQuestionnaire.height / 100 * resultQuestionnaire.height / 100);

  double bmiFH=1.00;

  if(bmi>25){
    bmiFH += (bmi-25).ceil()/100;
  }

  double result;

  //1 = Man / 0 = Woman
  if(resultQuestionnaire.gender==1){
    double correctionAF = afcancerH.elementAt(resultQuestionnaire.afcancer.toInt())*correctionAge;
    result = correctionAF*smokeH.elementAt(resultQuestionnaire.smoke.toInt())*alcoolH.elementAt(resultQuestionnaire.alcool)*sportH.elementAt(resultQuestionnaire.sport)*alimFH.elementAt(resultQuestionnaire.alim)*bmiFH;

  }else{
    result = afcancerF.elementAt(resultQuestionnaire.afcancer.toInt())*correctionAge;
    result = result*smokeF.elementAt(resultQuestionnaire.smoke.toInt())*alcoolF.elementAt(resultQuestionnaire.alcool)*sportF.elementAt(resultQuestionnaire.sport)*alimFH.elementAt(resultQuestionnaire.alim)*bmiFH;
  }

  result = result*100;
  if(result>100){
    result=100;
  }
  return double.parse(result.toStringAsFixed(2));





}
