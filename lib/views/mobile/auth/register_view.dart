import 'package:afyaai/routes/app_routes.dart';
import 'package:afyaai/views/widgets/mobile/buttons/custom_button.dart';
import 'package:afyaai/views/widgets/mobile/buttons/custom_button_two.dart';
import 'package:afyaai/views/widgets/mobile/input/custom_input.dart';
import 'package:afyaai/views/widgets/mobile/input/input_chip.dart';
import 'package:afyaai/views/widgets/mobile/input/reusable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:afyaai/utils/constants.dart';


class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _conditionController = TextEditingController();
  final TextEditingController _allergyController = TextEditingController();

  List<String> conditions = [];
  List<String> allergies = [];

  String? selectedGender;

  void _login() {
    final String email = _emailController.text;
    final String password = _passwordController.text;
  }

  final List<String> choices = ["male", "female"];

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
                        "Create an Account",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Create an account & get instant diagnosis.",
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
                    CustomDropdown(
                        label: "Gender",
                        value: selectedGender,
                        items: choices,
                        onChanged: (value) => setState(() => selectedGender = value)),
                    InputChipsField(
                      label: "Existing Conditions if any (optional)",
                      controller: _conditionController,
                      items: conditions,
                      onAdd: (value) {
                        setState(() => conditions.add(value));
                      },
                      onRemove: (value) {
                        setState(() => conditions.remove(value));
                      },
                    ),
                    InputChipsField(
                      label: "Allergies if any (optional)",
                      controller: _allergyController,
                      items: allergies,
                      onAdd: (value) {
                        setState(() => allergies.add(value));
                      },
                      onRemove: (value) {
                        setState(() => allergies.remove(value));
                      },
                    ),
                    InputField(
                      controller: _passwordController,
                      hintText: "******",
                      label: "Password *",
                      isRequired: true,
                      password: true,
                    ),
                    SizedBox(height: 10,),
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
                    SizedBox(height: 20,),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Center(
                        child: Text(
                          "Already have an account?",
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: CustomButtonTwo(
                        callBackFunction: () {
                          Navigator.pop(context);
                        },
                        label: "Login",
                      ),
                    ),
                    SizedBox(height: 40,),
                  ],
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}