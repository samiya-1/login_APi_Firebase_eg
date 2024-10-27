import 'package:flutter/material.dart';
import 'package:login_credentials/view/dashboard/dashboardscreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


   TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("images/download.png")
           
            ),
        SizedBox(
                  height: -60,
                ),
             TextFormField(
                
                  controller: nameController,
                  decoration: InputDecoration(
                     
                      icon: Icon(Icons.person),
                      labelText: 'Name'),
                       
                ),
                SizedBox(
                  height: -60,
                ),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                     
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
                  height: 70,
                ),

                 ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => DashBoard()));
                  },
                  child: Text(
                    "Edit",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                
               
        
          ],
        ),
      ),
    );
  }
}
