import 'dart:ffi';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class Services {
  FirebaseAuth _auth = FirebaseAuth.instance;
  var FirebaseUser;
  CollectionReference usercollection =
      FirebaseFirestore.instance.collection('users');
  CollectionReference remainderscollection =
      FirebaseFirestore.instance.collection('remainders');

  bool _isExpiryDateAfterToday(String expiryDate, String today) {
    List<int> expiryComponents = expiryDate.split('-').map(int.parse).toList();
    List<int> todayComponents = today.split('-').map(int.parse).toList();

    
    if (expiryComponents[2] > todayComponents[2]) {
      return true; 
    } else if (expiryComponents[2] == todayComponents[2]) {
      if (expiryComponents[1] > todayComponents[1]) {
        return true; 
      } else if (expiryComponents[1] == todayComponents[1]) {
        return expiryComponents[0] >
            todayComponents[
                0]; 
      }
    }
    return false;
  }

  Future<String> SignUp(String name, String email, String Password) async {
    await _auth.createUserWithEmailAndPassword(
        email: email, password: Password);
    FirebaseUser = FirebaseAuth.instance.currentUser;
    String id = FirebaseUser.uid;

    await usercollection.doc(id).set({"name": name, "remainder": {}});
    return id;
  }

  Future<String> SignIn(String email, String Password) async {
    print("Signin with email password");
    print(email);
    print(Password);
    UserCredential user = await _auth.signInWithEmailAndPassword(
        email: email, password: Password);
    FirebaseUser = FirebaseAuth.instance.currentUser;
    String id = FirebaseUser.uid;
    print(id);
    return id;
  }

  Future<bool> AddRemainder(String type, String name, String date) async {
    String id = _auth.currentUser!.uid;
    var data = await usercollection.doc(id).get();
    print("In add transaction");
    print(data["remainder"].containsKey(date));

    var newRemainder = {
      "date": date,
      "type": type,
      "name": name,
    };

    remainderscollection.add(newRemainder).then((value) => {
          usercollection.doc(id).update({
            "remainder.$date": FieldValue.arrayUnion([value.id])
          }),
        });
    return true;
  }

  Future<List<Map<String, dynamic>>> getRemainder() async {
    DateTime dateTime = DateTime.now();
    String date = '${dateTime.day}-${dateTime.month}-${dateTime.year}';
    
    String id = _auth.currentUser!.uid;
    var data = await usercollection.doc(id).get();
    List<Map<String, dynamic>> listOfMaps = [];
    
    var map;
    Map<String, dynamic> id_doc = data["remainder"];
    for (var entry in id_doc.entries) {
      String expiryDate = entry.key; 
      List<dynamic> remainderData =
          entry.value; 

      if (expiryDate == date) {
        for (var remainderId in remainderData) {
          var docSnapshot = await remainderscollection.doc(remainderId).get();
          if (docSnapshot.exists) {
            var map = docSnapshot.data();
            listOfMaps.add(map as Map<String, dynamic>);
          }
        }
      }
    }

    
    return listOfMaps;
  }

  Future<List<Map<String, dynamic>>> upcomingRemainder() async {
    DateTime dateTime = DateTime.now();
    String date = '${dateTime.day}-${dateTime.month}-${dateTime.year}';
    
    String id = _auth.currentUser!.uid;
    var data = await usercollection.doc(id).get();
    List<Map<String, dynamic>> listOfMaps_1 = [];

    if (data["remainder"] != null) {
      for (var entry in data["remainder"].entries) {
        
        String expiryDate = entry.key;
        
        if (_isExpiryDateAfterToday(expiryDate, date)) {
          
          List<dynamic> id_doc = entry.value;
          for (var id in id_doc) {
            
            var docSnapshot = await remainderscollection.doc(id).get();
            // print("DocSnapshot: $docSnapshot");
            if (docSnapshot.exists) {
              var map = docSnapshot.data();
              // print("map : $map");
              listOfMaps_1.add(map as Map<String, dynamic>);
            }
          }
        }
      }
    }

    print('List of Maps: $listOfMaps_1');

    listOfMaps_1.sort((a, b) {
      String expiryDateA = a['date'];
      String expiryDateB = b['date'];

      
      List<int> dateA = expiryDateA.split('-').map(int.parse).toList();
      List<int> dateB = expiryDateB.split('-').map(int.parse).toList();

      
      if (dateA[2] != dateB[2]) {
        return dateA[2].compareTo(dateB[2]); 
      } else if (dateA[1] != dateB[1]) {
        return dateA[1].compareTo(dateB[1]); 
      } else {
        return dateA[0].compareTo(dateB[0]); 
      }
    });

    print('List of Maps_1: $listOfMaps_1');
    return listOfMaps_1;
  }

  Future<bool> oauth_google() async {
    try {
      print('in google');
      await GoogleSignIn().signOut();
      final GoogleSignInAccount? user =
          await GoogleSignIn(forceCodeForRefreshToken: true).signIn();
      if (user == null) return false;
      final GoogleSignInAuthentication googleauth = await user.authentication;
      final AuthCredential creds = await GoogleAuthProvider.credential(
          accessToken: googleauth.accessToken, idToken: googleauth.idToken);
      UserCredential auth = await _auth.signInWithCredential(creds);
      DocumentSnapshot userDoc = await usercollection.doc(auth.user?.uid).get();
      String email = user!.email ?? "";
      String name = user.displayName ?? "";
      print('displsy');
      if (userDoc.exists) {
        print('User Already Exist : Updating Only Gmail');
      } else {
        await usercollection.doc(auth.user?.uid).set({
          "name": name, "remainder": {}
        });
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> oauth_facebook() async {
    try {
      print("called facebook auth");
      await FacebookAuth.instance.logOut();
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final AuthCredential creds =
            FacebookAuthProvider.credential(result.accessToken!.token);
        UserCredential auth = await _auth.signInWithCredential(creds);
        DocumentSnapshot userDoc =
            await usercollection.doc(auth.user?.uid).get();
        String name = userDoc.exists ? userDoc["name"] : "";
        if (userDoc.exists) {
          print('User Already Exist: Updating Only Facebook');
        } else {
          await usercollection.doc(auth.user?.uid).set({
            "name": name, "remainder": {}
          });
        }

        return true;
      } else if (result.status == LoginStatus.cancelled) {
        print("Facebook login cancelled");
        return false;
      } else {
        print("Facebook login failed: ${result.message}");
        return false;
      }
    } catch (e) {
      print("Facebook login error: $e");
      return false;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  } 
}
