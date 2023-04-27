import 'package:flutter/material.dart';
import 'package:survey_kit/survey_kit.dart';
import 'package:survey_kit/survey_kit.dart' as survey;

import 'scale_integer_step.dart';

//custom of the view of the scale question
class ScaleIntegerView extends StatefulWidget {
  final survey.Step step;
  final String title;
  final String text;
  final double minValue;
  final double maxValue;
  final double? Function() defaultVal;

  const ScaleIntegerView({
    super.key,
    required this.step,
    required this.title,
    required this.text,
    required this.minValue,
    required this.maxValue,
    required this.defaultVal,
  });

  @override
  State<ScaleIntegerView> createState() => _ScaleIntegerViewState();
}

class _ScaleIntegerViewState extends State<ScaleIntegerView> {
  late double _sliderValue;

  @override
  void initState() {
    _sliderValue = widget.defaultVal()!.toDouble();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //print(questionResult!.result);
    return StepView(
      step: widget.step,
      resultFunction: () => ScaleIntegerResult(
          customData: "",
          startDate: DateTime.now(),
          endDate: DateTime.now(),
          identifier: widget.step.stepIdentifier,
          valueIdentifier:
              widget.step.stepIdentifier.id, //Identification for NavigableTask,
          value: _sliderValue),
      title: Text(widget.title),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(
                    _sliderValue.toInt().toString(),
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 32.0, left: 14.0, right: 14.0),
                      child: Text(
                        widget.text,
                        style: Theme.of(context).textTheme.bodyText2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.minValue.toString(),
                            style: const TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            widget.maxValue.toString(),
                            style: const TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Slider.adaptive(
                      value: _sliderValue,
                      onChanged: (double value) {
                        setState(() {
                          _sliderValue = value;
                        });
                      },
                      min: widget.minValue.toDouble(),
                      max: widget.maxValue.toDouble(),
                      activeColor: Theme.of(context).primaryColor,
                      divisions: ((widget.maxValue.toDouble()) -
                              (widget.minValue.toDouble())) ~/
                          1,
                      label: _sliderValue.toString(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
