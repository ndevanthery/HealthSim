import 'package:flutter/material.dart';
import 'package:healthsim/questionnaire/range_integer/range_integer_view.dart';
import 'package:survey_kit/survey_kit.dart' as survey;
import 'package:survey_kit/survey_kit.dart';

class RangeIntegerResult extends QuestionResult<int> {
  final String customData;
  final int? value; //Custom value

  RangeIntegerResult(
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
  final int? Function() defaultVal;
  final String errorMessage;
  final String hint;

  RangeIntegerStep({
    StepIdentifier? id,
    bool isOptional = false,
    String buttonText = 'Next',
    required this.title,
    required this.minValue,
    required this.maxValue,
    required this.defaultVal,
    required this.errorMessage,
    required this.hint,
  }) : super(
            isOptional: isOptional, stepIdentifier: id, buttonText: buttonText);

  @override
  Widget createView({QuestionResult? questionResult}) {
    final key = ObjectKey(stepIdentifier.id);

    //print(questionResult!.result);
    return RangeIntegerView(
        key: key,
        step: this,
        title: title,
        minValue: minValue,
        maxValue: maxValue,
        defaultVal: defaultVal,
        errorMessage: errorMessage,
        hint: hint);
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
