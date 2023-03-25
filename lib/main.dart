import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
//import 'package:network_info_plus/network_info_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();


}

class _MyHomePageState extends State<MyHomePage> {
  var messageController = TextEditingController();
  var ipController = TextEditingController();
  var portController = TextEditingController();
 // final String _ipAddress = '';


  @override
  void initState() {
    super.initState();
    //_getIp();
  }

  Future<void> sendUdpPacket(String ip, int port, String message) async {
    try {
      // Create a UDP socket
      RawDatagramSocket udpSocket =
      await RawDatagramSocket.bind(InternetAddress.anyIPv4, 0);

      // Send the message to the remote device
      List<int> data = utf8.encode(message);
      udpSocket.send(
        data,
        InternetAddress(ip),
        port,
      );

      // Close the socket
      udpSocket.close();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  // Future<void> _getIp() async {
  //   String? ipAddress;
  //
  //   try {
  //     ipAddress = await NetworkInfo().getWifiIP();
  //   } catch (e) {
  //     print(e.toString());
  //     ipAddress = 'Failed to get IP address.';
  //   }
  //
  //   setState(() {
  //     _ipAddress = ipAddress;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              // Text(
              //   'IP Address $_ipAddress',
              // ),
              const Text(
                'Enter Destination IP Address',
              ),
              TextField(
                controller: ipController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: "192.168.1.100 for iphone",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Enter Destination Port Number',
              ),
              TextField(
                controller: portController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "1234",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Enter Your Message ',
              ),
              TextField(
                controller: messageController,
                decoration: const InputDecoration(hintText: "Hello World!"),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  sendUdpPacket(
                    ipController.text,
                    int.parse(portController.text),
                    messageController.text,
                  );
                },
                child: const Text('Send Message'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
