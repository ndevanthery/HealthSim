import 'package:flutter/material.dart';
import 'package:healthsim/questionnaire/range_double/range_double_view.dart';
import 'package:survey_kit/survey_kit.dart' as survey;
import 'package:survey_kit/survey_kit.dart';

class RangeDoubleResult extends QuestionResult<double> {
  final String customData;
  final double? value; //Custom value

  RangeDoubleResult(
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

class RangeDoubleStep extends survey.Step {
  final String title;
  final double minValue;
  final double maxValue;
  final double? Function() defaultVal;
  final String errorMessage;
  final String hint;

  RangeDoubleStep({
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

    var controller = TextEditingController();
    bool isvalid = false;
    return RangeDoubleView(
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
