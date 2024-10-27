import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_credentials/view/loginpage/loginpagescreen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmpassController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
 
  bool _isLoading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

//signup function

  Future<void> _signUp() async {
   
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

 try {
     
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passController.text.trim(),
      );
 String uid = userCredential.user!.uid;

      
      await FirebaseFirestore.instance.collection("users").doc(uid).set({
        "name": nameController.text.trim(),
        "email": emailController.text.trim(),
        "createdAt": DateTime.now(),
      });
        Fluttertoast.showToast(msg: "Signup successful!");
        Navigator.pop(context); 
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          Fluttertoast.showToast(msg: "The email is already in use by another account.");
        } else {
          Fluttertoast.showToast(msg: e.message ?? "An error occurred.");
        }
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }





  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;



  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                
                  controller: nameController,
                  decoration: InputDecoration(
                     
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      icon: Icon(Icons.person),
                      labelText: 'Name'),
                       
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      icon: Icon(Icons.email),
                      labelText: 'Email'),
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
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: passController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration( suffixIcon: IconButton(
                        icon: Icon(_isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),          
                                          onPressed:(){
          setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });                                        },
          
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      icon: Icon(Icons.password),
                      labelText: 'password'),
                       validator: (value) {
                  if (value!.isEmpty) return "Password is required";
                   String pattern = r'^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return "Password must be at least 8 characters long, include an uppercase letter, a number, and a special character.";
    }
                  return null;
                },
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: confirmpassController,
                  obscureText: !_isConfirmPasswordVisible,
                  decoration: InputDecoration( suffixIcon: IconButton(
                        icon: Icon(_isConfirmPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),          
                                          onPressed:(){
          setState(() {
                          _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                        });                                        },
          
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      icon: Icon(Icons.password_rounded),
                      labelText: 'confirm password'),
                 validator: (value) {
                  if (value!.isEmpty) return "Password is required";
                  if (value!=passController.text ) {
                    return "Password and confirm password are not same";
                  }
                  return null;
                },
                ),
                SizedBox(
                  height: 60,
                ),
                SizedBox(
                  height: 60,
                ),
                ElevatedButton(
                  onPressed: () {
                    _signUp();
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Signup successful!")),
                    );
                  }
                },
                  child: Text(
                    "Signup",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                const Divider(
                  thickness: 1,
                  indent: 10,
                ),
                SizedBox(
                  height: 40,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text(
                    "Login",
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
