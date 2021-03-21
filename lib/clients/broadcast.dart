import 'dart:io';
import 'dart:convert';

class BroadcastClient {
  RawDatagramSocket udpSocket;
  final int port = 8889;

  BroadcastClient();

  /// Initialize UDP that listens on all adapters IP addresses
  init() async {
    this.udpSocket =
        await RawDatagramSocket.bind(InternetAddress.anyIPv4, port);
    udpSocket.broadcastEnabled = true;
  }

  close() {
    this.udpSocket.close();
  }

  listen() {
    Datagram dg = this.udpSocket.receive();
    if (dg != null) {
      final data = utf8.decode(dg.data);
      print("received $data");
    }
  }
}
