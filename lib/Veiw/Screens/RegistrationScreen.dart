// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:staticnotes/Controller/auth_Controller.dart';
import 'package:staticnotes/Model/Customtextformfield.dart';
import 'package:staticnotes/Model/Validation.dart';


class Registrationscreen extends StatefulWidget {
  const Registrationscreen({super.key});

  @override
  State<Registrationscreen> createState() => _Registrationscreen();
}

class _Registrationscreen extends State<Registrationscreen> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _cpassword = TextEditingController();
  Validation validation = Validation();
  AuthController authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "REGISTER SCREEN",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.lightGreen,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formkey,

          child: Column(
            children: [
              SizedBox(height: 20),

              Customtextformfeild(
                controller: _name,
                label: "Name",
                hint: "John Doe",
                validator: (value) {
                  return validation.nameValidation(value);
                },
              ),
              SizedBox(height: 16),
              Customtextformfeild(
                controller: _email,
                label: "Email",
                hint: "abc@gmail.com",
                validator: (value) {
                  return validation.emailValidation(value);
                },
              ),
              SizedBox(height: 16),
              Customtextformfeild(
                controller: _password,
                label: "Password",
                hint: "********",
                isPassword: true,
                validator: (value) {
                  return validation.passwordValidation(value);
                },
              ),
              SizedBox(height: 16),
              Customtextformfeild(
                controller: _cpassword,
                label: "Confirm Password",
                hint: "********",
                isPassword: true,
                validator: (value) {
                  return validation.confirmPasswordValidation(
                    value,
                    _password.text,
                  );
                },
              ),
              SizedBox(height: 24),

              ElevatedButton(
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    bool isSaved = await authController.registerUser(
                      name: _name.text,
                      email: _email.text,
                      password: _password.text,
                    );

                    if (isSaved && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Account Created Successfully!"),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.pop(context);
                    } else if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Failed to save local data."),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  } else {
                    String error = validation.errors.join('\n');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(error),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                    validation.errors.clear();
                  }
                },

                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                  backgroundColor: Colors.lightGreen,
                  foregroundColor: Colors.white,
                ),
                child: Text("Register"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Already have an Acoount? Login Here!"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
