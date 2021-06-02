import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

Future<bool> signIn(String email, String password, context) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return true;
  } catch (e) {
    //AlertDialog(title: Text("Sample Alert Dialog"),
    showAlertDialog(context, "Yikes. We ran into an issue.", e.toString(),
        "Try again.", "");
    return false;
  }
}

Future<bool> register(String email, String password, context) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      showAlertDialog(context, "The password provided is too weak.",
          e.toString(), "Try again.", "");
    } else if (e.code == 'email-already-in-use') {
      showAlertDialog(context, "An account already exists for that email.",
          e.toString(), "Try again.", "");
    }
    return false;
  } catch (e) {
    showAlertDialog(context, "Yikes. We ran into an issue.", e.toString(),
        "Try again.", "");
    return false;
  }
}

Future<bool> addCoin(String id, String amount) async {
  try {
    String uid = FirebaseAuth.instance.currentUser.uid;
    var value = double.parse(amount); //make sure it's a double?
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Coins')
        .doc(id);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);
      if (!snapshot.exists) {
        //the user has never had any data for a particular coin
        documentReference.set({'Amount': value});
        return true;
      }
      double newAmount = snapshot.data()['Amount'] + value;
      transaction.update(documentReference, {'Amount': newAmount});
      return true;
    });
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> removeCoin(String id) async {
  String uid = FirebaseAuth.instance.currentUser.uid;
  FirebaseFirestore.instance
      .collection('Users')
      .doc(uid)
      .collection('Coins')
      .doc(id)
      .delete();
  return true;
}

Future<dynamic> showAlertDialog(
  BuildContext context,
  String title,
  String content,
  String cancelActionText,
  String defaultActionText,
) async {
  if (!Platform.isIOS) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          if (cancelActionText != null)
            FlatButton(
              child: Text(cancelActionText),
              onPressed: () => Navigator.of(context).pop(false),
            ),
          FlatButton(
            child: Text(defaultActionText),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
  }
  // todo : showDialog for ios
  return showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        if (cancelActionText != null)
          CupertinoDialogAction(
            child: Text(cancelActionText),
            onPressed: () => Navigator.of(context).pop(false),
          ),
/*        CupertinoDialogAction(
          child: Text(defaultActionText),
          onPressed: () => Navigator.of(context).pop(true),
        ),*/
      ],
    ),
  );
}
