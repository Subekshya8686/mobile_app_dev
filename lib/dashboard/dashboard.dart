import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white70,
          title: Text(
            "_softwarica_college_",
            style: TextStyle(color: Colors.black87),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.menu, color: Colors.black87),
            )
          ]),
      body: ListView(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: 100,
                  width: 200,
                  color: Colors.cyan,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                        "assets/images/toppng.com-colorful-floral-design-png-835x957.png"),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  height: 100,
                  width: 200,
                  color: Colors.deepPurpleAccent,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [Text("31" ), Text("posts"), ],
                          ),
                          Column(
                            children: [Text("31"), Text("posts")],
                          ),
                          Column(
                            children: [Text("31"), Text("posts")],
                          ),
                        ],

                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
