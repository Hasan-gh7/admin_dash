class UserModel {
  final String id;
  final String username;
  final String email;
  final DateTime createdAt;
  final bool isBanned;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.createdAt,
    required this.isBanned,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      createdAt: DateTime.parse(json['created_at']),
      isBanned: json['is_banned'] is bool
          ? json['is_banned']
          : json['is_banned'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'created_at': createdAt.toIso8601String(),
      'is_banned': isBanned,
    };
  }

  UserModel copyWith({
    String? id,
    String? username,
    String? email,
    DateTime? createdAt,
    bool? isBanned,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      isBanned: isBanned ?? this.isBanned,
    );
  }
}