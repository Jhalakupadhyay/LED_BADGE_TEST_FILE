import 'package:badgemagic/UI/cell.dart';
import 'package:badgemagic/UI/virtualbadge.dart';
import 'package:badgemagic/bluetooth/core/data/Mode.dart';
import 'package:badgemagic/bluetooth/core/data/Speed.dart';
import 'package:flutter/material.dart';
import 'package:badgemagic/bluetooth/core/data/dataToSend.dart';
import 'package:badgemagic/bluetooth/core/data/Messages.dart';
import 'package:badgemagic/bluetooth/core/DataToByteArrayConverter.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:badgemagic/bluetooth/core/helper/bluetooth.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

List<BluetoothDevice> devices = [];

class _TestScreenState extends State<TestScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // FlutterBluePlus.setLogLevel(LogLevel.verbose, color: true);
  }
  @override
  Widget build(BuildContext context) {
    TextEditingController message = new TextEditingController();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'Badge Magic',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          VirtualBadge(),
          SizedBox(
            height: height * 0.02,
          ),
          Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              controller: message,
              decoration: InputDecoration(
                hintText: 'Enter Message',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.04,
          ),
          Center(
              child: GestureDetector(
            onTap: () {
              // setState(() {
                
              // });
              var data =  DataToSend(messages: [
                Message(hexStrings: message.text),
              ]);


            print("data.messages  ${data.messages[0].hexStrings}")  ;

              // print(" is ${data.messages}");
              scanDevice(data);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.red[600],
              ),
              child: Text(
                'Transfer',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
