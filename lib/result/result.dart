import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthsim/questionnaire/ModelAnswer.dart';
import 'package:healthsim/questionnaire/questionnaire.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../algorithm/algo.dart';

class ResultPage extends StatefulWidget {
  bool _showSimulationSection = false;
  ModelAnswer resultQuestionnaire;

  ResultPage({super.key, required this.resultQuestionnaire});

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late bool _isSmoking;
  late bool _isDrinking;
  late double _eatingValue;
  double _exerciseValue = 2;
  late ModelAnswer simulationQuestionnaire;
  late ModelAnswer normalValue;
  
  @override
  void initState() {
    initSimulation();
    super.initState();
  }

  void initSimulation() {
    simulationQuestionnaire = widget.resultQuestionnaire.copy();
    _isSmoking = simulationQuestionnaire.smoke == 1;
    _isDrinking = simulationQuestionnaire.alcool == 1;
    _eatingValue = simulationQuestionnaire.alim.toDouble();
    _exerciseValue = simulationQuestionnaire.sport.toDouble();
    if(simulationQuestionnaire.gender==0){
      normalValue = ModelAnswer(simulationQuestionnaire.gender, simulationQuestionnaire.age, 173, 79, -1, 0, -1, 0, -1, -1, 0, simulationQuestionnaire.inf, simulationQuestionnaire.avc, 0, 0.03, 0.5, 2, 1, 3, DateTime.now());
    } else{
      normalValue = ModelAnswer(simulationQuestionnaire.gender, simulationQuestionnaire.age, 178, 83, -1, 0, -1, 0, -1, -1, 0, simulationQuestionnaire.inf, simulationQuestionnaire.avc, 0, 0.08, 0.5, 2, 1, 3, DateTime.now());
    }
    print( "riskCancer ${riskCancer(widget.resultQuestionnaire)}");
    print( "riskDiab ${riskDiabete(widget.resultQuestionnaire)}");
    print( "riskAVC ${riskAVC(widget.resultQuestionnaire)}");
  }

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
                        _buildResultsCard(
                            context,
                            'Cancer Risk',
                            'Medium',
                            'Higher than Normal',
                            riskCancer(widget.resultQuestionnaire),
                            riskCancer(normalValue)),
                        _buildResultsCard(
                            context,
                            'Heart Disease Risk',
                            'High',
                            'Higher than Normal',
                            riskAVC(widget.resultQuestionnaire),
                            riskAVC(normalValue)),
                        _buildResultsCard(
                            context,
                            'Diabetes Risk',
                            'Low',
                            'Lower than Normal',
                            riskDiabete(widget.resultQuestionnaire),
                            riskDiabete(normalValue)),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildResultsCard(
                            context,
                            'Cancer Risk',
                            'Medium',
                            'Higher than Normal',
                            riskCancer(widget.resultQuestionnaire),
                            riskCancer(normalValue)),
                        _buildResultsCard(
                            context,
                            'Heart Disease Risk',
                            'High',
                            'Higher than Normal',
                            riskAVC(widget.resultQuestionnaire),
                            riskAVC(normalValue)),
                        _buildResultsCard(
                            context,
                            'Diabetes Risk',
                            'Low',
                            'Lower than Normal',
                            riskDiabete(widget.resultQuestionnaire),
                            riskDiabete(normalValue)),
                      ],
                    ),
              const SizedBox(height: 20),
              //Comparative
              Table(
                columnWidths: const <int, TableColumnWidth>{
                  0: FlexColumnWidth(),
                  1: FlexColumnWidth(),
                  2: FlexColumnWidth()
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children:  [
                  TableRow(
                      children: [
                        const Text(""),
                        Text("Your answers",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue[900]),),
                        Text("The answers from average person",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue[900])),
                      ]
                  ),
                  TableRow(
                      children: [
                        Text("Sport",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue[900])),
                        Text("${widget.resultQuestionnaire.sport}",
                          style : const TextStyle(fontSize: 16)),
                        Text("${normalValue.sport}",
                            style : const TextStyle(fontSize: 16)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Text("Alimentation",
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color: Colors.blue[900])),
                        Text("${widget.resultQuestionnaire.alim}",
                            style : const TextStyle(fontSize: 16)),
                        Text("${normalValue.alim}",
                            style : const TextStyle(fontSize: 16)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Text("Alcool",
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color: Colors.blue[900])),
                        Text("${widget.resultQuestionnaire.alcool}",
                            style : const TextStyle(fontSize: 16)),
                        Text("${normalValue.alcool}",
                            style : const TextStyle(fontSize: 16)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Text("Smoke ?",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue[900])),
                        Container(
                          child: widget.resultQuestionnaire.smoke==1?
                          const Text("yes",
                              style : TextStyle(fontSize: 16)):
                          const Text("no",
                              style : TextStyle(fontSize: 16))
                        ),
                        const Text("half",
                            style : TextStyle(fontSize: 16))
                      ]
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
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
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          initSimulation();
                        });
                      },
                      child: Text("Reset Simulation")),
                  const SizedBox(height: 10),
                  Row(children: [
                    Expanded(
                      child: SwitchListTile(
                        title: const Text('Smoking'),
                        value: _isSmoking,
                        onChanged: (newValue) {
                          setState(() {
                            _isSmoking = newValue;
                            simulationQuestionnaire.smoke = newValue ? 1 : 0;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: SwitchListTile(
                        title: const Text('Drinking Alcohol'),
                        value: _isDrinking,
                        onChanged: (newValue) {
                          setState(() {
                            _isDrinking = newValue;
                            simulationQuestionnaire.alcool = newValue ? 1 : 0;
                          });
                        },
                      ),
                    )
                  ]),
                  const SizedBox(height: 20),
                  MediaQuery.of(context).size.width < 600
                      ? Column(
                          children: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Eating habits:',
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
                                  max: 3,
                                  divisions: 3,
                                  label: _eatingValue.round().toString(),
                                  onChanged: (value) {
                                    setState(() {
                                      _eatingValue = value;
                                      simulationQuestionnaire.alim =
                                          value.toInt();
                                    });
                                  },
                                )
                              ],
                            ),
                            const SizedBox(height: 20),
                            Column(children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                max: 3,
                                divisions: 3,
                                label: _exerciseValue.round().toString(),
                                onChanged: (value) {
                                  setState(() {
                                    _exerciseValue = value;
                                    simulationQuestionnaire.sport =
                                        value.toInt();
                                  });
                                },
                              ),
                            ]),
                          ],
                        )
                      : Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Eating habits:',
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
                                    max: 3,
                                    divisions: 3,
                                    label: _eatingValue.round().toString(),
                                    onChanged: (value) {
                                      setState(() {
                                        _eatingValue = value;
                                        simulationQuestionnaire.alim =
                                            value.toInt();
                                      });
                                    },
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            Expanded(
                              child: Column(children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                  max: 3,
                                  divisions: 3,
                                  label: _exerciseValue.round().toString(),
                                  onChanged: (value) {
                                    setState(() {
                                      _exerciseValue = value;
                                      simulationQuestionnaire.sport =
                                          value.toInt();
                                    });
                                  },
                                ),
                              ]),
                            ),
                          ],
                        ),
                  const SizedBox(height: 20),
                  MediaQuery.of(context).size.width < 600
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildResultsCard(
                                context,
                                'Cancer Risk',
                                'Medium',
                                'Higher than Normal',
                                riskCancer(simulationQuestionnaire),
                                riskCancer(normalValue)),
                            _buildResultsCard(
                                context,
                                'Heart Disease Risk',
                                'High',
                                'Higher than Normal',
                                riskAVC(simulationQuestionnaire),
                                riskAVC(normalValue)),
                            _buildResultsCard(
                                context,
                                'Diabetes Risk',
                                'Low',
                                'Lower than Normal',
                                riskDiabete(simulationQuestionnaire),
                                riskDiabete(normalValue)),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildResultsCard(
                                context,
                                'Cancer Risk',
                                'Medium',
                                'Higher than Normal',
                                riskCancer(simulationQuestionnaire),
                                riskCancer(normalValue)),
                            _buildResultsCard(
                                context,
                                'Heart Disease Risk',
                                'High',
                                'Higher than Normal',
                                riskAVC(simulationQuestionnaire),
                                riskAVC(normalValue)),
                            _buildResultsCard(
                                context,
                                'Diabetes Risk',
                                'Low',
                                'Lower than Normal',
                                riskDiabete(simulationQuestionnaire),
                                riskDiabete(normalValue)),
                          ],
                        ),
                  const SizedBox(height: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultsCard(BuildContext context, String title, String subtitle,
      String rank, double risk, double normalRisk) {
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
                    width: MediaQuery.of(context).size.width / 1.5,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text("you",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0)),
                            ),
                            Expanded(
                                child: LinearPercentIndicator(
                              alignment: MainAxisAlignment.spaceBetween,
                              lineHeight: 25,
                              animation: true,
                              animationDuration: 600,
                              animateFromLastPercent: true,
                              percent: risk / 100,
                              progressColor: _getRiskColor(risk),
                              backgroundColor: Colors.grey.shade200,
                            ))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text("Average people",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0)),
                            ),
                            Expanded(
                                child: LinearPercentIndicator(
                              alignment: MainAxisAlignment.spaceBetween,
                              lineHeight: 25,
                              animation: true,
                              animationDuration: 600,
                              animateFromLastPercent: true,
                              percent: normalRisk / 100,
                              progressColor: _getRiskColor(normalRisk),
                              backgroundColor: Colors.grey.shade200,
                            ))
                          ],
                        ),
                      ],
                    ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text("you",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0)),
                      ),
                      Expanded(
                          child: LinearPercentIndicator(
                        alignment: MainAxisAlignment.spaceBetween,
                        lineHeight: 25,
                        animation: true,
                        animationDuration: 600,
                        animateFromLastPercent: true,
                        percent: risk / 100,
                        progressColor: _getRiskColor(risk),
                        backgroundColor: Colors.grey.shade200,
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text("Average people",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0)),
                      ),
                      Expanded(
                          child: LinearPercentIndicator(
                        alignment: MainAxisAlignment.spaceBetween,
                        lineHeight: 25,
                        animation: true,
                        animationDuration: 600,
                        animateFromLastPercent: true,
                        percent: normalRisk / 100,
                        progressColor: _getRiskColor(normalRisk),
                        backgroundColor: Colors.grey.shade200,
                      ))
                    ],
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
}
