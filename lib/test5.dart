import 'package:flutter/material.dart';
import 'package:test5/helpers/request.dart';
import 'package:test5/models/user.dart';
import 'package:test5/screens/ribbon_screen.dart';
import 'package:test5/theme/colors.dart';

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
  bool isLoading = false;
  String? error;

  void fetchProfile() async {
    setState(() {
      isLoading = true;
      error = null;
    });
    try {
      final Map<String, dynamic> userData = await requestGet(
        'http://146.185.154.90:8000/blog/$email/profile',
      );

      final List<dynamic> postsData = await requestGet(
        'http://146.185.154.90:8000/blog/$email/posts',
      );

      setState(() {
        user = [User.fromJson(userData)];
        posts = postsData.map((post) => Post.fromJson(post)).toList();
        isLoading = false;
        error = null;
      });
      profile();
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
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
    bool containsEmail =
        emailController.text.contains('@gmail.com') ||
        emailController.text.contains('@yahoo.com') ||
        emailController.text.contains('@mail.ru');
    final theme = Theme.of(context);
    final customColor = Theme.of(context).extension<CustomColor>()!;
    Widget content;
    if (!isLoading) {
      content = Container(
        color: customColor.screenBackgroundColor,
        child: Center(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed:
                        email != null && containsEmail
                            ? () {
                              fetchProfile();
                            }
                            : null,
                    child: Text('Login'),
                  ),
                  IconButton(
                    onPressed:
                        email != null && containsEmail
                            ? () {
                              fetchProfile();
                            }
                            : null,
                    icon: Icon(Icons.login_rounded, size: 30),
                  ),
                ],
              ),
              error != null
                  ? Text(
                    error!,
                    style: TextStyle(color: theme.colorScheme.error),
                  )
                  : Text(''),
            ],
          ),
        ),
      );
    } else {
      content = Center(child: CircularProgressIndicator());
    }
    return Scaffold(appBar: AppBar(title: Text('Sign in ')), body: content);
  }
}
