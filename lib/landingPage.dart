import 'package:flutter/material.dart';

const maxWidthScreen = 2500.0;

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  List<Widget> pageChildren(double width) {
    return <Widget>[
      Container(
        width: width,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Your Health \nis your Wealth",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40.0,
                    color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  "Answer the questionnaire about your health history, lifestyle, habits and discover your position compared to the population !",
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ),
              MaterialButton(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 25.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Start questionnaire",
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
