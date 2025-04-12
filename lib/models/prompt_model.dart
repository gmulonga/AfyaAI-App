class PromptModel {
  final String prompt;

  PromptModel({required this.prompt});

  Map<String, dynamic> toJson() {
    return {
      'prompt': prompt,
    };
  }
}
