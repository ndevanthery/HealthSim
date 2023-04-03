import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthsim/questionnaire/ModelAnswer.dart';
import 'package:provider/provider.dart';
import 'package:survey_kit/survey_kit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../authentification/user_provider.dart';
import '../result/result.dart';

class QuestionnairePage extends StatefulWidget {
  QuestionnairePage({super.key});

  @override
  _QuestionnaireState createState() => _QuestionnaireState();
}

class _QuestionnaireState extends State<QuestionnairePage> {
  var db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    //go research the user id
    final user = Provider.of<UserProvider>(context).user?.id;
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
              onResult: (SurveyResult result) {
                if (result.finishReason == FinishReason.COMPLETED) {
                  //See id the user is connected
                  String userFinal;
                  if (user == null) {
                    userFinal = "Guest";
                  } else {
                    userFinal = user;
                  }

                  //Pick the results and put it in variables
                  var gender = result.results.elementAt(1).results.first.result,
                      age = result.results.elementAt(2).results.first.result,
                      height = result.results.elementAt(3).results.first.result,
                      weight = result.results.elementAt(4).results.first.result,
                      glyc = result.results.elementAt(5).results.first.result,
                      highSyst =
                          result.results.elementAt(6).results.first.result,
                      syst = result.results.elementAt(7).results.first.result,
                      highChol =
                          result.results.elementAt(8).results.first.result,
                      chol = result.results.elementAt(9).results.first.result,
                      hdl = result.results.elementAt(10).results.first.result,
                      diab = result.results.elementAt(11).results.first.result,
                      inf = result.results.elementAt(12).results.first.result,
                      avc = result.results.elementAt(13).results.first.result,
                      afinf = result.results.elementAt(15).results.first.result,
                      afcancer =
                          result.results.elementAt(16).results.first.result,
                      smoke = result.results.elementAt(18).results.first.result;
                  double alim =
                          result.results.elementAt(19).results.first.result,
                      sport = result.results.elementAt(20).results.first.result,
                      alcool =
                          result.results.elementAt(21).results.first.result;

                  //create new variable that be in the database
                  int genderFinal,
                      glycFinal,
                      highSystFinal,
                      highCholFinal,
                      diabFinal,
                      infFinal,
                      avcFinal,
                      afinfFinal;

                  double afcancerFinal,
                         smokeFinal;


                  //change the boolean results in int
                  if (gender == BooleanResult.POSITIVE) {
                    genderFinal = 1;
                  } else {
                    genderFinal = 0;
                  }
                  if (glyc == BooleanResult.POSITIVE) {
                    glycFinal = 1;
                  } else {
                    glycFinal = 0;
                  }
                  if (highSyst == BooleanResult.POSITIVE) {
                    highSystFinal = 1;
                  } else {
                    highSystFinal = 0;
                  }

                  if (highChol == BooleanResult.POSITIVE) {
                    highCholFinal = 1;
                  } else {
                    highCholFinal = 0;
                  }
                  if (diab == BooleanResult.POSITIVE) {
                    diabFinal = 1;
                  } else {
                    diabFinal = 0;
                  }
                  if (inf == BooleanResult.POSITIVE) {
                    infFinal = 1;
                  } else {
                    infFinal = 0;
                  }
                  if (avc == BooleanResult.POSITIVE) {
                    avcFinal = 1;
                  } else {
                    avcFinal = 0;
                  }
                  if (afinf == BooleanResult.POSITIVE) {
                    afinfFinal = 1;
                  } else {
                    afinfFinal = 0;
                  }
                  if (afcancer == BooleanResult.POSITIVE) {
                    afcancerFinal = 1.0;
                  } else {
                    afcancerFinal = 0.0;
                  }
                  if (smoke == BooleanResult.POSITIVE) {
                    smokeFinal = 1.0;
                  } else {
                    smokeFinal = 0.0;
                  }

                  //put a value in the null values
                  syst ??= -1;
                  chol ??= -1;
                  hdl ??= -1;

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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultPage(
                          resultQuestionnaire: answers,
                        ),
                      ));
                } else {
                  Navigator.pop(context);
                }
              },
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

  Task getSampleTask() {
    //see all the questions in this order
    var task = OrderedTask(
      id: TaskIdentifier(),
      steps: [
        //just information
        InstructionStep(
          title: AppLocalizations.of(context)!.questionnaireintrotitle,
          text: AppLocalizations.of(context)!.questionnaireintrotext,
          buttonText: AppLocalizations.of(context)!.questionnaireintrotextbutton,
        ),
        QuestionStep(
          title: AppLocalizations.of(context)!.questionnairegendertitle,
          answerFormat: BooleanAnswerFormat(
            positiveAnswer: AppLocalizations.of(context)!.questionnairegenderanswerpositive,
            negativeAnswer: AppLocalizations.of(context)!.questionnairegenderanswernegative,
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: AppLocalizations.of(context)!.questionnaireagetitle,
          answerFormat: IntegerAnswerFormat(
            hint: AppLocalizations.of(context)!.questionnaireagehint,
          ),
          isOptional: false,
        ),
        QuestionStep(
          title: AppLocalizations.of(context)!.questionnaireheighttitle,
          answerFormat: IntegerAnswerFormat(
            hint: AppLocalizations.of(context)!.questionnaireheighthint,
          ),
          isOptional: false,
        ),
        QuestionStep(
          title: AppLocalizations.of(context)!.questionnaireweighttitle,
          answerFormat: IntegerAnswerFormat(
            hint: AppLocalizations.of(context)!.questionnaireweighthint,
          ),
          isOptional: false,
        ),
        QuestionStep(
          title: AppLocalizations.of(context)!.questionnaireglyctitle,
          answerFormat: BooleanAnswerFormat(
            positiveAnswer: AppLocalizations.of(context)!.answerpositive,
            negativeAnswer: AppLocalizations.of(context)!.answernegative,
            result: BooleanResult.NEGATIVE,
          ),
          isOptional: false,
        ),
        QuestionStep(
          title: AppLocalizations.of(context)!.questionnairehighsysttitle,
          answerFormat: BooleanAnswerFormat(
            positiveAnswer: AppLocalizations.of(context)!.answerpositive,
            negativeAnswer: AppLocalizations.of(context)!.answernegative,
            result: BooleanResult.NEGATIVE,
          ),
        ),
        QuestionStep(
          title: AppLocalizations.of(context)!.questionnairesysttitle,
          answerFormat: IntegerAnswerFormat(
            hint: AppLocalizations.of(context)!.questionnairesysthint,
          ),
          isOptional: true,
        ),
        QuestionStep(
          title: AppLocalizations.of(context)!.questionnairehighcholtitle,
          answerFormat: BooleanAnswerFormat(
            positiveAnswer: AppLocalizations.of(context)!.answerpositive,
            negativeAnswer: AppLocalizations.of(context)!.answernegative,
            result: BooleanResult.NEGATIVE,
          ),
        ),
        QuestionStep(
          title: AppLocalizations.of(context)!.questionnairecholtitle,
          answerFormat: IntegerAnswerFormat(
            hint: AppLocalizations.of(context)!.questionnairecholhint,
          ),
          isOptional: true,
        ),
        QuestionStep(
          title: AppLocalizations.of(context)!.questionnairehdltitle,
          answerFormat: IntegerAnswerFormat(
            hint: AppLocalizations.of(context)!.questionnairehdlhint,
          ),
          isOptional: true,
        ),
        QuestionStep(
          title: AppLocalizations.of(context)!.questionnairediabtitle,
          answerFormat: BooleanAnswerFormat(
            positiveAnswer: AppLocalizations.of(context)!.answerpositive,
            negativeAnswer: AppLocalizations.of(context)!.answernegative,
            result: BooleanResult.NEGATIVE,
          ),
        ),
        QuestionStep(
          title: AppLocalizations.of(context)!.questionnaireinftitle,
          answerFormat: BooleanAnswerFormat(
            positiveAnswer: AppLocalizations.of(context)!.answerpositive,
            negativeAnswer: AppLocalizations.of(context)!.answernegative,
            result: BooleanResult.NEGATIVE,
          ),
        ),
        QuestionStep(
          title: AppLocalizations.of(context)!.questionnaireavctitle,
          answerFormat: BooleanAnswerFormat(
            positiveAnswer: AppLocalizations.of(context)!.answerpositive,
            negativeAnswer: AppLocalizations.of(context)!.answernegative,
            result: BooleanResult.NEGATIVE,
          ),
        ),
        InstructionStep(
            title: AppLocalizations.of(context)!.questionnairesecondparttitle,
            text: AppLocalizations.of(context)!.questionnairesecondparttext,
            buttonText: AppLocalizations.of(context)!.questionnairesecondparttextbutton),
        QuestionStep(
          title: AppLocalizations.of(context)!.questionnaireafinftitle,
          answerFormat: BooleanAnswerFormat(
            positiveAnswer: AppLocalizations.of(context)!.answerpositive,
            negativeAnswer: AppLocalizations.of(context)!.answernegative,
            result: BooleanResult.NEGATIVE,
          ),
        ),
        QuestionStep(
          title: AppLocalizations.of(context)!.questionnaireafcancertitle,
          answerFormat: BooleanAnswerFormat(
            positiveAnswer: AppLocalizations.of(context)!.answerpositive,
            negativeAnswer: AppLocalizations.of(context)!.answernegative,
            result: BooleanResult.NEGATIVE,
          ),
        ),
        InstructionStep(
            title: AppLocalizations.of(context)!.questionnairelastparttitle,
            text: AppLocalizations.of(context)!.questionnairelastparttext,
            buttonText: AppLocalizations.of(context)!.questionnairelastparttextbutton),
        QuestionStep(
          title: AppLocalizations.of(context)!.questionnairesmoketitle,
          answerFormat: BooleanAnswerFormat(
            positiveAnswer: AppLocalizations.of(context)!.answerpositive,
            negativeAnswer: AppLocalizations.of(context)!.answernegative,
            result: BooleanResult.NEGATIVE,
          ),
        ),
        QuestionStep(
          title: AppLocalizations.of(context)!.questionnairealimtitle,
          text: AppLocalizations.of(context)!.questionnairealimtext,
          answerFormat: ScaleAnswerFormat(
            step: 1,
            minimumValue: 0,
            maximumValue: 3,
            defaultValue: 2,
            minimumValueDescription: AppLocalizations.of(context)!.questionnairealimminvalue,
            maximumValueDescription: AppLocalizations.of(context)!.questionnairealimmaxvalue,
          ),
        ),
        QuestionStep(
          title: AppLocalizations.of(context)!.questionnairesporttitle,
          text: AppLocalizations.of(context)!.questionnairesporttext,
          answerFormat: ScaleAnswerFormat(
            step: 1,
            minimumValue: 0,
            maximumValue: 3,
            defaultValue: 2,
            minimumValueDescription: AppLocalizations.of(context)!.questionnairesportminvalue,
            maximumValueDescription: AppLocalizations.of(context)!.questionnairesportmaxvalue,
          ),
        ),
        QuestionStep(
          title: AppLocalizations.of(context)!.questionnairealcooltitle,
          text: AppLocalizations.of(context)!.questionnairealcooltext,
          answerFormat: ScaleAnswerFormat(
            step: 1,
            minimumValue: 0,
            maximumValue: 4,
            defaultValue: 2,
            minimumValueDescription: AppLocalizations.of(context)!.questionnairealcoolminvalue,
            maximumValueDescription: AppLocalizations.of(context)!.questionnairealcoolmaxvalue,
          ),
        ),
        CompletionStep(
          stepIdentifier: StepIdentifier(id: '23'),
          text: AppLocalizations.of(context)!.questionnairefinaltext,
          title: AppLocalizations.of(context)!.questionnairefinaltitle,
          buttonText: AppLocalizations.of(context)!.questionnairefinaltextbutton,
        ),
      ],
    );

    return task;
  }
}
