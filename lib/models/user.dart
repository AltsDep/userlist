class User {
  final int id;
  final String fname;
  final String name;

  User({required this.id, required this.fname, required this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fname: json['fname'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'fname': fname,
        'name': name,
      };
}
