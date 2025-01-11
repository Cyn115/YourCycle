import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new2/Widgets/divider.dart';
import 'package:new2/Widgets/TextField.dart';
import 'package:new2/Screens/RegisterScreen.dart';
import 'package:new2/Interface/ScreenSwitch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  bool _isLoading = false;

  // Function to handle user login
  Future<void> login() async {
    final email = emailcontroller.text.trim();
    final password = passwordcontroller.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showError("Email and password cannot be empty.");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      String uid = userCredential.user!.uid;

      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userDoc.exists) {
        String username = userDoc['username'];
        String email = userDoc['email'];

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ScreenSwitch(
              username: username,
              email: email,
            ),
          ),
        );
      } else {
        _showError("User data not found.");
      }
    } on FirebaseAuthException catch (e) {
      _showError(e.message ?? "An error occurred during login.");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 223, 125, 166),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 300,
                height: 300,
                child: Image(
                  image: AssetImage('assets/images/logo.png'),
                  fit: BoxFit.contain,
                ),
              ),
              const Space(),
              const Space(),
              const Text(
                'Welcome Back!',
                style: TextStyle(
                  fontFamily: 'Bold',
                  fontSize: 25,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SmallSpace(),
              MyTextField(
                controller: emailcontroller,
                hinttext: 'Email',
                obscuretext: false,
                icon: Icons.email,
              ),
              const SmallSpace(),
              MyTextField(
                controller: passwordcontroller,
                hinttext: 'Password',
                obscuretext: true,
                icon: Icons.lock_rounded,
              ),
              const Space(),
              const Space(),
              _isLoading
                  ? const CircularProgressIndicator()
                  : TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 255, 228, 225),
                      ),
                      onPressed: login,
                      child: const Text(
                        'Log In',
                        style: TextStyle(
                          fontFamily: 'Regular',
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Do not have an account? ',
                    style: TextStyle(
                      fontFamily: 'Regular',
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontFamily: 'Regular',
                        fontSize: 15,
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
