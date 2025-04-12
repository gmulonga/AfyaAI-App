class RegisterModel {
  final String name;
  final String email;
  final String password;
  final int age;
  final String gender;
  final List<String> allergies;
  final List<String> existingConditions;

  RegisterModel({
    required this.name,
    required this.email,
    required this.password,
    required this.age,
    required this.gender,
    this.allergies = const [],
    this.existingConditions = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'age': age,
      'gender': gender,
      'allergies': allergies,
      'existing_conditions': existingConditions,
    };
  }

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      age: json['age'],
      gender: json['gender'],
      allergies: List<String>.from(json['allergies'] ?? []),
      existingConditions: List<String>.from(json['existing_conditions'] ?? []),
    );
  }
}
