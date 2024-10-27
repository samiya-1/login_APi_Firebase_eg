import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_credentials/view/profilepage/profilescreen.dart';
import 'package:login_credentials/view/signup/signupscreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  bool _isPasswordVisible = false;

  final FirebaseAuth _auth = FirebaseAuth.instance; 
  final _formKey = GlobalKey<FormState>(); //for validation

// login function

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) { 
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passController.text.trim(),
        );

        Fluttertoast.showToast(msg: "Login successful!");

        
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  ProfileScreen()),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Fluttertoast.showToast(msg: "No user found for that email.");
        } else if (e.code == 'wrong-password') {
          Fluttertoast.showToast(msg: "Wrong password provided.");
        } else {
          Fluttertoast.showToast(msg: e.message ?? "An error occurred.");
        }
      }
    }
  }
//password validation
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    String pattern = r'^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return "Password must be at least 8 characters long, include an uppercase letter, a number, and a special character.";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form( 
          key: _formKey, 
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email is required";
                    }
                    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                      return "Invalid email format";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: passController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(_isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    labelText: 'Password',
                  ),
                  validator: _validatePassword, 
                ),
                const SizedBox(height: 60),
                ElevatedButton(
                  onPressed: _login, 
                  child: const Text(
                    "Login",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                const SizedBox(height: 40),
                const Divider(thickness: 1, indent: 10),
                const SizedBox(height: 40),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignupScreen()));
                  },
                  child: const Text(
                    "Sign up",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
