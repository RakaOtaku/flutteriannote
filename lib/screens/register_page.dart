
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/components/my_button.dart';
import 'package:notesapp/components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  // sign user in method
  void signUserUp() async {

    //show loading circle
    showDialog(context: context, builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
    );

    //Error message
    void showErrorMessage(String s) {
      showDialog(context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Password dont match"),
          actions: [
            TextButton(onPressed: () {Navigator.pop(context, 'OK');}, child: Text('Ok'))
          ],
          );
        },
      );
    }

    //try sign up
    try {
      if (passwordController.text == confirmPasswordController.text) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text, 
      password: passwordController.text,
      );
      } else {
        showErrorMessage("Password dont match");
      }
    //pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //pop the loading circle
      Navigator.pop(context);
      //Wrong Password
      if (e.code == 'wrong-password') {
        showErrorMessage("Wrong password");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo
                const Icon(
                  Icons.lock,
                  size: 100,
                ),
          
                const SizedBox(height: 50),
          
                // 
                Text(
                  'Lets create an account',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
          
                const SizedBox(height: 25),
          
                // Email textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
          
                const SizedBox(height: 10),
          
                // password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
          
                const SizedBox(height: 10),

                // confirm password textfield
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 25),
          
                // sign in button
                MyButton(
                  onTap: signUserUp,
                  text: "Sign Up",
                ),
          
                const SizedBox(height: 50),
          
                const SizedBox(height: 50),
                
                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}