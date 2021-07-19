import 'package:flutter/material.dart';
import 'package:musicbackground/Screens/LobbyScreen/page/login.dart';
import 'package:musicbackground/model/Public.dart';
import 'package:provider/provider.dart';

class LobbyScreen extends StatefulWidget {
  const LobbyScreen({Key key}) : super(key: key);

  @override
  _LobbyScreenState createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<Public>(
      builder: (context, value, child) {
        return LoginPage();
      },
    ));
  }
}
