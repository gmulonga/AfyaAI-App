class DiagnosisResponse {
  final String shortAnswer;
  final List<String> possibleDiseases;
  final List<String> steps;
  final List<String> foodRemedies;
  final bool visitClinic;

  DiagnosisResponse({
    required this.shortAnswer,
    required this.possibleDiseases,
    required this.steps,
    required this.foodRemedies,
    required this.visitClinic,
  });

  factory DiagnosisResponse.fromJson(Map<String, dynamic> json) {
    return DiagnosisResponse(
      shortAnswer: json['shortAnswer'],
      possibleDiseases: List<String>.from(json['possibleDiseases']),
      steps: List<String>.from(json['steps']),
      foodRemedies: List<String>.from(json['foodRemedies']),
      visitClinic: json['visitClinic'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shortAnswer': shortAnswer,
      'possibleDiseases': possibleDiseases,
      'steps': steps,
      'foodRemedies': foodRemedies,
      'visitClinic': visitClinic,
    };
  }
}
