import 'package:flutter/material.dart';
import 'package:base32/base32.dart';
import 'package:ootp/ootp.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}
final String encodedSecret =
      "MU2TSNRZG5TGKMBYGAZDCMJTMM3GIMJVMZRTINDFGI3WGZRVMQ4Q";
  final secret = base32.decode(encodedSecret);
  final totp = TOTP.secret(secret);

  final otpAuthUri =
      "otpauth://totp/OOTP:Tester?secret=${encodedSecret}&issuer=OOTP&period=${totp.period}&digits=${totp.digits}";


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // Hide the debug banner
        debugShowCheckedModeBanner: false,
        title: 'Kindacode.com',
        home: HomeScreen());
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // This list hold the items of the list view
  String OTP = totp.make();

  // This variable determines whether the timer runs or not
  bool _isRunning = true;

  // This function will be triggered every 1 second
  void _addItem() {
    final DateTime now = DateTime.now();
    setState(() {
      // _items.add("${now.hour}:${now.minute}:${now.second}");
      OTP = totp.make();
  print("otp: ${totp.make()}");
  print("uri: ${otpAuthUri}");
    });
  }

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (!_isRunning) {
        timer.cancel();
      }
      _addItem();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP'),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent. 
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Digite no portal',
            ),
            Text(
              '${OTP}',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
        //     floatingActionButton: FloatingActionButton(
        // onPressed: () {
        //   setState(() {
        //     _isRunning = false;
        //   });
        // },
        // child: Icon(Icons.stop_circle),
      // ),
    );
  }
}