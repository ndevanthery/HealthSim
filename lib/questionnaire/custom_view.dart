import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:survey_kit/survey_kit.dart';
import 'package:survey_kit/survey_kit.dart' as survey;

import 'custom_step.dart';

class CustomView extends StatefulWidget {
  final survey.Step step;
  final String title;
  final int minValue;
  final int maxValue;
  final String errorMessage;
  final String hint;
  const CustomView(
      {super.key,
      required this.step,
      required this.title,
      required this.minValue,
      required this.maxValue,
      required this.errorMessage,
      required this.hint});

  @override
  State<CustomView> createState() => _CustomViewState();
}

class _CustomViewState extends State<CustomView> {
  var controller = TextEditingController();
  bool isvalid = false;
  @override
  Widget build(BuildContext context) {
    //print(questionResult!.result);
    return StepView(
      isValid: isvalid,
      step: widget.step,
      resultFunction: () => CustomResult(
        customData: "",
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        valueIdentifier: 'custom', //Identification for NavigableTask,
        value: int.parse(controller.text),
      ),
      title: Text(widget.title),
      child: Container(
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
            var val = int.tryParse(value);
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
        borderRadius: BorderRadius.all(
          Radius.zero,
        ),
        borderSide: BorderSide(
          color: Colors.black.withOpacity(0.2),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.zero,
        ),
        borderSide: BorderSide(
          color: Colors.black.withOpacity(0.2),
        ),
      ),
      hintText: hint,
    );
