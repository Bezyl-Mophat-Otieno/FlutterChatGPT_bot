import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:markdown_widget/widget/markdown.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage(
      {super.key,
      required this.sender,
      required this.content,
      required this.isUserMessage});
  final String sender;
  final String content;
  final bool isUserMessage;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(right: 16),
          child: isUserMessage
              ? CircleAvatar(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.black,
                  child: Text(sender[0].toUpperCase()),
                )
              : CircleAvatar(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  child: Text(sender[0].toUpperCase()),
                ),
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(sender[0].toUpperCase() + sender.substring(1)),
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: MarkdownWidget(
                data: content,
                shrinkWrap: true,
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ))
      ],
    );
  }
}
