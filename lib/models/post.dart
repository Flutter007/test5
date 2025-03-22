import 'package:test5/models/user.dart';

class Post {
  final String message;
  final String userId;
  final String id;
  final DateTime dateTime;
  final User user;

  Post({
    required this.message,
    required this.userId,
    required this.id,
    required this.dateTime,
    required this.user,
  });
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      message: json['message'],
      userId: json['userId'],
      id: json['_id'],
      dateTime: DateTime.parse(json['dateTime']).toLocal(),
      user: User.fromJson(json['user']),
    );
  }
}
