import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new2/Screens/LoginScreen.dart';
import 'package:new2/Widgets/divider.dart';
import 'package:new2/Widgets/TextField.dart';
import 'package:new2/Interface/ScreenSwitch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final usernamecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final confirmpasswordcontroller = TextEditingController();
  bool _isLoading = false;

  Future<void> signUp() async {
    final username = usernamecontroller.text.trim();
    final email = emailcontroller.text.trim();
    final password = passwordcontroller.text.trim();
    final confirmPassword = confirmpasswordcontroller.text.trim();

    if (username.isEmpty) {
      _showError("Username cannot be empty.");
      return;
    }

    if (password != confirmPassword) {
      _showError("Passwords do not match.");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = userCredential.user!.uid;
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'username': username,
        'email': email,
        'createdAt': Timestamp.now(),
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ScreenSwitch(
            username: username,
            email: email,
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      _showError(e.message ?? "An error occurred.");
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
                width: 250,
                height: 250,
                child: Image(
                  image: AssetImage('assets/images/logo.png'),
                  fit: BoxFit.contain,
                ),
              ),
              const Space(),
              const Text(
                'Register',
                style: TextStyle(
                  fontFamily: 'Bold',
                  fontSize: 25,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SmallSpace(),
              MyTextField(
                controller: usernamecontroller,
                hinttext: 'Username',
                obscuretext: false,
                icon: Icons.person,
              ),
              const SmallSpace(),
              MyTextField(
                controller: emailcontroller,
                hinttext: 'Email',
                obscuretext: false,
                icon: Icons.email_rounded,
              ),
              const SmallSpace(),
              MyTextField(
                controller: passwordcontroller,
                hinttext: 'Password',
                obscuretext: true,
                icon: Icons.lock_rounded,
              ),
              const SmallSpace(),
              MyTextField(
                controller: confirmpasswordcontroller,
                hinttext: 'Confirm Password',
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
                      onPressed: signUp,
                      child: const Text(
                        'Sign Up',
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
                    'Already have an account?',
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
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: const Text(
                      'Login',
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
