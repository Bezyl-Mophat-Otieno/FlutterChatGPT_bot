// import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dart_openai/openai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_gpt_bot/components/chart_message.dart';
import 'package:jumping_dot/jumping_dot.dart';

import '../components/threedots.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  //Controller for the Texinput field
  final TextEditingController _controller = TextEditingController();

  //List of messages from the both the API and the user
  List<ChatMessage> _messages = [];

  bool isTyping = false;
  //This method accepts a user's message and return the response
  Future<String> completeChat(List<ChatMessage> messages) async {
    OpenAI.apiKey = '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';
    final chatCompletion = await OpenAI.instance.chat.create(
      model: 'gpt-3.5-turbo',
      messages: [
        OpenAIChatCompletionChoiceMessageModel(
          role: OpenAIChatMessageRole.user,
          content: messages[0].content,
        ),
      ],
    );
    //creating a message instance with the api's response
    ChatMessage message = ChatMessage(
      sender: "openAI",
      content: chatCompletion.choices.first.message.content,
      isUserMessage: false,
    );
    setState(() {
      _messages.insert(0, message);
      isTyping = false;
    });
    return chatCompletion.choices.first.message.content;
  }

  void sendMessage() async {
    // creating a message instance with the user's message
    ChatMessage message = ChatMessage(
      sender: "user",
      content: _controller.text,
      isUserMessage: true,
    );
    //setting the state of the _message
    setState(() {
      _messages.insert(0, message);
      isTyping = true;

      //clear the Controller
      _controller.clear();
    });
    _controller.clear();
    await completeChat(_messages);
  }

// Create a widget that returns a widget tree comprising of the TextField and the Send button
  Widget _buildTextComposer() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            onSubmitted: (value) => sendMessage(),
            decoration:
                InputDecoration.collapsed(hintText: "Enter Your Message"),
          ),
        ),
        IconButton(onPressed: () => sendMessage(), icon: Icon(Icons.send))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
        title: const Text(
          'Chat GPT',
        ),
        centerTitle: true,
      ),
      body: Column(children: [
        Flexible(
          child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.fromLTRB(10, 10, 20, 20),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _messages[index];
              }),
        ),
        isTyping
            ? JumpingDots(
                color: Colors.black26,
                radius: 10,
                numberOfDots: 3,
                animationDuration: Duration(milliseconds: 200),
              )
            : const Divider(
                height: 1,
              ),
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: _buildTextComposer(),
          ),
        )
      ]),
    );
  }
}
