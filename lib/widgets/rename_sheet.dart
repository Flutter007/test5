import 'package:flutter/material.dart';

import '../helpers/request.dart';
import '../models/user.dart';

class RenameSheet extends StatefulWidget {
  final List<User> user;
  const RenameSheet({super.key, required this.user});

  @override
  State<RenameSheet> createState() => _RenameSheetState();
}

class _RenameSheetState extends State<RenameSheet> {
  var nameController = TextEditingController();
  var familyNameController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = widget.user[0].firstName;
    familyNameController.text = widget.user[0].lastName;
  }

  void rename() async {
    try {
      await requestPostInfo(
        'http://146.185.154.90:8000/blog/${widget.user[0].email}/profile',
        nameController.text,
        familyNameController.text,
      );
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInsetCheck = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20 + bottomInsetCheck),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: familyNameController,
            decoration: InputDecoration(
              labelText: 'Family name',
              border: OutlineInputBorder(),
            ),
          ),
          TextButton(onPressed: rename, child: Text('Rename')),
        ],
      ),
    );
  }
}
