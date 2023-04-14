import 'package:flutter/material.dart';
import 'package:flutter_chat_gpt_bot/pages/chat_page.dart';
import 'package:dart_openai/openai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  void submit() {
    print('hello');
  }

  @override
  Widget build(BuildContext context) {
    dotenv.load(fileName: ".env");
    OpenAI.apiKey = dotenv.env['API_KEY']!;
    return MaterialApp(home: ChatPage());
  }
}
