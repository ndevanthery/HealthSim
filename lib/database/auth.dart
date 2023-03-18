import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  //Register
  Future registerWithEmail(email, pwd, UserM user) async {
    try {
      UserCredential res = await _auth.createUserWithEmailAndPassword(
          email: email, password: pwd);
      Map<String, dynamic> map = {
        'email': user.email,
        'fullName': user.fullName,
      };

      await users.doc(res.user!.uid).set(map);
      map.putIfAbsent('uid', () => res.user!.uid);
      return map;
    } catch (e) {
      /* print(e.toString());
      print("ERROR"); */
      return null;
    }
  }

  Future loginWithEmail(email, pwd) async {
    try {
      UserCredential res =
          await _auth.signInWithEmailAndPassword(email: email, password: pwd);
      var myDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(res.user!.uid)
          .get();

      var data = myDoc.data();
      data?.putIfAbsent('uid', () => res.user!.uid);
      return data;
    } catch (e) {
/*       print(e.toString());
 */
      return null;
    }
  }
}
