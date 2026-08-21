import "package:flutter/material.dart";
import "package:flutter_application_1/home_page.dart";
import "login.dart";
import "dart:math";

class Signup extends StatefulWidget{
  const Signup({super.key});
  @override
  State<Signup> createState() => _SignupState();
} 

class _SignupState extends State<Signup>{
  int _num1 =0;
  int _num2 =0;
  bool _captchaError = false;
  @override
  void initState() {
    super.initState();
    _generateCaptcha();
  }

  void _generateCaptcha() {
    final random = Random();
    _num1 = random.nextInt(9) + 1; 
    _num2 = random.nextInt(9) + 1;
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _captchaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: EdgeInsets.all(16.0),
      child: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.person_add,
                  size: 70,
                  color: const Color.fromARGB(255, 62, 62, 86),
                ),
                const SizedBox(height: 20),
                Text(
                  "Create your BookNest account",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty){
                      return 'Name cannot be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty){
                      return 'Email cannot be empty';
                    }
                    if (!value.endsWith('@gmail.com')) {
                      return "Email must end with @gmail.com";
                    }

                    return null;
                  },

                  
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    prefixIcon: Icon(Icons.password),
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty){
                      return 'Password cannot be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _captchaController,
                  decoration: InputDecoration(
                    labelText: "Enter captcha",
                    prefixIcon: Icon(Icons.calculate),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  validator: (value)  {
                    if (value == null || value.isEmpty) {
                        return "Please solve the captcha";
                      }
                      return null;
                  },
                ),
                if (_captchaError)
                  const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      "Incorrect captcha answer",
                      style: TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),

                const SizedBox(height: 20),
                Text(
                    " $_num1 + $_num2 = ?",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 62, 62, 86)
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final int correctAnswer = _num1 + _num2;
                        final int? userAnswer = int.tryParse(_captchaController.text);

                        if (userAnswer == correctAnswer) {
                          
                          setState(() {
                            _captchaError = false;
                          });

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => HomePage()),
                          );
                        } else {
                          
                          setState(() {
                            _captchaError = true;
                            _captchaController.clear();
                            _generateCaptcha();
                          });
                        }
                      }
                    },

                    child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 19,
                          color: Colors.white
                        ),
                    )
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => Login()),
                      );
                    },
                    child: const Text(
                      "Already have an account? Login!",
                      style: TextStyle(
                        color: Color.fromARGB(255, 131, 124, 124)
                      ),
                    ),
                ),
                

              ],
            ),
          ),
        ),
      ),),
    );
  }
}