import 'dart:async';
import 'package:flutter/material.dart';
import 'package:test5/helpers/formattedDate.dart';
import 'package:test5/helpers/request.dart';
import 'package:test5/models/post.dart';
import 'package:test5/models/user.dart';
import '../widgets/post_text.dart';
import '../widgets/rename_sheet.dart';
import '../widgets/subscribe_widget.dart';

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
  late Timer timer;
  var messageController = TextEditingController();
  @override
  void initState() {
    super.initState();
    try {
      timer = Timer.periodic(Duration(seconds: 3), (timer) async {
        final lastPostTime =
            widget.posts.isNotEmpty
                ? widget.posts.last.dateTime.toUtc().toIso8601String()
                : DateTime.now().toUtc().toIso8601String();
        final List<dynamic> postsData = await requestGet(
          'http://146.185.154.90:8000/blog/${widget.user[0].email}/posts?datetime=$lastPostTime',
        );
        if (postsData.isNotEmpty) {
          final messages =
              postsData.map((post) => Post.fromJson(post)).toList();
          setState(() {
            widget.posts.addAll(messages);
          });
        }
      });
    } catch (e) {
      Center(child: Text('Something went wrong!'));
    }
  }

  void sendMessage() async {
    try {
      if (messageSend!.isNotEmpty) {
        await requestPost(
          'http://146.185.154.90:8000/blog/${widget.user[0].email}/posts',
          messageSend!,
          'message',
        );
      }
    } catch (e) {
      Center(child: Text('Something went wrong!'));
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

  void openSubscribeSheet() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SubscribeWidget(user: widget.user);
      },
    );
  }

  void logOut() {
    setState(() {
      widget.user.clear();
      widget.posts.clear();
      messageSend = null;
    });
    Navigator.pop(context);
  }

  @override
  void dispose() {
    timer.cancel();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Twitter'),
        actions: [
          IconButton(onPressed: openRenameSheet, icon: Icon(Icons.edit)),
          IconButton(
            onPressed: openSubscribeSheet,
            icon: Icon(Icons.add_alert),
          ),
          IconButton(onPressed: logOut, icon: Icon(Icons.logout)),
        ],
      ),
      body: Column(
        children: [
          Center(
            child: PostText(
              txt:
                  'Name: ${widget.user[0].firstName},Family name: ${widget.user[0].lastName}',
              alignment: Alignment.center,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
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
              ),
              IconButton(onPressed: sendMessage, icon: Icon(Icons.send)),
            ],
          ),
          Text('Count of posts: ${widget.posts.length}'),

          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(),
              itemCount: widget.posts.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      PostText(
                        txt:
                            'Post: ${widget.posts[index].message} by ${widget.posts[index].user.firstName} ',
                        alignment: Alignment.centerLeft,
                      ),

                      PostText(
                        txt: formattedDateTime(widget.posts[index].dateTime),
                        alignment: Alignment.topRight,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
