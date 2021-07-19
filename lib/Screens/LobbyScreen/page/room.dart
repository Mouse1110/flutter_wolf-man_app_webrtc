import 'package:flutter/material.dart';
import 'package:musicbackground/model/OTD/RoomOTD.dart';
import 'package:musicbackground/model/socketAPI/Index.dart';

class RoomPage extends StatefulWidget {
  const RoomPage({Key key, this.socket}) : super(key: key);
  final SocketAPI socket;
  @override
  _RoomPageState createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _maxController = TextEditingController();

  Future refesh() async {
    widget.socket.emitListRoom();
  }

  List<RoomOTD> lRoom = [];

  void parseRoom(dynamic data) {
    setState(() {
      lRoom = (data as List).map((e) => RoomOTD.fromJson(e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    widget.socket.listRoomSocket.listen((data) {
      parseRoom(data);
    });
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: refesh,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                height: size.height,
                margin: EdgeInsets.symmetric(vertical: 50),
                child: Column(
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
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                        height: size.height * 0.4,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: RefreshIndicator(
                          onRefresh: refesh,
                          child: ListView.builder(
                            itemCount: lRoom.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () {},
                                  child: ContainerRoom(
                                    room: lRoom[index],
                                  ));
                            },
                          ),
                        )),
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: size.height * 0.4,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12)),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, -5),
                            blurRadius: 0,
                            color: Colors.blue.withOpacity(0.3))
                      ]),
                  child: Container(
                    margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: TextField(
                                    controller: _nameController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Tên Phòng',
                                    ))),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: TextField(
                                    controller: _maxController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Số lượng',
                                    ))),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        TextButton(
                            onPressed: () {
                              widget.socket.createRoom(_nameController.text,
                                  int.parse(_maxController.text));
                            },
                            child: Text('Tạo Phòng'))
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class ContainerRoom extends StatelessWidget {
  final RoomOTD room;
  const ContainerRoom({Key key, this.room}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 3),
                blurRadius: 5,
                color: Colors.blue.withOpacity(0.3))
          ],
          borderRadius: BorderRadius.circular(12)),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                room.name,
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'SocketID',
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.5,
                    fontSize: 14),
              )
            ],
          ),
          SizedBox(),
          Text(
            '${room.index}',
            style: TextStyle(
                color: Colors.green, fontWeight: FontWeight.w700, fontSize: 18),
          ),
          Text(
            '${room.max}',
            style: TextStyle(
                color: Colors.green, fontWeight: FontWeight.w700, fontSize: 18),
          )
        ],
      ),
    );
  }
}
