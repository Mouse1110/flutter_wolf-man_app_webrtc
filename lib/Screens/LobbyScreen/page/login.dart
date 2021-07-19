import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musicbackground/controller/LoginController.dart';
import 'package:musicbackground/model/socketAPI/Index.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key key,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _tNameController;
  TextEditingController _tPhoneController;
  String socketID;
  SocketAPI socket = new SocketAPI();
  LoginController _loginController;

  bool isConnect = false;
  @override
  void initState() {
    _tNameController = TextEditingController();
    _tPhoneController = TextEditingController();
    socket.init();
    super.initState();
  }

  @override
  void dispose() {
    _tNameController.dispose();
    _tPhoneController.dispose();
    socket.dispose();
    super.dispose();
  }

  void loaded(bool data) {
    data ? print('Connected') : print('DisConnected');
    setState(() {
      isConnect = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    _loginController = LoginController(context: context);
    socket.connectSocket.listen((data) => {loaded(data)});
    socket.loginSocket
        .listen((data) => {_loginController.loginFinally(data, socket)});
    socket.firstSocket.listen((data) {
      socketID = data;
    });
    return isConnect
        ? Container(
            padding: EdgeInsets.symmetric(vertical: 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Wolf Man',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 22,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: _tNameController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Tên của bạn'),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: _tPhoneController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Số điện thoại'),
                      ),
                    ),
                  ],
                ),
                SizedBox(),
                TextButton(
                    onPressed: () {
                      FocusScopeNode current = FocusScope.of(context);
                      if (!current.hasPrimaryFocus) {
                        current.unfocus();
                      }
                      socket.emitLogin(socketID, _tNameController.text,
                          _tPhoneController.text);
                    },
                    child: Text('Bắt Đầu'))
              ],
            ),
          )
        : Center(
            child: CupertinoActivityIndicator(
              radius: 16,
            ),
          );
  }
}
