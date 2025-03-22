import 'package:flutter/material.dart';
import 'package:test5/helpers/request.dart';
import 'package:test5/models/user.dart';
import 'package:test5/screens/ribbon_screen.dart';

import 'models/post.dart';

class Test5 extends StatefulWidget {
  const Test5({super.key});

  @override
  State<Test5> createState() => _Test5State();
}

class _Test5State extends State<Test5> {
  var emailController = TextEditingController();
  List<User> user = [];
  List<Post> posts = [];
  String? email;
  String? error;

  void fetchProfile() async {
    try {
      final Map<String, dynamic> userData = await requestGet(
        'http://146.185.154.90:8000/blog/$email/profile',
      );
      final postsFuture = requestGet(
        'http://146.185.154.90:8000/blog/$email/posts',
      );
      final List<dynamic> postsData = await postsFuture;

      setState(() {
        user = [User.fromJson(userData)];
        posts =
            postsData
                .map((post) => Post.fromJson(post as Map<String, dynamic>))
                .toList();
        error = null;
      });
      profile();
    } catch (e) {
      error = e.toString();
    }
  }

  void profile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RibbonScreen(user: user, posts: posts),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    content = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Enter your email:', style: TextStyle(fontSize: 30)),
          SizedBox(height: 20),
          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            onChanged:
                (value) => setState(() {
                  email = value;
                }),
            decoration: InputDecoration(
              labelText: 'Login',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              fetchProfile();
            },
            child: Text('Login'),
          ),
        ],
      ),
    );
    return Scaffold(appBar: AppBar(title: Text('Login ')), body: content);
  }
}
