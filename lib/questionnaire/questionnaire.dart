import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:healthsim/questionnaire/ModelAnswer.dart';
import 'package:healthsim/questionnaire/boolean_custom/boolean_custom_step.dart';
import 'package:healthsim/questionnaire/range_double/range_double_step.dart';
import 'package:healthsim/questionnaire/range_integer/range_integer_step.dart';
import 'package:healthsim/questionnaire/scale_integer/scale_integer_step.dart';
import 'package:provider/provider.dart';
import 'package:survey_kit/survey_kit.dart';
import 'package:survey_kit/survey_kit.dart' as survey;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../authentification/user_provider.dart';
import '../result/result.dart';

class QuestionnairePage extends StatefulWidget {
  ModelAnswer? questionnaire;
  QuestionnairePage({super.key, this.questionnaire});

  @override
  _QuestionnaireState createState() => _QuestionnaireState();
}

class _QuestionnaireState extends State<QuestionnairePage> {
  var db = FirebaseFirestore.instance;
  int indexMemory = 0;

  List<dynamic> memoryResults = [
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
  ];

  intToBool(int val) {
    return val == 1 ? true : false;
  }

  @override
  void initState() {
    if (widget.questionnaire != null) // Come back from result page
    {
      ModelAnswer m = widget.questionnaire!;
      memoryResults = [
        null,
        intToBool(m.gender),
        m.age,
        m.height,
        m.weight,
        intToBool(m.glyc),
        intToBool(m.highSyst),
        intToBool(m.highChol),
        intToBool(m.diab),
        intToBool(m.inf),
        intToBool(m.avc),
        null,
        intToBool(m.afinf),
        intToBool(m.afcancer.toInt()),
        null,
        intToBool(m.smoke.toInt()),
        m.alim.toDouble(),
        m.sport.toDouble(),
        m.alcool.toDouble(),
        null,
      ];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //go research the user id
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.questionnairetitle),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                Color.fromRGBO(4, 66, 108, 1),
                Color.fromRGBO(0, 137, 207, 1.0)
              ])),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Align(
            alignment: Alignment.center,
            child: SurveyKit(
              surveyController:
                  SurveyController(onNextStep: (context, resultFunction) {
                memoryResults[indexMemory] = resultFunction().result;
                indexMemory++;
                print(memoryResults);
                setState(() {});
                BlocProvider.of<SurveyPresenter>(context).add(
                  NextStep(
                    resultFunction.call(),
                  ),
                );
              }, onStepBack: ((context, resultFunction) {
                indexMemory--;

                setState(() {});
                BlocProvider.of<SurveyPresenter>(context).add(
                  StepBack(
                    resultFunction != null ? resultFunction.call() : null,
                  ),
                );
              })),
              onResult: _onResult,
              task: getSampleTask(),
              showProgress: true,
              localizations: {
                'cancel': AppLocalizations.of(context)!.questionnairecancel,
                'next': AppLocalizations.of(context)!.questionnairenext,
              },
              themeData: Theme.of(context).copyWith(
                backgroundColor: Colors.white,
                primaryColor: Colors.cyan,
                appBarTheme: const AppBarTheme(
                  color: Colors.white,
                  iconTheme: IconThemeData(
                    color: Colors.cyan,
                  ),
                  titleTextStyle: TextStyle(
                    color: Colors.cyan,
                  ),
                ),
                iconTheme: const IconThemeData(
                  color: Colors.cyan,
                ),
                textSelectionTheme: const TextSelectionThemeData(
                  cursorColor: Colors.cyan,
                  selectionColor: Colors.cyan,
                  selectionHandleColor: Colors.cyan,
                ),
                cupertinoOverrideTheme: const CupertinoThemeData(
                  primaryColor: Colors.cyan,
                ),
                outlinedButtonTheme: OutlinedButtonThemeData(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                      const Size(150.0, 60.0),
                    ),
                    side: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> state) {
                        if (state.contains(MaterialState.disabled)) {
                          return const BorderSide(
                            color: Colors.grey,
                          );
                        }
                        return const BorderSide(
                          color: Colors.cyan,
                        );
                      },
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    textStyle: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> state) {
                        if (state.contains(MaterialState.disabled)) {
                          return Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                color: Colors.grey,
                              );
                        }
                        return Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Colors.cyan,
                            );
                      },
                    ),
                  ),
                ),
                textButtonTheme: TextButtonThemeData(
                  style: ButtonStyle(
                    textStyle: MaterialStateProperty.all(
                      Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Colors.cyan,
                          ),
                    ),
                  ),
                ),
                textTheme: const TextTheme(
                  displayMedium: TextStyle(
                    fontSize: 28.0,
                    color: Colors.black,
                  ),
                  headlineSmall: TextStyle(
                    fontSize: 24.0,
                    color: Colors.black,
                  ),
                  bodyMedium: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                  titleMedium: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                ),
                inputDecorationTheme: const InputDecorationTheme(
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
                colorScheme: ColorScheme.fromSwatch(
                  primarySwatch: Colors.cyan,
                )
                    .copyWith(
                      onPrimary: Colors.white,
                    )
                    .copyWith(background: Colors.white),
              ),
              surveyProgressbarConfiguration: SurveyProgressConfiguration(
                backgroundColor: Colors.white,
              ),
            )),
      ),
    );
    //return CircularProgressIndicator.adaptive();
  }

  _onResult(SurveyResult result) {
    late final user;
    try {
      user = Provider.of<UserProvider>(context).user?.id;
    } catch (e) {
      user = null;
    }
    if (result.finishReason == FinishReason.COMPLETED) {
      //See id the user is connected
      String userFinal;
      if (user == null) {
        userFinal = "Guest";
      } else {
        userFinal = user;
      }
      var mapped = result.results.map((e) => e.results.first.result).toList();
      print("${mapped.length} ${memoryResults.length}");

      //Pick the results and put it in variables
      bool gender = result.results.elementAt(1).results.first.result;
      int age = result.results.elementAt(2).results.first.result;
      int height = result.results.elementAt(3).results.first.result;
      int weight = result.results.elementAt(4).results.first.result;
      bool glyc = result.results.elementAt(5).results.first.result;
      bool highSyst = result.results.elementAt(6).results.first.result;
      double? syst;
      bool highChol = result.results.elementAt(7).results.first.result;
      double? chol;
      double? hdl;
      bool diab = result.results.elementAt(8).results.first.result;
      bool inf = result.results.elementAt(9).results.first.result;
      bool avc = result.results.elementAt(10).results.first.result;
      bool afinf = result.results.elementAt(12).results.first.result;
      bool afcancer = result.results.elementAt(13).results.first.result;
      bool smoke = result.results.elementAt(15).results.first.result;
      double alim = result.results.elementAt(16).results.first.result ?? 0,
          sport = result.results.elementAt(17).results.first.result ?? 0,
          alcool = result.results.elementAt(18).results.first.result ?? 0;
      /* double? syst = result.results.elementAt(7).results.first.result;
      bool highChol = result.results.elementAt(8).results.first.result;
      double? chol = result.results.elementAt(9).results.first.result;
      double? hdl = result.results.elementAt(10).results.first.result;
      bool diab = result.results.elementAt(11).results.first.result;
      bool inf = result.results.elementAt(12).results.first.result;
      bool avc = result.results.elementAt(13).results.first.result;
      bool afinf = result.results.elementAt(15).results.first.result;
      bool afcancer = result.results.elementAt(16).results.first.result;
      bool smoke = result.results.elementAt(18).results.first.result;
      double alim = result.results.elementAt(19).results.first.result ?? 0,
          sport = result.results.elementAt(20).results.first.result ?? 0,
          alcool = result.results.elementAt(21).results.first.result ?? 0; */

      print("$age $weight $height");

      //create new variable that be in the database
      int genderFinal,
          glycFinal,
          highSystFinal,
          highCholFinal,
          diabFinal,
          infFinal,
          avcFinal,
          afinfFinal;

      double afcancerFinal, smokeFinal;

      //change the boolean results in int
      genderFinal = gender ? 1 : 0;
      glycFinal = glyc ? 1 : 0;
      highSystFinal = highSyst ? 1 : 0;
      highCholFinal = highChol ? 1 : 0;
      diabFinal = diab ? 1 : 0;
      infFinal = inf ? 1 : 0;
      avcFinal = avc ? 1 : 0;
      afinfFinal = afinf ? 1 : 0;
      afcancerFinal = afcancer ? 1 : 0;
      smokeFinal = smoke ? 1 : 0;

      //put a value in the null values
      syst ??= -1;
      chol ??= -1;
      hdl ??= -1;
      syst = syst.toDouble();
      chol = chol.toDouble();
      hdl = hdl.toDouble();
      //Put all the answers in the Model
      final answers = ModelAnswer(
          genderFinal,
          age,
          height,
          weight,
          glycFinal,
          highSystFinal,
          syst,
          highCholFinal,
          chol,
          hdl,
          diabFinal,
          infFinal,
          avcFinal,
          afinfFinal,
          afcancerFinal,
          smokeFinal,
          alim.toInt(),
          sport.toInt(),
          alcool.toInt(),
          DateTime.now());

      //Put the model in a global value
      answers;

      //Put the answers in the database
      db
          .collection("users")
          .doc(userFinal)
          .collection("questionnaires")
          .add(answers.toJson());

      //go to the result page
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultPage(
              resultQuestionnaire: answers,
            ),
          ));
    } else {
      Navigator.pop(context);
    }
  }

  Task getSampleTask() {
    var task = OrderedTask(
      id: TaskIdentifier(id: Random().nextInt(800000000).toString()),
      steps: [
        //just information
        InstructionStep(
          title: AppLocalizations.of(context)!.questionnaireintrotitle,
          text: AppLocalizations.of(context)!.questionnaireintrotext,
          buttonText:
              AppLocalizations.of(context)!.questionnaireintrotextbutton,
        ),
        BooleanCustomStep(
          title: AppLocalizations.of(context)!.questionnairegendertitle,
          defaultVal: () {
            return memoryResults[1];
          },
          positiveAnswer:
              AppLocalizations.of(context)!.questionnairegenderanswerpositive,
          negativeAnswer:
              AppLocalizations.of(context)!.questionnairegenderanswernegative,
        ),
        RangeIntegerStep(
            title: AppLocalizations.of(context)!.questionnaireagetitle,
            minValue: 0,
            maxValue: 84,
            defaultVal: () {
              return memoryResults[2];
            },
            hint: AppLocalizations.of(context)!.questionnaireagehint,
            errorMessage: AppLocalizations.of(context)!.questionnaireageerror),
        RangeIntegerStep(
            title: AppLocalizations.of(context)!.questionnaireheighttitle,
            minValue: 0,
            maxValue: 250,
            defaultVal: () {
              return memoryResults[3];
            },
            hint: AppLocalizations.of(context)!.questionnaireheighthint,
            errorMessage:
                AppLocalizations.of(context)!.questionnaireheighterror),
        RangeIntegerStep(
            title: AppLocalizations.of(context)!.questionnaireweighttitle,
            hint: AppLocalizations.of(context)!.questionnaireweighthint,
            isOptional: false,
            minValue: 0,
            maxValue: 250,
            defaultVal: () {
              return memoryResults[4];
            },
            errorMessage:
                AppLocalizations.of(context)!.questionnaireweighterror),
        BooleanCustomStep(
          title: AppLocalizations.of(context)!.questionnaireglyctitle,
          defaultVal: () {
            return memoryResults[5] ?? false;
          },
          positiveAnswer: AppLocalizations.of(context)!.answerpositive,
          negativeAnswer: AppLocalizations.of(context)!.answernegative,
        ),

        BooleanCustomStep(
          title: AppLocalizations.of(context)!.questionnairehighsysttitle,
          defaultVal: () {
            return memoryResults[6] ?? false;
          },
          positiveAnswer: AppLocalizations.of(context)!.answerpositive,
          negativeAnswer: AppLocalizations.of(context)!.answernegative,
        ),

        /*  RangeDoubleStep(
            title: AppLocalizations.of(context)!.questionnairesysttitle,
            hint: AppLocalizations.of(context)!.questionnairesysthint,
            isOptional: true,
            minValue: 80,
            maxValue: 200,
            defaultVal: () {
              return memoryResults[7];
            },
            errorMessage: AppLocalizations.of(context)!.questionnairesysterror),
 */
        BooleanCustomStep(
          title: AppLocalizations.of(context)!.questionnairehighcholtitle,
          defaultVal: () {
            return memoryResults[7] ?? false;
          },
          positiveAnswer: AppLocalizations.of(context)!.answerpositive,
          negativeAnswer: AppLocalizations.of(context)!.answernegative,
        ),

        /*  RangeDoubleStep(
            title: AppLocalizations.of(context)!.questionnairecholtitle,
            hint: AppLocalizations.of(context)!.questionnairecholhint,
            isOptional: true,
            minValue: 2.5,
            maxValue: 8,
            defaultVal: () {
              return memoryResults[9];
            },
            errorMessage: AppLocalizations.of(context)!.questionnairecholerror),
 */
/*         RangeDoubleStep(
            title: AppLocalizations.of(context)!.questionnairehdltitle,
            hint: AppLocalizations.of(context)!.questionnairehdlhint,
            isOptional: true,
            minValue: 0.6,
            maxValue: 2.5,
            defaultVal: () {
              return memoryResults[10];
            },
            errorMessage: AppLocalizations.of(context)!.questionnairehdlerror),
 */
        BooleanCustomStep(
          title: AppLocalizations.of(context)!.questionnairediabtitle,
          defaultVal: () {
            return memoryResults[8] ?? false;
          },
          positiveAnswer: AppLocalizations.of(context)!.answerpositive,
          negativeAnswer: AppLocalizations.of(context)!.answernegative,
        ),

        BooleanCustomStep(
          title: AppLocalizations.of(context)!.questionnaireinftitle,
          defaultVal: () {
            return memoryResults[9] ?? false;
          },
          positiveAnswer: AppLocalizations.of(context)!.answerpositive,
          negativeAnswer: AppLocalizations.of(context)!.answernegative,
        ),
        BooleanCustomStep(
          title: AppLocalizations.of(context)!.questionnaireavctitle,
          defaultVal: () {
            return memoryResults[10] ?? false;
          },
          positiveAnswer: AppLocalizations.of(context)!.answerpositive,
          negativeAnswer: AppLocalizations.of(context)!.answernegative,
        ),

        InstructionStep(
            title: AppLocalizations.of(context)!.questionnairesecondparttitle,
            text: AppLocalizations.of(context)!.questionnairesecondparttext,
            buttonText: AppLocalizations.of(context)!
                .questionnairesecondparttextbutton),

        BooleanCustomStep(
          title: AppLocalizations.of(context)!.questionnaireafinftitle,
          defaultVal: () {
            return memoryResults[12] ?? false;
          },
          positiveAnswer: AppLocalizations.of(context)!.answerpositive,
          negativeAnswer: AppLocalizations.of(context)!.answernegative,
        ),

        BooleanCustomStep(
          title: AppLocalizations.of(context)!.questionnaireafcancertitle,
          defaultVal: () {
            return memoryResults[13] ?? false;
          },
          positiveAnswer: AppLocalizations.of(context)!.answerpositive,
          negativeAnswer: AppLocalizations.of(context)!.answernegative,
        ),

        InstructionStep(
            title: AppLocalizations.of(context)!.questionnairelastparttitle,
            text: AppLocalizations.of(context)!.questionnairelastparttext,
            buttonText:
                AppLocalizations.of(context)!.questionnairelastparttextbutton),

        BooleanCustomStep(
          title: AppLocalizations.of(context)!.questionnairesmoketitle,
          defaultVal: () {
            return memoryResults[15] ?? false;
          },
          positiveAnswer: AppLocalizations.of(context)!.answerpositive,
          negativeAnswer: AppLocalizations.of(context)!.answernegative,
        ),

        ScaleIntegerStep(
          title: AppLocalizations.of(context)!.questionnairealimtitle,
          text: AppLocalizations.of(context)!.questionnairealimtext,
          minValue: 0,
          maxValue: 3,
          defaultVal: () {
            return memoryResults[16] ?? 2;
          },
        ),
        ScaleIntegerStep(
          title: AppLocalizations.of(context)!.questionnairesporttitle,
          text: AppLocalizations.of(context)!.questionnairesporttext,
          minValue: 0,
          maxValue: 3,
          defaultVal: () {
            return memoryResults[17] ?? 2;
          },
        ),
        ScaleIntegerStep(
          title: AppLocalizations.of(context)!.questionnairealcooltitle,
          text: AppLocalizations.of(context)!.questionnairealcooltext,
          minValue: 0,
          maxValue: 4,
          defaultVal: () {
            return memoryResults[18] ?? 2;
          },
        ),

        CompletionStep(
          stepIdentifier: StepIdentifier(id: '23'),
          text: AppLocalizations.of(context)!.questionnairefinaltext,
          title: AppLocalizations.of(context)!.questionnairefinaltitle,
          buttonText:
              AppLocalizations.of(context)!.questionnairefinaltextbutton,
        ),
      ],
    );

    return task;
  }
}
