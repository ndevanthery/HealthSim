import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:healthsim/navbar/navBar.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

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
              title: Text(
                  'Are you willing to change something in your behaviour?'),
              actions: <Widget>[
                TextButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      _showDialog = false;
                    });
                  },
                ),
                TextButton(
                  child: Text('Yes'),
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
                title: Text('Et si je commençais quelque chose ?'),
              ),
              ListTile(
                title: Text('TABAC'),
                subtitle: Text('http://www.stop-tabac.ch/'),
                onTap: () {
                  launchUrl(
                    Uri.parse('http://www.stop-tabac.ch/'),
                  );
                },
              ),
              ListTile(
                title: Text('ALIMENTATION'),
                subtitle: Text(
                    'https://swissheart.ch/fr/comment-rester-en-bonne-sante/une-vie-saine/alimentation'),
                onTap: () {
                  launchUrl(
                    Uri.parse('http://www.stop-tabac.ch/'),
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
