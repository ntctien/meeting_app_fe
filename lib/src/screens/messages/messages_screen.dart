import 'package:flutter/material.dart';
import 'package:meeting_app_fe/src/models/message.dart';
import 'package:meeting_app_fe/src/screens/messages/widgets/message_item.dart';
import 'package:socket_io_client/socket_io_client.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key, required this.name});

  final String name;

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  List<Message> messages = [];
  late Socket socket;
  final msgController = TextEditingController();

  @override
  void initState() {
    super.initState();
    connectAndListen();
  }

  @override
  void dispose() {
    msgController.dispose();
    socket.disconnect();
    super.dispose();
  }

  void connectAndListen() {
    socket = io(
        'https://meeting-app-be.azurewebsites.net',
        OptionBuilder()
            .setTransports(['websocket'])
            .setQuery({
              'name': widget.name,
            })
            .disableAutoConnect()
            .enableForceNew()
            .build());
    socket.connect();
    socket.onConnect((data) => {print('Connected')});
    socket.on('onMessage', (data) => onReceiveMessage(data));
  }

  void sendMessage() {
    socket.emit('message', msgController.text);
    setState(() {
      msgController.text = '';
    });
  }

  void onReceiveMessage(data) {
    setState(() {
      messages.add(Message(
          content: data['message'], name: data['user'], ava: data['color']));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('In call messages',
            style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: messages
                    .map((message) => MessageItem(message: message))
                    .toList(),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: TextField(
                controller: msgController,
                decoration: InputDecoration(
                    hintText: 'Send message',
                    filled: true,
                    fillColor: const Color(0xFFE8E9EB),
                    suffixIcon: IconButton(
                        onPressed: sendMessage,
                        icon: const Icon(Icons.send_outlined)),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(25)))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
