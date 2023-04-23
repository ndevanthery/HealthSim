import 'package:flutter/material.dart';
import 'package:healthsim/questionnaire/scale_integer/scale_integer_view.dart';
import 'package:survey_kit/survey_kit.dart' as survey;
import 'package:survey_kit/survey_kit.dart';

class ScaleIntegerResult extends QuestionResult<double> {
  final String customData;
  final double? value; //Custom value

  ScaleIntegerResult(
      {required this.customData,
      required String valueIdentifier,
      Identifier? identifier,
      required DateTime startDate,
      required DateTime endDate,
      required this.value //
      })
      : super(
            valueIdentifier: valueIdentifier,
            id: identifier,
            startDate: startDate,
            endDate: endDate,
            result: value);
}

class ScaleIntegerStep extends survey.Step {
  final String title;
  final String text;
  final double minValue;
  final double maxValue;
  final double? Function() defaultVal;

  ScaleIntegerStep({
    StepIdentifier? id,
    bool isOptional = false,
    String buttonText = 'Next',
    required this.title,
    required this.text,
    required this.minValue,
    required this.maxValue,
    required this.defaultVal,
  }) : super(
            isOptional: isOptional, stepIdentifier: id, buttonText: buttonText);

  @override
  Widget createView({QuestionResult? questionResult}) {
    final key = ObjectKey(stepIdentifier.id);

    bool isvalid = false;
    //print(questionResult!.result);
    return ScaleIntegerView(
      key: key,
      step: this,
      title: title,
      text: text,
      minValue: minValue,
      maxValue: maxValue,
      defaultVal: defaultVal,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
