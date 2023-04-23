import 'package:flutter/material.dart';
import 'package:healthsim/navbar/navBar.dart';
import 'package:healthsim/questionnaire/ModelAnswer.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

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
  late double _drinkingValue;
  late double _eatingValue;
  double _exerciseValue = 2;
  late ModelAnswer simulationQuestionnaire;
  late ModelAnswer normalValue;
  late TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    initSimulation();
    super.initState();
  }

  void initSimulation() {
    simulationQuestionnaire = widget.resultQuestionnaire.copy();
    _isSmoking = simulationQuestionnaire.smoke == 1;
    _drinkingValue = simulationQuestionnaire.alcool.toDouble();
    _eatingValue = simulationQuestionnaire.alim.toDouble();
    _exerciseValue = simulationQuestionnaire.sport.toDouble();
    _controller.text = simulationQuestionnaire.weight.toString();
    if (simulationQuestionnaire.gender == 0) {
      normalValue = ModelAnswer(
          simulationQuestionnaire.gender,
          simulationQuestionnaire.age,
          173,
          79,
          -1,
          0,
          -1,
          0,
          -1,
          -1,
          0,
          simulationQuestionnaire.inf,
          simulationQuestionnaire.avc,
          0,
          0.03,
          0.5,
          2,
          1,
          3,
          DateTime.now());
    } else {
      normalValue = ModelAnswer(
          simulationQuestionnaire.gender,
          simulationQuestionnaire.age,
          178,
          83,
          -1,
          0,
          -1,
          0,
          -1,
          -1,
          0,
          simulationQuestionnaire.inf,
          simulationQuestionnaire.avc,
          0,
          0.08,
          0.5,
          2,
          1,
          3,
          DateTime.now());
    }
    print("riskCancer ${riskCancer(widget.resultQuestionnaire)}");
    print("riskDiab ${riskDiabete(widget.resultQuestionnaire)}");
    print("riskAVC ${riskAVC(widget.resultQuestionnaire)}");
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: NavBar(),
        toolbarHeight:
            screenWidth >= 600 && screenWidth < maxWidthScreen ? 100 : 200,
        backgroundColor: Colors.blue,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(4, 66, 108, 1),
                Color.fromRGBO(0, 137, 207, 1)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Row(children: [
                Expanded(
                    child: Text(
                  AppLocalizations.of(context)!.resultriskresulttitle,
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                )),
                Expanded(
                    child: Container(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                            onPressed: _createPDF,
                            child: Text(AppLocalizations.of(context)!
                                .resultprintbutton)))),
              ]),
              const SizedBox(height: 20),
              MediaQuery.of(context).size.width < 600
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildResultsCard(
                            context,
                            AppLocalizations.of(context)!.resultcancerrisktitle,
                            'Medium',
                            'Higher than Normal',
                            riskCancer(widget.resultQuestionnaire),
                            riskBaseCancer(normalValue)),
                        _buildResultsCard(
                            context,
                            AppLocalizations.of(context)!.resultinfrisktitle,
                            'High',
                            'Higher than Normal',
                            riskAVC(widget.resultQuestionnaire),
                            riskAVC(normalValue)),
                        _buildResultsCard(
                            context,
                            AppLocalizations.of(context)!.resultdiabrisktitle,
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
                            AppLocalizations.of(context)!.resultcancerrisktitle,
                            'Medium',
                            'Higher than Normal',
                            riskCancer(widget.resultQuestionnaire),
                            riskBaseCancer(normalValue)),
                        _buildResultsCard(
                            context,
                            AppLocalizations.of(context)!.resultinfrisktitle,
                            'High',
                            'Higher than Normal',
                            riskAVC(widget.resultQuestionnaire),
                            riskAVC(normalValue)),
                        _buildResultsCard(
                            context,
                            AppLocalizations.of(context)!.resultdiabrisktitle,
                            'Low',
                            'Lower than Normal',
                            riskDiabete(widget.resultQuestionnaire),
                            riskDiabete(normalValue)),
                      ],
                    ),
              const SizedBox(height: 20),
              //Comparative
/*               Table(
                columnWidths: const <int, TableColumnWidth>{
                  0: FlexColumnWidth(),
                  1: FlexColumnWidth(),
                  2: FlexColumnWidth()
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(children: [
                    const Text(""),
                    Text(
                      AppLocalizations.of(context)!
                          .resultcomparationtitlesecondcolunm,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.blue[900]),
                    ),
                    Text(
                        AppLocalizations.of(context)!
                            .resultcomparationtitlelastcolunm,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.blue[900])),
                  ]),
                  TableRow(children: [
                    Text(
                        AppLocalizations.of(context)!
                            .resultcomparationtitlefirstrow,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.blue[900])),
                    Text("${widget.resultQuestionnaire.sport}",
                        style: const TextStyle(fontSize: 16)),
                    Text("${normalValue.sport}",
                        style: const TextStyle(fontSize: 16)),
                  ]),
                  TableRow(children: [
                    Text(
                        AppLocalizations.of(context)!
                            .resultcomparationtitlesecondrow,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.blue[900])),
                    Text("${widget.resultQuestionnaire.alim}",
                        style: const TextStyle(fontSize: 16)),
                    Text("${normalValue.alim}",
                        style: const TextStyle(fontSize: 16)),
                  ]),
                  TableRow(children: [
                    Text(
                        AppLocalizations.of(context)!
                            .resultcomparationtitlethirdrow,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.blue[900])),
                    Text("${widget.resultQuestionnaire.alcool}",
                        style: const TextStyle(fontSize: 16)),
                    Text("${normalValue.alcool}",
                        style: const TextStyle(fontSize: 16)),
                  ]),
                  TableRow(children: [
                    Text(
                        AppLocalizations.of(context)!
                            .resultcomparationtitlelastrow,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.blue[900])),
                    Container(
                        child: widget.resultQuestionnaire.smoke == 1
                            ? Text(AppLocalizations.of(context)!.answerpositive,
                                style: TextStyle(fontSize: 16))
                            : Text(AppLocalizations.of(context)!.answernegative,
                                style: TextStyle(fontSize: 16))),
                    const Text("50 %", style: TextStyle(fontSize: 16))
                  ]),
                ],
              ),
 */
              const SizedBox(height: 20),
              //simulation part
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    AppLocalizations.of(context)!.resultsimulationtitle,
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
                      child: Text(AppLocalizations.of(context)!
                          .resultsimulationresetbutton)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                          child: Text(AppLocalizations.of(context)!
                              .resultsimulationweight)),
                      // Form(
                      //     child:
                      Expanded(
                          child: Wrap(
                              direction: Axis.horizontal,
                              children: <Widget>[
                            TextField(
                              controller: _controller,
                              onChanged: (newValue) {
                                int newValueInt = int.parse(newValue);
                                setState(() {
                                  //_controller.text = newValue;
                                  simulationQuestionnaire.weight = newValueInt;
                                });
                              },
                            )
                          ])),
                      // ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(AppLocalizations.of(context)!.resultsimulationinfo),
                  const SizedBox(height: 10),
                  MediaQuery.of(context).size.width < 600
                      ? Column(children: [
                          Row(
                            children: [
                              Expanded(
                                child: SwitchListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(AppLocalizations.of(context)!
                                      .resultsimulationsmokebutton),
                                  value: _isSmoking,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _isSmoking = newValue;
                                      simulationQuestionnaire.smoke =
                                          newValue ? 1 : 0;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 300),
                          Row(
                            children: [
                              mySimulatorLine(
                                  title: AppLocalizations.of(context)!
                                      .resultsimulationalcool,
                                  value: _drinkingValue,
                                  min: 0,
                                  max: 4,
                                  divisions: 4,
                                  onChanged: (value) {
                                    setState(() {
                                      _drinkingValue = value;
                                      simulationQuestionnaire.alcool =
                                          value.toInt();
                                    });
                                  }),
/*                               Expanded(
                                child: MediaQuery.of(context).size.width < 600
                                    ? Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .resultsimulationalcool,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue[900],
                                                ),
                                              ),
                                              Text(
                                                '$_drinkingValue',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue[900],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Slider(
                                            value: _drinkingValue,
                                            min: 0,
                                            max: 3,
                                            divisions: 3,
                                            label: _drinkingValue
                                                .round()
                                                .toString(),
                                            onChanged: (value) {
                                              setState(() {
                                                _drinkingValue = value;
                                                simulationQuestionnaire.alcool =
                                                    value.toInt();
                                              });
                                            },
                                          )
                                        ],
                                      )
                                    : Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .resultsimulationalcool,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue[900],
                                                ),
                                              ),
                                              Text(
                                                '$_drinkingValue',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue[900],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Slider(
                                            value: _drinkingValue,
                                            min: 0,
                                            max: 3,
                                            divisions: 3,
                                            label: _drinkingValue
                                                .round()
                                                .toString(),
                                            onChanged: (value) {
                                              setState(() {
                                                _drinkingValue = value;
                                                simulationQuestionnaire.alcool =
                                                    value.toInt();
                                              });
                                            },
                                          )
                                        ],
                                      ),
                              ),
                             */
                            ],
                          ),
                        ])
                      : Row(children: [
                          Expanded(
                            child: SwitchListTile(
                              title: Text(AppLocalizations.of(context)!
                                  .resultsimulationsmokebutton),
                              value: _isSmoking,
                              onChanged: (newValue) {
                                setState(() {
                                  _isSmoking = newValue;
                                  simulationQuestionnaire.smoke =
                                      newValue ? 1 : 0;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 50),
                          mySimulatorLine(
                              title: AppLocalizations.of(context)!
                                  .resultsimulationalcool,
                              value: _drinkingValue,
                              min: 0,
                              max: 4,
                              divisions: 4,
                              onChanged: (value) {
                                setState(() {
                                  _drinkingValue = value;
                                  simulationQuestionnaire.alcool =
                                      value.toInt();
                                });
                              }),
/*                           Expanded(
                              child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .resultsimulationalcool,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue[900],
                                    ),
                                  ),
                                  Text(
                                    '$_drinkingValue',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue[900],
                                    ),
                                  ),
                                ],
                              ),
                              Slider(
                                value: _drinkingValue,
                                min: 0,
                                max: 3,
                                divisions: 3,
                                label: _drinkingValue.round().toString(),
                                onChanged: (value) {
                                  setState(() {
                                    _drinkingValue = value;
                                    simulationQuestionnaire.alcool =
                                        value.toInt();
                                  });
                                },
                              )
                            ],
                          )), */
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
                                      mySimulatorLine(
                                          title: AppLocalizations.of(context)!
                                              .resultsimulationalim,
                                          value: _eatingValue,
                                          min: 0,
                                          max: 3,
                                          divisions: 3,
                                          onChanged: (value) {
                                            setState(() {
                                              _eatingValue = value;
                                              simulationQuestionnaire.alim =
                                                  value.toInt();
                                            });
                                          }),
                                    ]),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Column(children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  mySimulatorLine(
                                      title: AppLocalizations.of(context)!
                                          .resultsimulationsport,
                                      value: _exerciseValue,
                                      min: 0,
                                      max: 3,
                                      divisions: 3,
                                      onChanged: (value) {
                                        setState(() {
                                          _exerciseValue = value;
                                          simulationQuestionnaire.sport =
                                              value.toInt();
                                        });
                                      }),
                                ],
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
                                      mySimulatorLine(
                                          title: AppLocalizations.of(context)!
                                              .resultsimulationalim,
                                          value: _eatingValue,
                                          min: 0,
                                          max: 3,
                                          divisions: 3,
                                          onChanged: (value) {
                                            setState(() {
                                              _eatingValue = value;
                                              simulationQuestionnaire.alim =
                                                  value.toInt();
                                            });
                                          }),
                                    ],
                                  ),
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
                                    mySimulatorLine(
                                        title: AppLocalizations.of(context)!
                                            .resultsimulationsport,
                                        value: _exerciseValue,
                                        min: 0,
                                        max: 3,
                                        divisions: 3,
                                        onChanged: (value) {
                                          setState(() {
                                            _exerciseValue = value;
                                            simulationQuestionnaire.sport =
                                                value.toInt();
                                          });
                                        }),
                                  ],
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
                                AppLocalizations.of(context)!
                                    .resultcancerrisktitle,
                                'Medium',
                                'Higher than Normal',
                                riskCancer(simulationQuestionnaire),
                                riskBaseCancer(normalValue)),
                            _buildResultsCard(
                                context,
                                AppLocalizations.of(context)!
                                    .resultinfrisktitle,
                                'High',
                                'Higher than Normal',
                                riskAVC(simulationQuestionnaire),
                                riskAVC(normalValue)),
                            _buildResultsCard(
                                context,
                                AppLocalizations.of(context)!
                                    .resultdiabrisktitle,
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
                                AppLocalizations.of(context)!
                                    .resultcancerrisktitle,
                                'Medium',
                                'Higher than Normal',
                                riskCancer(simulationQuestionnaire),
                                riskBaseCancer(normalValue)),
                            _buildResultsCard(
                                context,
                                AppLocalizations.of(context)!
                                    .resultinfrisktitle,
                                'High',
                                'Higher than Normal',
                                riskAVC(simulationQuestionnaire),
                                riskAVC(normalValue)),
                            _buildResultsCard(
                                context,
                                AppLocalizations.of(context)!
                                    .resultdiabrisktitle,
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
                              child: Text(
                                  AppLocalizations.of(context)!.resultcardyou,
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
                              child: Text(
                                  AppLocalizations.of(context)!
                                      .resultcardavgpeople,
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
                        child: Text(AppLocalizations.of(context)!.resultcardyou,
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
                        child: Text(
                            AppLocalizations.of(context)!.resultcardavgpeople,
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

  void _createPDF() async {
    final doc = pw.Document();
    var alimText = [
      AppLocalizations.of(context)!.answeralim0,
      AppLocalizations.of(context)!.answeralim1,
      AppLocalizations.of(context)!.answeralim2,
      AppLocalizations.of(context)!.answeralim3
    ];
    var sportText = [
      AppLocalizations.of(context)!.answersport0,
      AppLocalizations.of(context)!.answersport1,
      AppLocalizations.of(context)!.answersport2,
      AppLocalizations.of(context)!.answersport3
    ];
    var alcoolText = [
      AppLocalizations.of(context)!.answeralcool0,
      AppLocalizations.of(context)!.answeralcool1,
      AppLocalizations.of(context)!.answeralcool2,
      AppLocalizations.of(context)!.answeralcool3,
      AppLocalizations.of(context)!.answeralcool4
    ];

    var gender = "",
        glyc = "",
        syst = "",
        chol = "",
        diab = "",
        inf = "",
        avc = "",
        afinf = "",
        afcancer = "",
        smoke = "",
        alim = alimText.elementAt(widget.resultQuestionnaire.alim),
        sport = sportText.elementAt(widget.resultQuestionnaire.sport),
        alcool = alcoolText.elementAt(widget.resultQuestionnaire.alcool);

    if (widget.resultQuestionnaire.gender == 1) {
      gender = AppLocalizations.of(context)!.questionnairegenderanswerpositive;
    } else {
      gender = AppLocalizations.of(context)!.questionnairegenderanswernegative;
    }
    if (widget.resultQuestionnaire.glyc == 1) {
      glyc = AppLocalizations.of(context)!.answerpositive;
    } else {
      glyc = AppLocalizations.of(context)!.answernegative;
    }
    if (widget.resultQuestionnaire.syst == 1) {
      syst = AppLocalizations.of(context)!.answerpositive;
    } else {
      syst = AppLocalizations.of(context)!.answernegative;
    }
    if (widget.resultQuestionnaire.chol == 1) {
      chol = AppLocalizations.of(context)!.answerpositive;
    } else {
      chol = AppLocalizations.of(context)!.answernegative;
    }
    if (widget.resultQuestionnaire.diab == 1) {
      diab = AppLocalizations.of(context)!.answerpositive;
    } else {
      diab = AppLocalizations.of(context)!.answernegative;
    }
    if (widget.resultQuestionnaire.inf == 1) {
      inf = AppLocalizations.of(context)!.answerpositive;
    } else {
      inf = AppLocalizations.of(context)!.answernegative;
    }
    if (widget.resultQuestionnaire.avc == 1) {
      avc = AppLocalizations.of(context)!.answerpositive;
    } else {
      avc = AppLocalizations.of(context)!.answernegative;
    }
    if (widget.resultQuestionnaire.afinf == 1) {
      afinf = AppLocalizations.of(context)!.answerpositive;
    } else {
      afinf = AppLocalizations.of(context)!.answernegative;
    }
    if (widget.resultQuestionnaire.afcancer == 1) {
      afcancer = AppLocalizations.of(context)!.answerpositive;
    } else {
      afcancer = AppLocalizations.of(context)!.answernegative;
    }
    if (widget.resultQuestionnaire.smoke == 1) {
      smoke = AppLocalizations.of(context)!.answerpositive;
    } else {
      smoke = AppLocalizations.of(context)!.answernegative;
    }

    var questionsTitle = AppLocalizations.of(context)!.printtitlequestion,
        answerTitle = AppLocalizations.of(context)!.printtitleanswer;

    var genderTitle = AppLocalizations.of(context)!.questionnairegendertitle,
        ageTitle = AppLocalizations.of(context)!.questionnaireagetitle,
        heightTitle = AppLocalizations.of(context)!.questionnaireheighttitle,
        weightTitle = AppLocalizations.of(context)!.questionnaireweighttitle,
        glycTitle = AppLocalizations.of(context)!.questionnaireglyctitle,
        highSystTitle =
            AppLocalizations.of(context)!.questionnairehighsysttitle,
        highCholTitle =
            AppLocalizations.of(context)!.questionnairehighcholtitle,
        diabTitle = AppLocalizations.of(context)!.questionnairediabtitle,
        infTitle = AppLocalizations.of(context)!.questionnaireinftitle,
        avcTitle = AppLocalizations.of(context)!.questionnaireavctitle,
        afinfTitle = AppLocalizations.of(context)!.questionnaireafinftitle,
        afcancerTitle =
            AppLocalizations.of(context)!.questionnaireafcancertitle,
        smokeTitle = AppLocalizations.of(context)!.questionnairesmoketitle,
        alimTitle = AppLocalizations.of(context)!.questionnairealimtitle,
        sportTitle = AppLocalizations.of(context)!.questionnairesporttitle,
        alcoolTitle = AppLocalizations.of(context)!.questionnairealcooltitle;

    var riskTitle = AppLocalizations.of(context)!.resulttitle,
        cancerRiskTitle = AppLocalizations.of(context)!.resultcancerrisktitle,
        avcRiskTitle = AppLocalizations.of(context)!.resultinfrisktitle,
        diabeteRiskTitle = AppLocalizations.of(context)!.resultdiabrisktitle;

    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Table(columnWidths: const <int, pw.TableColumnWidth>{
            0: pw.FlexColumnWidth(),
            1: pw.FixedColumnWidth(20),
            2: pw.FixedColumnWidth(100),
          }, children: [
            pw.TableRow(children: [
              pw.Text("HealtSim",
                  style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.blue900)),
              pw.SizedBox(width: 10),
              pw.Text(""),
            ]),
            pw.TableRow(children: [pw.SizedBox(height: 30)]),
            pw.TableRow(children: [
              pw.Text(questionsTitle,
                  style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.blue900)),
              pw.SizedBox(width: 10),
              pw.Text(answerTitle,
                  style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.blue900))
            ]),
            pw.TableRow(children: [pw.SizedBox(height: 20)]),
            pw.TableRow(children: [
              pw.Text(genderTitle),
              pw.SizedBox(width: 10),
              pw.Text(gender),
            ]),
            pw.TableRow(children: [pw.SizedBox(height: 5)]),
            pw.TableRow(children: [
              pw.Text(ageTitle),
              pw.SizedBox(width: 10),
              pw.Text(widget.resultQuestionnaire.age.toString()),
            ]),
            pw.TableRow(children: [pw.SizedBox(height: 5)]),
            pw.TableRow(children: [
              pw.Text(heightTitle),
              pw.SizedBox(width: 10),
              pw.Text(widget.resultQuestionnaire.height.toString()),
            ]),
            pw.TableRow(children: [pw.SizedBox(height: 5)]),
            pw.TableRow(children: [
              pw.Text(weightTitle),
              pw.SizedBox(width: 10),
              pw.Text(widget.resultQuestionnaire.weight.toString())
            ]),
            pw.TableRow(children: [pw.SizedBox(height: 5)]),
            pw.TableRow(children: [
              pw.Text(glycTitle),
              pw.SizedBox(width: 10),
              pw.Text(glyc),
            ]),
            pw.TableRow(children: [pw.SizedBox(height: 5)]),
            pw.TableRow(children: [
              pw.Text(highSystTitle),
              pw.SizedBox(width: 10),
              pw.Text(syst),
            ]),
            pw.TableRow(children: [pw.SizedBox(height: 5)]),
            pw.TableRow(children: [
              pw.Text(highCholTitle),
              pw.SizedBox(width: 10),
              pw.Text(chol),
            ]),
            pw.TableRow(children: [pw.SizedBox(height: 5)]),
            pw.TableRow(children: [
              pw.Text(diabTitle),
              pw.SizedBox(width: 10),
              pw.Text(diab),
            ]),
            pw.TableRow(children: [pw.SizedBox(height: 5)]),
            pw.TableRow(children: [
              pw.Text(infTitle),
              pw.SizedBox(width: 10),
              pw.Text(inf),
            ]),
            pw.TableRow(children: [pw.SizedBox(height: 5)]),
            pw.TableRow(children: [
              pw.Text(avcTitle),
              pw.SizedBox(width: 10),
              pw.Text(avc),
            ]),
            pw.TableRow(children: [pw.SizedBox(height: 5)]),
            pw.TableRow(children: [
              pw.Text(afinfTitle),
              pw.SizedBox(width: 10),
              pw.Text(afinf),
            ]),
            pw.TableRow(children: [pw.SizedBox(height: 5)]),
            pw.TableRow(children: [
              pw.Text(afcancerTitle),
              pw.SizedBox(width: 10),
              pw.Text(afcancer),
            ]),
            pw.TableRow(children: [pw.SizedBox(height: 5)]),
            pw.TableRow(children: [
              pw.Text(smokeTitle),
              pw.SizedBox(width: 10),
              pw.Text(smoke),
            ]),
            pw.TableRow(children: [pw.SizedBox(height: 5)]),
            pw.TableRow(children: [
              pw.Text(alimTitle),
              pw.SizedBox(width: 10),
              pw.Text(alim),
            ]),
            pw.TableRow(children: [pw.SizedBox(height: 5)]),
            pw.TableRow(children: [
              pw.Text(sportTitle),
              pw.SizedBox(width: 10),
              pw.Text(sport),
            ]),
            pw.TableRow(children: [pw.SizedBox(height: 5)]),
            pw.TableRow(children: [
              pw.Text(alcoolTitle),
              pw.SizedBox(width: 10),
              pw.Text(alcool),
            ]),
            pw.TableRow(children: [pw.SizedBox(height: 5)]),
            pw.TableRow(children: [pw.SizedBox(height: 20)]),
            pw.TableRow(children: [pw.SizedBox(height: 5)]),
            pw.TableRow(children: [
              pw.Text(riskTitle,
                  style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.blue900)),
              pw.SizedBox(width: 10),
              pw.Text("")
            ]),
            pw.TableRow(children: [pw.SizedBox(height: 20)]),
            pw.TableRow(children: [
              pw.Text(cancerRiskTitle),
              pw.SizedBox(width: 10),
              pw.Text("${riskCancer(widget.resultQuestionnaire).toString()} %")
            ]),
            pw.TableRow(children: [pw.SizedBox(height: 5)]),
            pw.TableRow(children: [
              pw.Text(avcRiskTitle),
              pw.SizedBox(width: 10),
              pw.Text("${riskAVC(widget.resultQuestionnaire).toString()} %")
            ]),
            pw.TableRow(children: [pw.SizedBox(height: 5)]),
            pw.TableRow(children: [
              pw.Text(diabeteRiskTitle),
              pw.SizedBox(width: 10),
              pw.Text("${riskDiabete(widget.resultQuestionnaire).toString()} %")
            ]),
          ]); // Center
        }));

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }
}

Widget mySimulatorLine(
    {required String title,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required Function(double) onChanged}) {
  return Expanded(
      child: Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue[900],
            ),
          ),
          Text(
            '$value',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue[900],
            ),
          ),
        ],
      ),
      Slider(
        value: value,
        min: min,
        max: max,
        divisions: divisions,
        label: value.round().toString(),
        onChanged: onChanged,
      )
    ],
  ));
}
