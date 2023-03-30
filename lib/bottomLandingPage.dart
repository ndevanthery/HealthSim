import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const maxWidthScreen = 2500.0;
const greyColor = Color.fromARGB(255, 102, 102, 102);

class BottomColumns extends StatelessWidget {
  const BottomColumns({super.key});

  List<Widget> pageColumn(double width) {
    return <Widget>[
      Builder(builder: (context) {
        return Container(
          width: width,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.thumb_up_outlined, color: Colors.white),
                    const SizedBox(width: 10),
                    Text(
                      AppLocalizations.of(context)!.colonneun,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.white),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    "Describe what this feature does, and how it benefits your users.",
                    style: TextStyle(fontSize: 10.0, color: Colors.white),
                  ),
                ),
              ]),
        );
      }),
      Builder(builder: (context) {
        return Container(
          width: width,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.location_on_outlined, color: Colors.white),
                    const SizedBox(width: 10),
                    Text(
                      AppLocalizations.of(context)!.colonnedeux,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.white),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    "Describe what this feature does, and how it benefits your users.",
                    style: TextStyle(fontSize: 10.0, color: Colors.white),
                  ),
                ),
              ]),
        );
      }),
      Builder(builder: (context) {
        return Container(
          width: width,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.monitor_heart_outlined,
                        color: Colors.white),
                    const SizedBox(width: 10),
                    Text(
                      AppLocalizations.of(context)!.colonnetrois,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.white),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    "Describe what this feature does, and how it benefits your users.",
                    style: TextStyle(fontSize: 10.0, color: Colors.white),
                  ),
                ),
              ]),
        );
      }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          //color: Colors.white,
          ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 800) {
            return Column(children: [
              const SizedBox(
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
