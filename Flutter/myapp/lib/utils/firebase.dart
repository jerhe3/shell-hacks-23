// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final Stream<QuerySnapshot> users =
      FirebaseFirestore.instance.collection('users').snapshots();

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cloud Firestore Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Read Data from Cloud Firestore',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Container(
              height: 250,
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: StreamBuilder<QuerySnapshot>(
                stream: users,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong.');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text('Loading');
                  }

                  final data = snapshot.requireData;

                  return ListView.builder(
                    itemCount: data.size,
                    itemBuilder: (context, index) {
                      return Text(
                          'My name is ${data.docs[index]['Name']} and I am in ${data.docs[index]['Location']} and the start time is ${data.docs[index]['Time_Start']} and the end time is ${data.docs[index]['Time_End']} and is static: ${data.docs[index]['Static']}');
                    },
                  );
                },
              ),
            ),
            const Text(
              'Write Data to Cloud Firestore',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const MyCustomForm()
          ],
        ),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  var name = '';
  var location = '';
  var timestart = '';
  var timeend = '';
  var static = false;

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'What\'s Your Name?',
              labelText: 'Name',
            ),
            onChanged: (value) {
              name = value;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'What\'s Your Location?',
              labelText: 'Location',
            ),
            onChanged: (value) {
              location = value;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'What\'s the start time?',
              labelText: 'Time_Start',
            ),
            onChanged: (value) {
              timestart = value;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'What\'s Your Time_End?',
              labelText: 'Time_End',
            ),
            onChanged: (value) {
              timeend = value;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ), // Declare a variable to hold the value
          Column(
            children: <Widget>[
              TextFormField(
                  // other fields...
                  ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    static = true;
                  });
                },
                child: const Text('True'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    static = false;
                  });
                },
                child: const Text('False'),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Sending Data to Cloud Firestore'),
                  ));

                  users
                      .add({
                        'Name': name,
                        'Location': location,
                        'Time_Start': timestart,
                        'Time_End': timeend,
                        'Static': static
                      })
                      .then((value) => print('User Added'))
                      .catchError(
                          (error) => print('Failed to add user: $error'));
                }
              },
              child: const Text('Submit'),
            ),
          )
        ],
      ),
    );
  }
}
