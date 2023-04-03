import 'dart:io';
import 'dart:math';

import 'package:csv/csv.dart';
import 'package:healthsim/algorithm/algo.dart';
import 'package:healthsim/questionnaire/ModelAnswer.dart';

class TestScript {
  static tests() async {
    List<ModelAnswer> myList = [];

    for (int i = 0; i < 100; i++) {
      ModelAnswer myModel = ModelAnswer(
          Random().nextInt(2), // sex
          Random().nextInt(80) + 18, // age
          Random().nextInt(60) + 140, // height
          Random().nextInt(60) + 40, // weight
          Random().nextInt(2), // glyc
          Random().nextInt(2), // highSyst
          -1, //syst
          Random().nextInt(2), // highChol
          -1, // chol
          -1, // hdl
          Random().nextInt(2), // diab
          Random().nextInt(2), //inf
          Random().nextInt(2), // avc
          Random().nextInt(2), // afInf
          Random().nextInt(2), // afcancer
          Random().nextInt(2), // smoke
          Random().nextInt(4), // alim
          Random().nextInt(4), // sport
          Random().nextInt(5), // alcool
          DateTime.now());

      myList.add(myModel);
      List<List<dynamic>> myCsvList = myList.map((e) {
        var myList = e.toList();
        myList.add(riskAVC(e));
        myList.add(riskCancer(e));
        myList.add(riskDiabete(e));
        return myList;
      }).toList();
      String csvFile = ListToCsvConverter().convert(myCsvList);
      print(csvFile);
/*       File f = File("filename.csv");

      await f.writeAsString(csvFile); */
    }
  }
}
