import 'package:flutter/material.dart';
import 'package:sockets/chat_ui.dart';
import 'package:provider/provider.dart';
import 'package:sockets/provider_methods.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ChatProvider(),
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ChatUi(),
      debugShowCheckedModeBanner: false,
    );
  }
}
