import 'package:flutter/material.dart';
import 'package:restaurant_app_3/widgets/mainScreen.dart';

class SplashScreenPage extends StatefulWidget {
  static const routeName = '/splashScreen';
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ToListPages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(5),
            width: 300,
            height: 100,
            child: Column(
              children: [
                Expanded(
                  child: Text(
                    'Welcome to the app',
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Pattaya',
                      color: Colors.grey,
                    ),
                  ),
                ),
                Expanded(
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ToListPages() {
    Future.delayed(Duration(seconds: 8)).then((value) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return MainScreenCustom();
      }));
    });
  }
}
