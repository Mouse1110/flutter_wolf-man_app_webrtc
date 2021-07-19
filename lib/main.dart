import 'package:flutter/material.dart';
import 'package:musicbackground/Screens/LobbyScreen/LobbyScreen.dart';
import 'package:musicbackground/model/Public.dart';
import 'package:provider/provider.dart';

// Dart client
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider(
          create: (context) => Public(), child: LobbyScreen()),
    );
  }
}
