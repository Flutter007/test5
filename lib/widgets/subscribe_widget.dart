import 'package:flutter/material.dart';

import '../helpers/request.dart';
import '../models/user.dart';

class SubscribeWidget extends StatefulWidget {
  final List<User> user;
  const SubscribeWidget({super.key, required this.user});

  @override
  State<SubscribeWidget> createState() => _SubscribeWidgetState();
}

class _SubscribeWidgetState extends State<SubscribeWidget> {
  var emailController = TextEditingController();
  void subscribe() {
    try {
      requestPost(
        'http://146.185.154.90:8000/blog/${widget.user[0].email}/subscribe',
        emailController.text,
        'email',
      );
    } catch (e) {
      print(e);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final bottomInsetCheck = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20 + bottomInsetCheck),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 20),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Enter email',
              border: OutlineInputBorder(),
            ),
          ),
          TextButton(onPressed: subscribe, child: Text('Subscribe!')),
        ],
      ),
    );
  }
}
