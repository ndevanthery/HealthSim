import 'package:flutter/material.dart';
import 'package:healthsim/questionnaire/ModelAnswer.dart';
import 'package:healthsim/questionnaire/questionnaire.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:healthsim/result/result.dart';

const maxWidthScreen = 2500.0;

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  List<Widget> pageChildren(double width) {
    return <Widget>[
      Container(
        width: width,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                AppLocalizations.of(context)!.votresantetitre,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40.0,
                    color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  AppLocalizations.of(context)!.completequetionnairedescription,
                  style: const TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultPage(
                            resultQuestionnaire: ModelAnswer(
                                1,
                                25,
                                173,
                                79,
                                -1,
                                0,
                                -1,
                                0,
                                -1,
                                -1,
                                0,
                                1,
                                0,
                                0,
                                0.03,
                                0.5,
                                2,
                                1,
                                3,
                                DateTime.now()),
                          ),
                        ));
                  },
                  child: Text(AppLocalizations.of(context)!.allerauxresultats)),
              MaterialButton(
                  color: Colors.white,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuestionnairePage(),
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 25.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        AppLocalizations.of(context)!.lancerquestionnaire,
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ))
            ]),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Image.asset(
          "assets/images/doctors.png",
          width: width,
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: pageChildren(constraints.biggest.width / 2),
          );
        } else {
          return Column(
            children: pageChildren(constraints.biggest.width),
          );
        }
      },
    );
  }
}
