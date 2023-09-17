import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

abstract class Database {
  static Future<void> pushToFirebase(
      String collectionName, String documentName, dynamic data) async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection(collectionName);
    return collection
        .doc(documentName)
        .set(data)
        .then((value) => print("Data added"))
        .catchError((error) => print("failed to add data: $error"));
  }

  static Future<void> updateToFirebase(
      String collectionName, String documentName, dynamic data) async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection(collectionName);
    return collection
        .doc(documentName)
        .update(data)
        .then((value) => print("Data updated"))
        .catchError((error) => print("failed to edit data: $error"));
  }

  static Future<void> deleteFromFirebase(
      String collectionName, String documentName, String fieldName) async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection(collectionName);

    return collection
        .doc(documentName)
        .update({fieldName: null})
        .then((value) => print("Data nullified"))
        .catchError((error) => print("failed to nullify data $error"));
  }

  //write second delete method here that deletes the whole function
  static Future<void> deleteAllFromFirebase(
      List<String> collectionNames) async {
    for (String collectionName in collectionNames) {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection(collectionName).get();
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        data.updateAll((key, value) => null);
        await doc.reference.update(data);
      }
    }
  }

  static Future<void> pullFromFirebase(
      String collectionName, String documentName, String fieldName) async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection(collectionName).doc(documentName);
    docRef.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');
        print('Field data: ${documentSnapshot.get(fieldName)}');
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  static Future<void> pullAllFromFirebase(List<String> collectionNames) async {
    for (String collectionName in collectionNames) {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection(collectionName).get();
      for (var doc in querySnapshot.docs) {
        print('Data from ${doc.id}: ${doc.data()}');
      }
    }
  }
}
