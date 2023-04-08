import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/components/my_button.dart';
import 'package:notesapp/components/my_textfield.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  // sign user in method
  void signUserIn() async {

    //show loading circle
    showDialog(context: context, builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
    );

    //Error message
    void showErrorMessage() {
      showDialog(context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('password/email kamu salah gengs'),
          actions: [
            TextButton(onPressed: () {Navigator.pop(context, 'OK');}, child: Text('Ok'))
          ],
          );
        },
      );
    }

    //try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text, 
      password: passwordController.text,
    );
    //pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //pop the loading circle
      Navigator.pop(context);
      //Wrong Email
      if (e.code == 'user-not-found') {
        showErrorMessage();
      //Wrong Password
      } else if (e.code == 'wrong-password') {
        showErrorMessage();
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
          
                // welcome back, you've been missed!
                Text(
                  'Welcome back you\'ve been missed!',
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
          
                // forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
          
                const SizedBox(height: 25),
          
                // sign in button
                MyButton(
                  onTap: signUserIn,
                  text: "Sign In",
                ),
          
                const SizedBox(height: 50),
          
                const SizedBox(height: 50),
                
                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Register now',
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