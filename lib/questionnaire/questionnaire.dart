import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthsim/questionnaire/ModelAnswer.dart';
import 'package:provider/provider.dart';
import 'package:survey_kit/survey_kit.dart';

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
        title: const Text("Questionnaire"),
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
                      afinfFinal,
                      afcancerFinal,
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
                    afcancerFinal = 1;
                  } else {
                    afcancerFinal = 0;
                  }
                  if (smoke == BooleanResult.POSITIVE) {
                    smokeFinal = 1;
                  } else {
                    smokeFinal = 0;
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
              localizations: const {
                'cancel': 'Cancel',
                'next': 'Next',
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
          title:
              'Ce questionnaire est divisée en 3 partie et en voici la première',
          text:
              'Toi-même\n Si vous n\'avez pas de réponse pour certaines questions passer directement à la prochaine',
          buttonText: 'C\'est partie !',
        ),
        QuestionStep(
          title: 'Quel est votre genre?',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'Femme',
            negativeAnswer: 'Homme',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Quel âge avez-vous ?',
          answerFormat: const IntegerAnswerFormat(
            hint: 'Entrez votre âge',
          ),
          isOptional: false,
        ),
        QuestionStep(
          title: 'Quel est votre taille en cm ?',
          answerFormat: const IntegerAnswerFormat(
            hint: 'Entrez votre taille',
          ),
          isOptional: false,
        ),
        QuestionStep(
          title: 'Quel est votre poids en kg ?',
          answerFormat: const IntegerAnswerFormat(
            hint: 'Entrez votre poids',
          ),
          isOptional: false,
        ),
        QuestionStep(
          title: 'Etes-vous connus pour un sucre sanguin élevé ?',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'Oui',
            negativeAnswer: 'Non',
            result: BooleanResult.NEGATIVE,
          ),
          isOptional: false,
        ),
        QuestionStep(
          title: 'Etes-vous connus pour une tension élevée ?',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'Oui',
            negativeAnswer: 'Non',
            result: BooleanResult.NEGATIVE,
          ),
        ),
        QuestionStep(
          title: 'Quel est votre tension en mmHg?',
          answerFormat: const IntegerAnswerFormat(
            hint: 'Entrez votre tension',
          ),
          isOptional: true,
        ),
        QuestionStep(
          title: 'Etes-vous connus pour un taux de cholestérol élevé ?',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'Oui',
            negativeAnswer: 'Non',
            result: BooleanResult.NEGATIVE,
          ),
        ),
        QuestionStep(
          title: 'Quel est votre taux de cholestérol en mmol/l ?',
          answerFormat: const IntegerAnswerFormat(
            hint: 'Entrez votre taux de cholestérol',
          ),
          isOptional: true,
        ),
        QuestionStep(
          title: 'Quel est votre taux de HDL en mmol/l ?',
          answerFormat: const IntegerAnswerFormat(
            hint: 'Entrez votre taux de HDL',
          ),
          isOptional: true,
        ),
        QuestionStep(
          title: 'Etes-vous diabétique ?',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'Oui',
            negativeAnswer: 'Non',
            result: BooleanResult.NEGATIVE,
          ),
        ),
        QuestionStep(
          title: 'Avez-vous déjà eu un infractus ?',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'Oui',
            negativeAnswer: 'Non',
            result: BooleanResult.NEGATIVE,
          ),
        ),
        QuestionStep(
          title: 'Avez-vous déjà eu une attaque cérébrale ?',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'Oui',
            negativeAnswer: 'Non',
            result: BooleanResult.NEGATIVE,
          ),
        ),
        InstructionStep(
            title: "Famille",
            text: 'Voici la deuxième partie',
            buttonText: 'C\'est partie ! '),
        QuestionStep(
          title:
              'Est-ce que un de vos parents (père avant 55 ans, mère avant 65 ans) a déjà eu un infractus ?',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'Oui',
            negativeAnswer: 'Non',
            result: BooleanResult.NEGATIVE,
          ),
        ),
        QuestionStep(
          title:
              'Est-ce que un de vos proche (père, mère, frères ou soeurs) a un cancer ?',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'Oui',
            negativeAnswer: 'Non',
            result: BooleanResult.NEGATIVE,
          ),
        ),
        InstructionStep(
            title: "Passe temps",
            text: 'Voici la dernière partie',
            buttonText: 'C\'est partie ! '),
        QuestionStep(
          title:
              'Est-ce que vous avez déjà fumé régulièrement une fois dans votre vie ?',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'Oui',
            negativeAnswer: 'Non',
            result: BooleanResult.NEGATIVE,
          ),
        ),
        QuestionStep(
          title: 'Quelle est votre habitude alimentaire ?',
          answerFormat: const ScaleAnswerFormat(
            step: 1,
            minimumValue: 0,
            maximumValue: 3,
            defaultValue: 2,
            minimumValueDescription: 'Mauvaise',
            maximumValueDescription: 'Bonnes',
          ),
        ),
        QuestionStep(
          title: 'Quelles sont vos habitudes sportives ?',
          answerFormat: const ScaleAnswerFormat(
            step: 1,
            minimumValue: 0,
            maximumValue: 3,
            defaultValue: 2,
            minimumValueDescription: 'Ne bouge pas',
            maximumValueDescription: '2 h intense/semaine',
          ),
        ),
        QuestionStep(
          title: 'Quelles sont vos habitudes au niveau de l\'alcool ?',
          answerFormat: const ScaleAnswerFormat(
            step: 1,
            minimumValue: 0,
            maximumValue: 4,
            defaultValue: 2,
            minimumValueDescription: 'Tous les jours',
            maximumValueDescription: 'Ne bois pas',
          ),
        ),
        CompletionStep(
          stepIdentifier: StepIdentifier(id: '23'),
          text: 'Vous avez terminé le questionnaire',
          title: 'Félicitation !',
          buttonText: 'Envoyer',
        ),
      ],
    );

    return task;
  }
}
