import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';

import "home_page.dart";
import "Signup.dart";

class Login extends StatefulWidget {
  final bool showLogoutSnack;
  const Login({super.key,this.showLogoutSnack = false});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  bool _loginError = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.showLogoutSnack) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Logged out successfully"),
            duration: Duration(seconds: 2),
          ),
        );
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  Icon(
                    Icons.lock_outline,
                    size: 70,
                    color: const Color.fromARGB(255, 62, 62, 86),
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    "Welcome Back",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 30),

                  
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email cannot be empty';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password cannot be empty';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 15),

                  if(_loginError)
                    Text("Invalid email or password",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    ),
                    ),
                  const SizedBox(height: 15),
                 
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 62, 62, 86)
                      ),
                      onPressed:() async {
                        if (_formKey.currentState!.validate()) {
                          if (_emailController.text == 'ricon@gmail.com' &&
                              _passwordController.text == '12345') {

                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setBool('isLoggedIn', true);

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => HomePage(),
                              ),
                            );

                          } else {
                              setState(() {
                                _loginError = true;
                              });

                          }
                        }
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 19,
                          color: Colors.white
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                 
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => Signup()),
                      );
                    },
                    child: const Text(
                      "Don't have an account? Sign Up!",
                      style: TextStyle(
                        color: Color.fromARGB(255, 131, 124, 124)
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

