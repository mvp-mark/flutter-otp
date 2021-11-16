import 'package:flutter/material.dart';
import 'package:permission_asker/permission_asker.dart';
import 'package:totp/controller/imei_controller.dart';
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

ImeiController imei = ImeiController();
String metodoOtp = metodo(imei).toString();

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // This list hold the items of the list view
  String OTP = metodoOtp;
  // This variable determines whether the timer runs or not
  bool _isRunning = true;
  String? totp;
  // This function will be triggered every 1 second

  Timer? _timer;
  @override
  void initState() {
    // ignore: unnecessary_new
    imei.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Marcus OTP'),
      ),
      body: FutureBuilder(
        future: metodo(imei),
        builder: (ctx, snapshot) {
          final data = snapshot.data;
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
              Future.delayed(Duration(milliseconds: 30010), () {
                setState(() {});
              });

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Digite no portal',
                    ),
                    Text(
                      '${data}',
                      style: Theme.of(context).textTheme.headline1,
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
        // future: metodo(imei),
      ),
    );
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }
}
