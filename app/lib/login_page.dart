//imported firestore auth for registration auth and cloud firestore for database operations
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//stateful widget to handle all the state changes in the page
class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}


class _RegisterPageState extends State<RegisterPage> {
  //input feilds for registration
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _registerUser() async {
    try {
      //create new user
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      User? user = userCredential.user;

      if (user != null) {
        //additional info of user
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'username': usernameController.text,
          'contact': contactController.text,
          'email': user.email, 
        });

        //manage snackbar in scaffold
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('User registered successfully'),
        ));
      }
    } catch (e) {
      //if any error in registration
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error registering user: $e'),
      ));
    }
  }

  @override
  //to display ui
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: contactController,
              decoration: InputDecoration(labelText: 'Contact'),
            ),
            ElevatedButton(
              onPressed: _registerUser,
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
