import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatProvider extends ChangeNotifier {
  var messages = [];

  addMessage(message) {
    messages.add(message);
    print(messages);
    notifyListeners();
  }

  getMessages() {
    print(messages);
    return messages;
  }
}
