import 'dart:io';
import 'package:wifi_ip/wifi_ip.dart';
import 'dart:convert';

class BroadcastServer {
  RawDatagramSocket udpSocket;
  InternetAddress destinationAddress;
  final int port = 8889;
  WifiIpInfo ips;

  BroadcastServer();

  /// Initialize UDP that listens on all adapters IP addresses
  init() async {
    this.udpSocket =
        await RawDatagramSocket.bind(InternetAddress.anyIPv4, port);
    udpSocket.broadcastEnabled = true;
    this.ips = await WifiIp.getWifiIp;
    this.destinationAddress = InternetAddress(this.ips.broadcastIP);
  }

  close() {
    this.udpSocket.close();
  }

  broadcastServerInfo(String sessionName) {
    List<int> data = utf8.encode("$sessionName ${this.ips.ip}");
    udpSocket.send(data, this.destinationAddress, port);
  }
}
