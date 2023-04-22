import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthsim/questionnaire/custom_view.dart';
import 'package:survey_kit/survey_kit.dart' as survey;
import 'package:survey_kit/survey_kit.dart';

class CustomResult extends QuestionResult<int> {
  final String customData;
  final int value; //Custom value

  CustomResult(
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

class RangeIntegerStep extends survey.Step {
  final String title;
  final int minValue;
  final int maxValue;
  final String errorMessage;
  final String hint;

  RangeIntegerStep({
    StepIdentifier? id,
    bool isOptional = false,
    String buttonText = 'Next',
    required this.title,
    required this.minValue,
    required this.maxValue,
    required this.errorMessage,
    required this.hint,
  }) : super(
            isOptional: isOptional, stepIdentifier: id, buttonText: buttonText);

  @override
  Widget createView({QuestionResult? questionResult}) {
    var controller = TextEditingController();
    bool isvalid = false;
    //print(questionResult!.result);
    return CustomView(
        step: this,
        title: title,
        minValue: minValue,
        maxValue: maxValue,
        errorMessage: errorMessage,
        hint: hint);
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
