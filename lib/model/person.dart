class Person {
  final String id;
  final String first_name;
  final String last_name;
  final String message;

  const Person({
    required this.id,
    required this.first_name,
    required this.last_name,
    required this.message,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      message: json['message'],
    );
  }
}
