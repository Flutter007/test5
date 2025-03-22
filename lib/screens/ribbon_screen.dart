import 'dart:async';
import 'package:flutter/material.dart';
import 'package:test5/helpers/request.dart';
import 'package:test5/models/post.dart';
import 'package:test5/models/user.dart';

import '../widgets/rename_sheet.dart';

class RibbonScreen extends StatefulWidget {
  final List<User> user;
  final List<Post> posts;
  const RibbonScreen({super.key, required this.user, required this.posts});

  @override
  State<RibbonScreen> createState() => _RibbonScreenState();
}

class _RibbonScreenState extends State<RibbonScreen> {
  bool isLoading = true;
  String? messageSend;
  var messageController = TextEditingController();

  void sendMessage() async {
    try {
      if (messageSend!.isNotEmpty) {
        await requestPost(
          'http://146.185.154.90:8000/blog/${widget.user[0].email}/posts',
          messageSend!,
        );
      }
    } catch (e) {
      print(e);
    }
  }

  void openRenameSheet() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return RenameSheet(user: widget.user);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Twitter'),
        actions: [
          IconButton(onPressed: openRenameSheet, icon: Icon(Icons.edit)),
        ],
      ),
      body: Column(
        children: [
          Center(
            child: Text(
              'Name: ${widget.user[0].firstName},Family name: ${widget.user[0].lastName}',
            ),
          ),
          TextField(
            controller: messageController,
            onChanged:
                (value) => setState(() {
                  messageSend = value;
                }),
            decoration: InputDecoration(
              labelText: 'Message',
              border: OutlineInputBorder(),
            ),
          ),

          TextButton(onPressed: sendMessage, child: Text('Send')),
        ],
      ),
    );
  }
}
