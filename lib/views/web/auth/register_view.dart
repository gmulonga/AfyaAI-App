import 'package:afyaai/controllers/register_controller.dart';
import 'package:afyaai/utils/constants.dart';
import 'package:afyaai/views/widgets/custom_button.dart';
import 'package:afyaai/views/widgets/custom_spinner.dart';
import 'package:afyaai/views/widgets/mobile/buttons/custom_button_two.dart';
import 'package:afyaai/views/widgets/custom_input.dart';
import 'package:afyaai/views/widgets/mobile/input/input_chip.dart';
import 'package:afyaai/views/widgets/mobile/input/reusable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterWebView extends StatefulWidget {
  @override
  _RegisterWebViewState createState() => _RegisterWebViewState();
}

class _RegisterWebViewState extends State<RegisterWebView> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _conditionController = TextEditingController();
  final TextEditingController _allergyController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  List<String> conditions = [];
  List<String> allergies = [];
  String? selectedGender;

  final RegisterController controller = Get.put(RegisterController());

  final List<String> genderChoices = ["male", "female"];

  void _register() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final int age = int.tryParse(_ageController.text.trim()) ?? 0;

    if (name.isEmpty || email.isEmpty || password.isEmpty || age <= 0 || selectedGender == null) {
      Get.snackbar("Error", "Please fill in all required fields");
      return;
    }

    controller.name.value = name;
    controller.email.value = email;
    controller.password.value = password;
    controller.age.value = age;
    controller.gender.value = selectedGender!;
    controller.allergies.value = allergies;
    controller.existingConditions.value = conditions;

    controller.register();
  }

  Widget _buildForm() {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset('images/afyaAI-logo.png', height: 100),
          SizedBox(height: 10),
          Text("Create an Account", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: kGreen)),
          SizedBox(height: 10),
          InputField(label: "Name *", controller: _nameController, hintText: "John Doe", isRequired: true),
          InputField(label: "Email *", controller: _emailController, hintText: "example@gmail.com", isRequired: true),
          InputField(label: "Age *", controller: _ageController, hintText: "25", isRequired: true, integerOnly: true),
          CustomDropdown(
            label: "Gender",
            value: selectedGender,
            items: genderChoices,
            onChanged: (value) => setState(() => selectedGender = value),
          ),
          InputChipsField(
            label: "Existing Conditions (optional)",
            controller: _conditionController,
            items: conditions,
            onAdd: (value) => setState(() => conditions.add(value)),
            onRemove: (value) => setState(() => conditions.remove(value)),
          ),
          InputChipsField(
            label: "Allergies (optional)",
            controller: _allergyController,
            items: allergies,
            onAdd: (value) => setState(() => allergies.add(value)),
            onRemove: (value) => setState(() => allergies.remove(value)),
          ),
          InputField(label: "Password *", controller: _passwordController, hintText: "******", isRequired: true, password: true),
          SizedBox(height: 20),
          CustomButton(callBackFunction: _register, label: "Sign Up"),
          SizedBox(height: 15),
          Text("Already have an account?", textAlign: TextAlign.center, style: TextStyle(color: kGreen)),
          CustomButtonTwo(callBackFunction: () => Navigator.pop(context), label: "Login"),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        bool isSmallScreen = constraints.maxWidth < 800;

        return Scaffold(
          body: Stack(
            children: [
              Center(
                child: isSmallScreen
                    ? SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildForm(),
                )
                    : Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: kGreen,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Container(
                          width: constraints.maxWidth * 0.6,
                          padding: const EdgeInsets.all(16.0),
                          child: SingleChildScrollView(child: _buildForm()),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (controller.isLoading.value)
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(child: spinkit),
                ),
            ],
          ),
        );
      },
    );
  }
}
