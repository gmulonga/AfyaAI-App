import 'package:afyaai/controllers/diagnosis_controller.dart';
import 'package:afyaai/utils/constants.dart';
import 'package:afyaai/views/widgets/custom_spinner.dart';
import 'package:afyaai/views/widgets/custom_button.dart';
import 'package:afyaai/views/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:afyaai/services/localstorage_service.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String userName = '';
  final TextEditingController _promptController = TextEditingController();
  final PromptController controller = Get.put(PromptController());

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    String? storedUserName = await StorageService.getData('userName');
    setState(() {
      userName = storedUserName ?? 'Guest';
    });
  }

  Future<void> _sendPrompt() async {
    final prompt = _promptController.text.trim();
    if (prompt.isEmpty) return;

    await controller.getDiagnosis(prompt);
    FocusScope.of(context).unfocus();

    if (controller.diagnosisResult.isNotEmpty) {
      _showDiagnosisBottomSheet(context);
    }
  }

  void _showDiagnosisBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final result = controller.diagnosisResult;
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.95,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Text("Diagnosis Summary",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.green[800],
                      )),
                  SizedBox(height: 10),
                  Text(result['shortAnswer'] ?? 'No summary available',
                      style: TextStyle(fontSize: 16)),
                  SizedBox(height: 20),
                  if (result['possibleDiseases'] != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Possible Diseases:",
                            style: TextStyle(fontWeight: FontWeight.bold, color: kGreen)),
                        ...List.generate(
                          result['possibleDiseases'].length,
                              (index) => Text('- ${result['possibleDiseases'][index]}'),
                        ),
                      ],
                    ),
                  SizedBox(height: 20),
                  if (result['steps'] != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Recommended Steps:",
                            style: TextStyle(fontWeight: FontWeight.bold, color: kGreen)),
                        ...List.generate(
                          result['steps'].length,
                              (index) => Text('• ${result['steps'][index]}'),
                        ),
                      ],
                    ),
                  SizedBox(height: 20),
                  if (result['foodRemedies'] != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Food Remedies:",
                            style: TextStyle(fontWeight: FontWeight.bold, color: kGreen)),
                        ...List.generate(
                          result['foodRemedies'].length,
                              (index) => Text('• ${result['foodRemedies'][index]}'),
                        ),
                      ],
                    ),
                  SizedBox(height: 20),
                  if (result['visitClinic'] != null)
                    Text(
                      result['visitClinic']
                          ? "⚠️ It is recommended to visit a clinic."
                          : "Clinic visit not urgently required.",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: result['visitClinic']
                            ? Colors.red
                            : Colors.green[800],
                      ),
                    ),
                  SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    bool isKeyboardVisible = keyboardHeight > 0;

    return Obx(() => Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text("Welcome, $userName", style: TextStyle(fontWeight: FontWeight.bold, color: kGreen, fontSize: 15),),
                    ),
                    SizedBox(height: screenHeight * 0.05,),
                    Hero(
                      tag: "logo",
                      child: Image(
                        image: AssetImage('images/afyaAI-logo.png'),
                        height: screenHeight * 0.1,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.05,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                      child: Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          "Welcome to AfyaAI, get quick diagnosis based on your symptoms.",
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: kGreen),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    InputField(
                      controller: _promptController,
                      hintText: "Enter your symptoms",
                      label: "How are you feeling *",
                      isRequired: true,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: CustomButton(
                        callBackFunction: _sendPrompt,
                        label: "Diagnose",
                      ),
                    ),
                    if (controller.error.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          'Error: ${controller.error.value}',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                  ],
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
    ));
  }
}
