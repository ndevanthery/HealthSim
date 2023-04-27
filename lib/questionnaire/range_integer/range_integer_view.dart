import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:survey_kit/survey_kit.dart';
import 'package:survey_kit/survey_kit.dart' as survey;

import 'range_integer_step.dart';

class RangeIntegerView extends StatefulWidget {
  final survey.Step step;
  final String title;
  final int minValue;
  final int maxValue;
  final int? Function() defaultVal;
  final String errorMessage;
  final String hint;
  const RangeIntegerView(
      {super.key,
      required this.step,
      required this.title,
      required this.minValue,
      required this.maxValue,
      required this.defaultVal,
      required this.errorMessage,
      required this.hint});

  @override
  State<RangeIntegerView> createState() => _RangeIntegerViewState();
}

class _RangeIntegerViewState extends State<RangeIntegerView> {
  var controller = TextEditingController();
  bool isvalid = false;

  @override
  void initState() {
    controller.text =
        widget.defaultVal() == null ? "" : widget.defaultVal().toString();
    var val = int.tryParse(controller.text);
    val ??= -1;
    if (val > widget.maxValue || val < widget.minValue) {
      isvalid = false;
    } else {
      isvalid = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //print(questionResult!.result);
    return StepView(
      isValid: isvalid,
      step: widget.step,
      resultFunction: () => RangeIntegerResult(
          customData: "",
          startDate: DateTime.now(),
          endDate: DateTime.now(),
          identifier: widget.step.stepIdentifier,
          valueIdentifier:
              widget.step.stepIdentifier.id, //Identification for NavigableTask,
          value: isvalid ? int.parse(controller.text) : null),
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
          var val = int.tryParse(value);
          val ??= -1;
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
