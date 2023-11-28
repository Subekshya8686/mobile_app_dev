import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'route/route_generator.dart';
import 'splash/splash_screen.dart';
import 'dashboard/dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(appBarTheme: const AppBarTheme(color: Colors.lightBlueAccent)),
      // home: DashBoard()
      initialRoute: SplashScreen.routeName,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // backgroundColor: Colors.purple,
          actions: const [
            Icon(Icons.share),
            Padding(
              padding: EdgeInsets.only(right: 10, left: 20),
              child: Icon(Icons.favorite),
            )
          ],
          centerTitle: true,
          leading: const Icon(Icons.menu),
          title: const Text(
            "My App",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          )),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          color: Colors.pinkAccent,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50)
                          )),
                    ),
                    const Positioned(
                      height: 80,
                      left: 20,
                      right: 20,
                      top: 60,
                      child: Card(
                        child: ListTile(
                            trailing: Icon(Icons.check_circle),
                            title: Text("Subekshya Kayastha"),
                            subtitle: Text("Hellos!!"),
                            leading: CircleAvatar(
                              backgroundImage: AssetImage(
                                  "assets/images/toppng.com-colorful-floral-design-png-835x957.png"),
                              backgroundColor: Colors.black87,
                            )),
                      ),
                    ),
                  ],
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 100,
                  width: 50,
                  color: Colors.indigo,
                ),
                Container(
                  height: 100,
                  width: 50,
                  color: Colors.cyan,
                ),
                Container(
                  height: 100,
                  width: 50,
                  color: Colors.blueAccent,
                ),
              ],
            ),
            Image.asset('assets/images/img.png'),
            Container(
              height: 100,
              width: 100,
              decoration: const BoxDecoration(color: Colors.teal),
              child: const Column(
                children: [
                  Center(
                      child: Text("Flutter",
                          style: TextStyle(color: Colors.white, fontSize: 20))),
                ],
              ),
            ),
            Image.network(
                "https://freepngimg.com/thumb/vector/4-2-vector-png-picture.png"),
            Image.network(
                "https://freepngimg.com/thumb/vector/4-2-vector-png-picture.png"),
            Image.network(
                "https://freepngimg.com/thumb/vector/4-2-vector-png-picture.png"),
            Image.network(
                "https://freepngimg.com/thumb/vector/4-2-vector-png-picture.png"),
            Image.network(
                "https://freepngimg.com/thumb/vector/4-2-vector-png-picture.png"),
            Image.network(
                "https://freepngimg.com/thumb/vector/4-2-vector-png-picture.png"),
            Image.network(
                "https://freepngimg.com/thumb/vector/4-2-vector-png-picture.png"),
            Image.network(
                "https://freepngimg.com/thumb/vector/4-2-vector-png-picture.png"),
            Image.network(
                "https://freepngimg.com/thumb/vector/4-2-vector-png-picture.png"),
            Image.network(
                "https://freepngimg.com/thumb/vector/4-2-vector-png-picture.png"),
            Image.network(
                "https://freepngimg.com/thumb/vector/4-2-vector-png-picture.png"),
            Image.network(
                "https://freepngimg.com/thumb/vector/4-2-vector-png-picture.png"),
            Image.network(
                "https://freepngimg.com/thumb/vector/4-2-vector-png-picture.png"),
          ],
        ),
      ),
    );
  }
}
