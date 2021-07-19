import 'dart:async';

import 'package:musicbackground/model/OTD/LoginOTD.dart';
import 'package:musicbackground/utils/config.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketAPI {
  IO.Socket socket;
  StreamController _controller = new StreamController<dynamic>.broadcast();
  Stream get connectSocket => _controller.stream;

  StreamController _firstController = new StreamController<String>.broadcast();
  Stream get firstSocket => _firstController.stream;

  StreamController _loginController = new StreamController<bool>.broadcast();
  Stream get loginSocket => _loginController.stream;

  StreamController _listRoomController =
      new StreamController<List<dynamic>>.broadcast();
  Stream get listRoomSocket => _listRoomController.stream;

  void init() {
    connect();
    eventSocket();
  }

  void connect() {
    socket = IO.io("http://$ipConfig:3000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false
    });
    socket.connect();
  }

  void dispose() {
    _controller.close();
    _loginController.close();
    _firstController.close();
    _listRoomController.close();
  }

  void eventSocket() {
    socket.onConnect((json) => {_controller.sink.add(true)});
    socket.on('login', (data) => {_loginController.sink.add(data)});
    socket.on('first', (data) => {_firstController.sink.add(data)});
    socket.on('room', (data) => {_listRoomController.sink.add(data)});
  }

  void emitLogin(String id, String name, String phone) {
    LoginOTD acc = LoginOTD(id: id, name: name, phone: phone);
    socket.emit('login', acc.toJson());
  }

  void emitListRoom() {
    socket.emit('room', true);
  }

  void createRoom(String name, int max) {
    socket.emit('createRoom', {'name': name, 'max': max});
  }
}
