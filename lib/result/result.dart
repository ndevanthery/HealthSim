import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../algorithm/algo.dart';

class ResultPage extends StatefulWidget {
  bool _showSimulationSection = false;

  ResultPage({super.key});

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  bool _isSmoking = false;
  bool _isDrinking = false;
  double _eatingValue = 2;
  double _exerciseValue = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Text(
                'Your Health Risks',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
              const SizedBox(height: 20),
              MediaQuery.of(context).size.width < 600
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildResultsCard(context, 'Cancer Risk', 'Medium',
                            'Higher than Normal', riskCancer(0, 0, 30, 1, 0, 1) as double),
                        _buildResultsCard(context, 'Heart Disease Risk', 'High',
                            'Higher than Normal', 56),
                        _buildResultsCard(context, 'Diabetes Risk', 'Low',
                            'Lower than Normal', 76),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildResultsCard(context, 'Cancer Risk', 'Medium',
                            'Higher than Normal', riskCancer(0, 0, 30, 1, 0, 1) as double),
                        _buildResultsCard(context, 'Heart Disease Risk', 'High',
                            'Higher than Normal', 56),
                        _buildResultsCard(context, 'Diabetes Risk', 'Low',
                            'Lower than Normal', 76),
                      ],
                    ),
              const SizedBox(height: 20),
              Visibility(
                visible: widget._showSimulationSection,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'Simulate the Impact of Changing Your Habits',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SwitchListTile(
                      title: const Text('Stop Smoking'),
                      value: _isSmoking,
                      onChanged: (newValue) {
                        setState(() {
                          _isSmoking = newValue;
                        });
                      },
                    ),
                    SwitchListTile(
                      title: const Text('Stop Drinking Alcohol'),
                      value: _isDrinking,
                      onChanged: (newValue) {
                        setState(() {
                          _isDrinking = newValue;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Eating Healthier:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                          ),
                        ),
                        Text(
                          '$_eatingValue',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: _eatingValue,
                      min: 0,
                      max: 4,
                      divisions: 4,
                      label: _eatingValue.round().toString(),
                      onChanged: (value) {
                        setState(() {
                          _eatingValue = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Exercising Regularly:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                          ),
                        ),
                        Text(
                          '$_exerciseValue',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: _exerciseValue,
                      min: 0,
                      max: 4,
                      divisions: 4,
                      label: _exerciseValue.round().toString(),
                      onChanged: (value) {
                        setState(() {
                          _exerciseValue = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    MediaQuery.of(context).size.width < 600
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildResultsCard(context, 'Cancer Risk',
                                  'Medium', 'Higher than Normal', riskCancer(0, 0, 30, 1, 0, 1) as double),
                              _buildResultsCard(context, 'Heart Disease Risk',
                                  'High', 'Higher than Normal', 56),
                              _buildResultsCard(context, 'Diabetes Risk', 'Low',
                                  'Lower than Normal', 76),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildResultsCard(context, 'Cancer Risk',
                                  'Medium', 'Higher than Normal', riskCancer(0, 0, 30, 1, 0, 1) as double),
                              _buildResultsCard(context, 'Heart Disease Risk',
                                  'High', 'Higher than Normal', 56),
                              _buildResultsCard(context, 'Diabetes Risk', 'Low',
                                  'Lower than Normal', 76),
                            ],
                          ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    widget._showSimulationSection =
                        !widget._showSimulationSection;
                  });
                },
                child: Text(
                  widget._showSimulationSection
                      ? 'Hide Simulation Section'
                      : 'Show Simulation Section',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue[900],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultsCard(BuildContext context, String title, String subtitle,
      String rank, double risk) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: MediaQuery.of(context).size.width < 600
          ? Container(
              padding: const EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width / 1.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 60,
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _getRisk(risk),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const SizedBox(height: 10),
                        Text(
                          "99th percentile",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CircularPercentIndicator(
                    radius: MediaQuery.of(context).size.width / 8,
                    lineWidth: 6.0,
                    percent: risk / 100,
                    center: Text("${risk.round()}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0)),
                    progressColor: _getRiskColor(risk),
                    backgroundColor: Colors.grey.shade200,
                    animation: true,
                    animationDuration: 2000,
                  ),
                ],
              ),
            )
          : Container(
              padding: const EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width / 3.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 60,
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _getRisk(risk),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 10),
                  CircularPercentIndicator(
                    radius: 40.0,
                    lineWidth: 6.0,
                    percent: risk / 100,
                    center: Text("${risk.round()}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0)),
                    progressColor: _getRiskColor(risk),
                    backgroundColor: Colors.grey.shade200,
                    animation: true,
                    animationDuration: 2000,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "99th percentile",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Color _getRiskColor(double risk) {
    if (risk < 25) {
      return Colors.green;
    } else if (risk < 50) {
      return Colors.yellow;
    } else if (risk < 75) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  String _getRisk(double risk) {
    if (risk < 25) {
      return "Low";
    } else if (risk < 50) {
      return "Medium";
    } else if (risk < 75) {
      return "High";
    } else {
      return "Very High";
    }
  }
  double getRiskCancer(){
    var risk;
    riskCancer(0, 0, 30, 1, 0, 1).then((value) => risk = value);
    return  risk;
  }
}
