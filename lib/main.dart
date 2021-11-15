import 'package:flutter/material.dart';
import 'dart:async';
import 'package:totp/totp.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
// final String encodedSecret =
//       "HA3TCZLDHFSTCZJRGIZDCMBTG4";

  //

  // final otpAuthUri =
  //     "otpauth://totp/OOTP:Tester?secret=${encodedSecret}&issuer=OOTP&period=${totp.period}&digits=${totp.digits}";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // Hide the debug banner
        debugShowCheckedModeBanner: false,
        title: 'Marcus',
        home: HomeScreen());
  }
}

// TOTP? totp;

String metodoOtp = metodo().toString();

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // This list hold the items of the list view
  // String OTP = metodo();
  // TOTP OTP = totp as TOTP;
  String OTP = metodoOtp;
  // This variable determines whether the timer runs or not
  bool _isRunning = true;

  // This function will be triggered every 1 second
  void _addItem() {
    final DateTime now = DateTime.now();
    //setState(() {
    //  opa =  metodo();
    // _items.add("${now.hour}:${now.minute}:${now.second}");
    //OTP=opa;

    //print("otp: ${OTP.toString()}");
    // print("uri: ${otpAuthUri}");

    // });
  }

  Timer? _timer;
  @override
  void initState() {
    _timer = new Timer.periodic(Duration(seconds: 3), (Timer timer) {
      setState(() {
        OTP = metodoOtp;
      });
      //_addItem();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marcus OTP'),
      ),
      body: FutureBuilder(
        builder: (ctx, snapshot) {
          // Checking if future is resolved or not
          if (snapshot.connectionState == ConnectionState.done) {
            // If we got an error
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occured',
                  style: TextStyle(fontSize: 18),
                ),
              );

              // if we got our data
            } else if (snapshot.hasData) {
              Future.delayed(Duration(seconds: 5), () {
                setState(() {
                  OTP = metodoOtp;
                });
                // throw Exception("Custom Error");
              });
              // Extracting data from snapshot object
              String data = snapshot.data as String;
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Digite no portal',
                    ),
                    Text(
                      '${data}',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                ),
              );
            }
          }

          // Displaying LoadingSpinner to indicate waiting state
          return Center(
            child: CircularProgressIndicator(),
          );
        },
        future: metodo(),
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
