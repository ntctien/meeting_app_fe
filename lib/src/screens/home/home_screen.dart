import 'package:flutter/material.dart';
import 'package:meeting_app_fe/src/screens/messages/messages_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void joinMeeting() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter your name'),
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  String name = nameController.text;
                  nameController.text = '';
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MessagesScreen(
                              name: name,
                            )),
                  );
                }
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.blue,
        ),
        onPressed: joinMeeting,
        child: const Text(
          'Join meeting',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
