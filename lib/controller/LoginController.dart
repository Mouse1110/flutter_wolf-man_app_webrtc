import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:musicbackground/Screens/LobbyScreen/page/room.dart';
import 'package:musicbackground/model/socketAPI/Index.dart';

class LoginController {
  LoginController({this.context});
  final BuildContext context;

  void loginFinally(bool check, SocketAPI socket) {
    check
        ? Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RoomPage(
                socket: socket,
              ),
            ))
        : print('Login Failer');
  }
}
