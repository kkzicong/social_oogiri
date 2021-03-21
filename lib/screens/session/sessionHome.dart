import 'package:flutter/material.dart';
import '../../services/broadcast.dart';
import '../../clients/broadcast.dart';
import 'dart:io';
import 'dart:convert';

class SessionHome extends StatelessWidget {
  void onStartPressed() async {
    BroadcastServer bcServer = new BroadcastServer();
    await bcServer.init();
    bcServer.broadcastServerInfo('Session A');
  }

  void onJoinPressed() async {
    BroadcastClient bcClient = new BroadcastClient();
    await bcClient.init();
    bcClient.udpSocket.listen((e) {
      Datagram dg = bcClient.udpSocket.receive();
      if (dg != null) {
        final data = utf8.decode(dg.data);
        print("received $data");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ElevatedButton(
          onPressed: onStartPressed, child: Text('Start LAN session')),
      ElevatedButton(onPressed: onJoinPressed, child: Text('Join LAN session'))
    ]);
  }
}
