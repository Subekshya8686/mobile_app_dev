import 'package:flutter/material.dart';
import 'package:flutter_1/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = "/splash";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    navigate();
    super.initState();
  }


  void navigate() async{
    await Future.delayed(Duration(seconds: 3),(){
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(child: Image.asset("assets/images/toppng.com-colorful-floral-design-png-835x957.png")),
            const CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
