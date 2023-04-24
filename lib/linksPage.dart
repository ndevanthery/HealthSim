import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:healthsim/navbar/navBar.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Links extends StatefulWidget {
  @override
  _LinksState createState() => _LinksState();
}

class _LinksState extends State<Links> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  bool _showDialog = true;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      _firebaseMessaging.getToken().then((value) {
        print('FCM Token: $value');
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_showDialog) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              elevation: 10,
              title: Text(AppLocalizations.of(context)!.changerNotif),
              actions: <Widget>[
                TextButton(
                  child: Text(AppLocalizations.of(context)!.non),
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      _showDialog = false;
                    });
                  },
                ),
                TextButton(
                  child: Text(AppLocalizations.of(context)!.oui),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _askNotificationPermission(context);
                    setState(() {
                      _showDialog = false;
                    });
                  },
                ),
              ],
            );
          },
        );
      } else {
        _askNotificationPermission(context);
      }
    });
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
            )),
        body: Material(
          child: ListView(
            children: [
              ListTile(
                title: Text(
                  AppLocalizations.of(context)!.commencer,
                  style: TextStyle(fontSize: 30),
                ),
              ),
              ListTile(
                title: Text(AppLocalizations.of(context)!.tabac),
                subtitle: Text('http://www.stop-tabac.ch/'),
                onTap: () {
                  launchUrl(
                    Uri.parse('http://www.stop-tabac.ch/'),
                  );
                },
              ),
              ListTile(
                title: Text(AppLocalizations.of(context)!.alimentation),
                subtitle: Text(
                    'https://swissheart.ch/fr/comment-rester-en-bonne-sante/une-vie-saine/alimentation'),
                onTap: () {
                  launchUrl(
                    Uri.parse(
                        'https://swissheart.ch/fr/comment-rester-en-bonne-sante/une-vie-saine/alimentation'),
                  );
                },
              ),
              ListTile(
                subtitle: Text(
                    'https://www.planetesante.ch/content/search?SearchText=alimentation+'),
                onTap: () {
                  launchUrl(
                    Uri.parse(
                        'https://www.planetesante.ch/content/search?SearchText=alimentation+'),
                  );
                },
              ),
              ListTile(
                subtitle: Text(
                    'https://www.planetesante.ch/Magazine/Alimentation-et-nutrition/Mieux-manger'),
                onTap: () {
                  launchUrl(
                    Uri.parse(
                        'https://www.planetesante.ch/Magazine/Alimentation-et-nutrition/Mieux-manger'),
                  );
                },
              ),
              ListTile(
                subtitle: Text('https://www.mangerbouger.fr/manger-mieux'),
                onTap: () {
                  launchUrl(
                    Uri.parse('https://www.mangerbouger.fr/manger-mieux'),
                  );
                },
              ),
              ListTile(
                title: Text(AppLocalizations.of(context)!.alcool),
                subtitle: Text(
                    'https://www.planetesante.ch/content/search?SearchText=alcool'),
                onTap: () {
                  launchUrl(
                    Uri.parse(
                        'https://www.planetesante.ch/content/search?SearchText=alcool'),
                  );
                },
              ),
              ListTile(
                subtitle: Text(
                    'https://www.stop-alcool.ch/fr/j-ai-decide-de-boire-moins'),
                onTap: () {
                  launchUrl(
                    Uri.parse(
                        'https://www.stop-alcool.ch/fr/j-ai-decide-de-boire-moins'),
                  );
                },
              ),
              ListTile(
                title: Text(AppLocalizations.of(context)!.activite),
                subtitle:
                    Text('https://www.jemebouge.ch/trouver-une-activite/'),
                onTap: () {
                  launchUrl(
                    Uri.parse('https://www.jemebouge.ch/trouver-une-activite/'),
                  );
                },
              ),
              ListTile(
                subtitle: Text(
                    'https://www.planetesante.ch/content/search?SearchText=activit%C3%A9+physique'),
                onTap: () {
                  launchUrl(
                    Uri.parse(
                        'https://www.planetesante.ch/content/search?SearchText=activit%C3%A9+physique'),
                  );
                },
              ),
              ListTile(
                subtitle: Text('https://www.pas-a-pas.ch/'),
                onTap: () {
                  launchUrl(
                    Uri.parse('https://www.pas-a-pas.ch/'),
                  );
                },
              ),
              ListTile(
                title: Text(AppLocalizations.of(context)!.chute),
                subtitle: Text(
                    'https://www.dalcroze.ch/cours/cours-seniors/rythmique-seniors/'),
                onTap: () {
                  launchUrl(
                    Uri.parse(
                        'https://www.dalcroze.ch/cours/cours-seniors/rythmique-seniors/'),
                  );
                },
              ),
              ListTile(
                title: Text(
                  AppLocalizations.of(context)!.region,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              ListTile(
                title: Text(AppLocalizations.of(context)!.fribourg),
                subtitle: Text('https://www.liguessante-fr.ch/prevention/'),
                onTap: () {
                  launchUrl(
                    Uri.parse('https://www.liguessante-fr.ch/prevention/'),
                  );
                },
              ),
              ListTile(
                title: Text(AppLocalizations.of(context)!.jura),
                subtitle: Text('https://fondationo2.ch/'),
                onTap: () {
                  launchUrl(
                    Uri.parse('https://fondationo2.ch/'),
                  );
                },
              ),
              ListTile(
                title: Text(AppLocalizations.of(context)!.vaud),
                subtitle: Text('https://cours.unisante.ch/les-cours/'),
                onTap: () {
                  launchUrl(
                    Uri.parse('https://cours.unisante.ch/les-cours/'),
                  );
                },
              ),
              ListTile(
                title: Text(
                  AppLocalizations.of(context)!.savoirplus,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              ListTile(
                title: Text(AppLocalizations.of(context)!.cancer),
                subtitle: Text(
                    'https://www.planetesante.ch/content/search?SearchText=cancer'),
                onTap: () {
                  launchUrl(
                    Uri.parse(
                        'https://www.planetesante.ch/content/search?SearchText=cancer'),
                  );
                },
              ),
              ListTile(
                subtitle: Text(
                    'https://alimentation.liguecancer.ch/prevention-du-cancer/manger-equilibre/?gclid=CjwKCAjwq-WgBhBMEiwAzKSH6FQH-fm_DUwyPcrMiT3AJ7L5zU4EDGnbsEScOk_eTbkeDtRC7WAPSxoC19MQAvD_BwE'),
                onTap: () {
                  launchUrl(
                    Uri.parse(
                        'https://alimentation.liguecancer.ch/prevention-du-cancer/manger-equilibre/?gclid=CjwKCAjwq-WgBhBMEiwAzKSH6FQH-fm_DUwyPcrMiT3AJ7L5zU4EDGnbsEScOk_eTbkeDtRC7WAPSxoC19MQAvD_BwE'),
                  );
                },
              ),
              // Add more links here
            ],
          ),
        ));
  }

  Future<void> _askNotificationPermission(BuildContext context) async {
    NotificationSettings settings =
        await _firebaseMessaging.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // User has granted permission, send a test notification
      String? token = await _firebaseMessaging.getToken();
      String serverKey =
          'AAAAXjxDv84:APA91bEZmjNzaH0PRzVildjiuc_K1Cx-VjGdJxky1XtdzRvcKbHrNYSeIT-IpSl7kwiWHcvCt42pL6tbXrSKDJAdFkEPJ3FvmirQyqWjKdLQs24ZAV8Gp6MXT15nS8UYi2rkChcDZY01'; // Replace with your FCM server key
      String fcmUrl = 'https://fcm.googleapis.com/fcm/send';

      // Create the notification message
      Map<String, dynamic> notification = {
        'title': 'Test Notification',
        'body': 'This is a test notification'
      };
      Map<String, dynamic> data = {
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        'id': '1',
        'status': 'done'
      };
      Map<String, dynamic> message = {
        'notification': notification,
        'data': data,
        'to': token
      };

      // Send the notification using the FCM REST API
      await http.post(
        Uri.parse(fcmUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey'
        },
        body: jsonEncode(message),
      );
    }
  }
}
