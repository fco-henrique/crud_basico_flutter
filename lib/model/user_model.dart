class User {
  final int? id;
  final String email;
  final String password;

  User({this.id, required this.email, required this.password});

  User copyWith({int? id}) => User(
    id: id ?? this.id,
    email: email,
    password: password,
  );

  Map<String, Object?> toMap() => {
    'id': id,
    'email': email,
    'password': password,
  };

  static User fromMap(Map<String, Object?> map) => User(
    id: map['id'] as int?,
    email: map['email'] as String,
    password: map['password'] as String,
  );
}