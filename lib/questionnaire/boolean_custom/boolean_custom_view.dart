import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:survey_kit/survey_kit.dart';
import 'package:survey_kit/survey_kit.dart' as survey;

import 'boolean_custom_step.dart';

class BooleanCustomView extends StatefulWidget {
  final survey.Step step;
  final String title;
  final bool? Function() defaultVal;
  final String positiveAnswer;
  final String negativeAnswer;
  const BooleanCustomView({
    super.key,
    required this.step,
    required this.title,
    required this.defaultVal,
    required this.positiveAnswer,
    required this.negativeAnswer,
  });

  @override
  State<BooleanCustomView> createState() => _BooleanCustomViewState();
}

class _BooleanCustomViewState extends State<BooleanCustomView> {
  bool isvalid = false;
  bool? value;

  @override
  void initState() {
    isvalid = widget.defaultVal() != null;
    value = widget.defaultVal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //print(questionResult!.result);
    return StepView(
      isValid: isvalid,
      step: widget.step,
      resultFunction: () => BooleanCustomResult(
        customData: "",
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        identifier: widget.step.stepIdentifier,

        valueIdentifier:
            widget.step.stepIdentifier.id, //Identification for NavigableTask,
        value: value!,
      ),
      title: Text(widget.title),
      child: Container(
        child: Column(
          children: [
            Column(
              children: [
                Divider(
                  color: Colors.grey,
                ),
                SelectionListTile(
                  text: widget.positiveAnswer,
                  onTap: () {
                    if (value == true) {
                      value = null;
                    } else {
                      value = true;
                    }
                    isvalid = value != null;
                    setState(() {});
                  },
                  isSelected: value == true,
                ),
                SelectionListTile(
                  text: widget.negativeAnswer,
                  onTap: () {
                    if (value == false) {
                      value = null;
                    } else {
                      value = false;
                    }
                    isvalid = value != null;

                    setState(() {});
                  },
                  isSelected: value == false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
