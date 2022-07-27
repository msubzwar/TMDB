import 'dart:convert';

class User {
  String name;
  String email;
  String username;
  String password;

  User({
    required this.name,
    required this.email,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'username': username,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}

class Auth {
  String request_token;
  String username;
  String password;
  Auth({
    required this.request_token,
    required this.username,
    required this.password,
  });

  Auth copyWith({
    String? request_token,
    String? username,
    String? password,
  }) {
    return Auth(
      request_token: request_token ?? this.request_token,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'request_token': request_token,
      'username': username,
      'password': password,
    };
  }

  factory Auth.fromMap(Map<String, dynamic> map) {
    return Auth(
      request_token: map['request_token'] ?? '',
      username: map['username'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Auth.fromJson(String source) => Auth.fromMap(json.decode(source));

  @override
  String toString() =>
      'Auth(request_token: $request_token, username: $username, password: $password)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Auth &&
        other.request_token == request_token &&
        other.username == username &&
        other.password == password;
  }

  @override
  int get hashCode =>
      request_token.hashCode ^ username.hashCode ^ password.hashCode;
}
