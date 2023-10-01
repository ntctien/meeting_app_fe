import 'package:flutter/material.dart';
import 'package:meeting_app_fe/src/models/message.dart';

class MessageItem extends StatefulWidget {
  const MessageItem({super.key, required this.message});

  final Message message;

  @override
  State<MessageItem> createState() => _MessageItemState();
}

class _MessageItemState extends State<MessageItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration:
                const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(
              //   children: [
              //     Text(
              //       widget.message.name,
              //       style: const TextStyle(color: Colors.grey, fontSize: 13),
              //     ),
              //     const SizedBox(width: 10),
              //     Text(
              //       widget.message.time,
              //       style: const TextStyle(
              //           color: Color.fromARGB(255, 95, 93, 93), fontSize: 13),
              //     )
              //   ],
              // ),
              Text(
                widget.message.name,
                style: const TextStyle(color: Color.fromARGB(255, 95, 93, 93), fontSize: 13),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                widget.message.content,
                style: const TextStyle(fontSize: 16),
              )
            ],
          )
        ],
      ),
    );
  }
}
