import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthsim/questionnaire/boolean_custom/boolean_custom_view.dart';
import 'package:healthsim/questionnaire/range_integer/range_integer_view.dart';
import 'package:survey_kit/survey_kit.dart' as survey;
import 'package:survey_kit/survey_kit.dart';

class BooleanCustomResult extends QuestionResult<bool> {
  final String customData;
  final bool value; //Custom value

  BooleanCustomResult(
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

class BooleanCustomStep extends survey.Step {
  final String title;
  final bool? Function() defaultVal;
  final String positiveAnswer;
  final String negativeAnswer;

  BooleanCustomStep({
    StepIdentifier? id,
    bool isOptional = false,
    String buttonText = 'Next',
    required this.title,
    required this.defaultVal,
    required this.positiveAnswer,
    required this.negativeAnswer,
  }) : super(
            isOptional: isOptional, stepIdentifier: id, buttonText: buttonText);

  @override
  Widget createView({QuestionResult? questionResult}) {
    final key = ObjectKey(stepIdentifier.id);

    var controller = TextEditingController();
    bool isvalid = false;
    //print(questionResult!.result);
    return BooleanCustomView(
      key: key,
      step: this,
      title: title,
      defaultVal: defaultVal,
      positiveAnswer: positiveAnswer,
      negativeAnswer: negativeAnswer,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
