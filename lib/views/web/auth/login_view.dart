import 'package:afyaai/controllers/login_controller.dart';
import 'package:afyaai/utils/constants.dart';
import 'package:afyaai/views/widgets/custom_button.dart';
import 'package:afyaai/views/widgets/mobile/buttons/custom_button_two.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:afyaai/models/login_model.dart';
import 'package:afyaai/views/widgets/custom_input.dart';

class LoginWebView extends StatefulWidget {
  @override
  _LoginWebViewState createState() => _LoginWebViewState();
}

class _LoginWebViewState extends State<LoginWebView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final LoginController controller = Get.find<LoginController>();

  void _login() {
    if (_formKey.currentState!.validate()) {
      controller.email.value = emailController.text.trim();
      controller.password.value = passwordController.text;
      controller.login();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return Scaffold(
          body: Center(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              width: constraints.maxWidth < 600 ? constraints.maxWidth * 0.9 : 500,
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image(
                      image: AssetImage('images/afyaAI-logo.png'),
                      height: 250,
                    ),
                    Text(
                      'Welcome back',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kGreen
                      ),
                    ),
                    SizedBox(height: 10),
                    InputField(hintText: "example@gmail.com", label: "Email", isRequired: true, controller: emailController,),
                    InputField(hintText: "********", label: "Password", controller: passwordController, password: true,),
                    SizedBox(height: 24),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                        child: CustomButton(callBackFunction: _login, label: "Sign In")),
                    SizedBox(height: 30,),
                    Text("Don't have an account?", textAlign: TextAlign.center, style: TextStyle(color: kGreen),),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        child: CustomButtonTwo(callBackFunction: () {}, label: "Sign Up"))
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
