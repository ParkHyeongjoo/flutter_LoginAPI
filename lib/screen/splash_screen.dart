import 'package:daeng_time/screen/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _init();
  }
  
  void _init() async {
    Navigator.push(
      context, MaterialPageRoute(builder: (context) => LoginScreen())
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffffa502),
      body: Column(
        children: [
          Column(
            children: [
              Text('Daeng', style: TextStyle(color: Colors.white, fontSize: 120, fontWeight: FontWeight.bold),),
              Text('Time', style: TextStyle(color: Colors.white, fontSize: 120, fontWeight: FontWeight.bold),)
            ],
          ),
          Image.asset('assets/splash.png')
        ],
      ),
    );
  }

}
