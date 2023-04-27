import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:survey_kit/survey_kit.dart';
import 'package:survey_kit/survey_kit.dart' as survey;

import 'range_double_step.dart';

//custom of the view of the double question
class RangeDoubleView extends StatefulWidget {
  final survey.Step step;
  final String title;
  final double minValue;
  final double maxValue;
  final double? Function() defaultVal;
  final String errorMessage;
  final String hint;
  const RangeDoubleView(
      {super.key,
      required this.step,
      required this.title,
      required this.minValue,
      required this.maxValue,
      required this.defaultVal,
      required this.errorMessage,
      required this.hint});

  @override
  State<RangeDoubleView> createState() => _RangeDoubleViewState();
}

class _RangeDoubleViewState extends State<RangeDoubleView> {
  var controller = TextEditingController();
  bool isvalid = false;

  @override
  void initState() {
    controller.text =
        widget.defaultVal() == null ? "" : widget.defaultVal().toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //print(questionResult!.result);
    return StepView(
      isValid: isvalid,
      step: widget.step,
      resultFunction: () => RangeDoubleResult(
          customData: "",
          startDate: DateTime.now(),
          endDate: DateTime.now(),
          identifier: widget.step.stepIdentifier,
          valueIdentifier:
              widget.step.stepIdentifier.id, //Identification for NavigableTask,
          value: isvalid ? double.parse(controller.text) : null),
      title: Text(widget.title),
      child: TextFormField(
        keyboardType: TextInputType.number,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: textFieldInputDecoration(hint: widget.hint),
        controller: controller,
        onChanged: ((value) {
          setState(() {});
        }),
        validator: (value) {
          if (value == "" || value == null) {
            SchedulerBinding.instance.addPostFrameCallback((duration) {
              setState(() {
                isvalid = false;
              });
            });

            return null;
          }
          var val = double.tryParse(value);
          val ??= 0;
          if (val > widget.maxValue || val < widget.minValue) {
            SchedulerBinding.instance.addPostFrameCallback((duration) {
              setState(() {
                isvalid = false;
              });
            });
            return widget.errorMessage;
          }
          isvalid = true;
          SchedulerBinding.instance.addPostFrameCallback((duration) {
            setState(() {
              isvalid = true;
            });
          });
          return null;
        },
      ),
    );
  }
}

InputDecoration textFieldInputDecoration({String hint = ''}) => InputDecoration(
      contentPadding: const EdgeInsets.only(
        left: 10,
        bottom: 10,
        top: 10,
        right: 10,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.zero,
        ),
        borderSide: BorderSide(
          color: Colors.black.withOpacity(0.2),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.zero,
        ),
        borderSide: BorderSide(
          color: Colors.black.withOpacity(0.2),
        ),
      ),
      hintText: hint,
    );
