import 'package:flutter/material.dart';

const maxWidthScreen = 2500.0;
const greyColor = Color.fromARGB(255, 102, 102, 102);

class BottomColumns extends StatelessWidget {
  const BottomColumns({super.key});

  List<Widget> pageColumn(double width) {
    return <Widget>[
      Container(
        width: width,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.thumb_up_outlined, color: Colors.white),
                  SizedBox(width: 10),
                  Text(
                    "Fill in questionnaire",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.white),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  "Describe what this feature does, and how it benefits your users.",
                  style: TextStyle(fontSize: 10.0, color: Colors.white),
                ),
              ),
            ]),
      ),
      Container(
        width: width,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on_outlined, color: Colors.white),
                  SizedBox(width: 10),
                  Text(
                    "Compare yourself",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.white),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  "Describe what this feature does, and how it benefits your users.",
                  style: TextStyle(fontSize: 10.0, color: Colors.white),
                ),
              ),
            ]),
      ),
      Container(
        width: width,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.monitor_heart_outlined, color: Colors.white),
                  SizedBox(width: 10),
                  Text(
                    "Simulate the results",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.white),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  "Describe what this feature does, and how it benefits your users.",
                  style: TextStyle(fontSize: 10.0, color: Colors.white),
                ),
              ),
            ]),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          //color: Colors.white,
          ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 800) {
            return Column(children: [
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: pageColumn(constraints.biggest.width / 3),
              )
            ]);
          } else {
            return Column(
              children: pageColumn(constraints.biggest.width),
            );
          }
        },
      ),
    );
  }
}
