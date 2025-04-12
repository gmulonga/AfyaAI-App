import 'package:afyaai/routes/app_routes.dart';
import 'package:afyaai/views/widgets/custom_button.dart';
import 'package:afyaai/views/widgets/custom_button_two.dart';
import 'package:afyaai/views/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:afyaai/utils/constants.dart';


class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();


  void _login() {
    final String email = _emailController.text;
    final String password = _passwordController.text;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    bool isKeyboardVisible = keyboardHeight > 0;

    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Hero(
                      tag: "logo",
                      child: Image(
                        image: AssetImage('images/afyaAI-logo.png'),
                        height: screenHeight * 0.2,
                      ),
                    ),
                    Center(
                      child: Text(
                        "Login to your account",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Welcome back! please enter your details.",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    InputField(
                      controller: _emailController,
                      hintText: "John Doe",
                      label: "Name *",
                      isRequired: true,
                    ),
                    InputField(
                      controller: _emailController,
                      hintText: "example@gmail.com",
                      label: "Email *",
                      isRequired: true,
                    ),
                    InputField(
                      controller: _emailController,
                      hintText: "10",
                      label: "Age *",
                      isRequired: true,
                      integerOnly: true,
                    ),
                    InputField(
                      controller: _passwordController,
                      hintText: "******",
                      label: "Password *",
                      isRequired: true,
                      password: true,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: CustomButton(
                        callBackFunction: () {
                          _login();
                        },
                        label: "Sign In",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (!isKeyboardVisible)
            Positioned(
              bottom: screenHeight * 0.14,
              left: 0,
              right: 0,
              child: Visibility(
                visible: !isKeyboardVisible,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Center(
                    child: Text(
                      "Don't have an account?",
                    ),
                  ),
                ),
              ),
            ),

          if (!isKeyboardVisible)
            Positioned(
              bottom: screenHeight * 0.06,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: CustomButtonTwo(
                  callBackFunction: () {
                    Navigator.pushNamed(context, AppRoutes.register);
                  },
                  label: "Register",
                ),
              ),
            ),
        ],
      ),
    );
  }
}