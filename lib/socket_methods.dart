import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:sockets/provider_methods.dart';
import 'package:sockets/socket_client.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;

  Socket get socket => _socketClient;

  void connect() {
    _socketClient.onConnect((data) => print('Connected'));
  }

  void sendMessage(message, id) {
    _socketClient.emit('send-msg', {
      'message': message,
      'id': id,
    });
  }

  void receiveMessages(context) {
    _socketClient.on('broadcast-msg', (data) {
      print('$data received');
      Provider.of<ChatProvider>(context, listen: false).addMessage(data);
    });
  }
}
