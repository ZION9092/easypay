class UserModel {
  String firstName;
  String lastName;
  String email;
  int age;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.age,
  });

  // Convert a UserModel object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'age': age,
    };
  }

  // Create a UserModel object from a Map object
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      age: map['age'] ?? 0,
    );
  }
}
