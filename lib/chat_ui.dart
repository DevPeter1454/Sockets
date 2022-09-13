import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sockets/provider_methods.dart';
import 'package:sockets/socket_methods.dart';

class ChatUi extends StatefulWidget {
  const ChatUi({Key? key}) : super(key: key);

  @override
  State<ChatUi> createState() => _ChatUiState();
}

class _ChatUiState extends State<ChatUi> {
  final _message = TextEditingController();

  int currentUserId = 1;
  
  var yay = 0;
  void sendMessage() {
    print(_message.text);
    
  }

  @override
  void initState() {
    super.initState();
    SocketMethods().connect();
    SocketMethods().receiveMessages(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chat UI'),
        ),
        body: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: Provider.of<ChatProvider>(context, listen: true)
                        .getMessages()
                        .length,
                    itemBuilder: ((context, index) {
                      return chatWidget(index);

                      // print(yay);
                      // return chatWidget(messages[index]);
                    }))),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextField(
                        controller: _message,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          // border: OutlineInputBorder(),
                          hintText: 'Type a message',
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                      )),
                ),
                IconButton(
                  onPressed: () {
                    SocketMethods()
                        .sendMessage(_message.text.trim(), currentUserId);
                    _message.clear();
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            )
          ],
        ));
  }

  chatWidget(index) {
    var messages = Provider.of<ChatProvider>(context).getMessages();
    if (messages[index]['id'] == currentUserId) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20).copyWith(
                      // topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${messages[index]['message']}'),
              ))),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20).copyWith(
                      // topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${messages[index]['message']}'),
              ),
            )),
      );
    }
  }
}
