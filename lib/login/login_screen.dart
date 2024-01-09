import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_1/main.dart';
import 'package:flutter_1/registration/registration_screen.dart';
import 'package:flutter_1/widgets/common_text_field.dart';
// import 'package:flutter_1/wi';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = "/Login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool visibility = true;
  bool loading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Login Screen"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  "assets/images/12470272_Wavy_Tech-05_Single-03.jpg",
                  height: 300,
                  width: 300,
                ),
              ),
              const Text(
                "Email",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              SizedBox(
                height: 10,
              ),
              CommonTextFieldState(
                controller: _emailController,
                hintText: "Enter Email",
                prefixIcon: Icon(
                  Icons.mail,
                  color: Colors.lightBlue,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // TextFormField(
              //   autovalidateMode: AutovalidateMode.onUserInteraction,
              //   validator: (String? value) {
              //     if (value == "") {
              //       return "Enter Text";
              //     }
              //     return null;
              //   },
              //   decoration: InputDecoration(
              //     hintText: "Enter Email",
              //     label: Text("Email"),
              //     prefixIcon: Icon(
              //       Icons.mail,
              //       color: Colors.lightBlue,
              //     ),
              //     enabledBorder: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(12),
              //         borderSide:
              //             const BorderSide(color: Colors.black87, width: 1)),
              //     focusedBorder: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(12),
              //         borderSide:
              //             const BorderSide(color: Colors.indigo, width: 1)),
              //   ),
              //   controller: _emailController,
              // ),
              const Text(
                "Password",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? value) {
                  if (value == "") {
                    return "Enter Text";
                  }
                  return null;
                },
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Enter Password",
                  label: Text("Pasword"),
                  prefixIcon: Icon(
                    Icons.key,
                    color: Colors.lightBlue,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: Colors.black87, width: 1)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: Colors.indigo, width: 1)),
                ),
                controller: _passwordController,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 500,
                child: ElevatedButton(
                  onPressed: () async{
                    auth.signInWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passwordController.text);
                  },child: Text("Login"),
                ),
              ),
              Container(
                width: 500,
                child:
                loading == true ? CircularProgressIndicator(
                  strokeWidth: 4.0,
                ):
                ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      try {
                        final user = await auth.createUserWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text);

                        if (user.user != null){
                          setState(() {
                            loading = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Registered Successfully")),
                          );
                        }
                      } on Exception catch (e) {
                        setState(() {
                          loading = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.toString()))
                        );
                        // TODO
                      }
                    },child: Text("Register"),
              ),
              // SizedBox(
              //   height: 10,
              // ),
              // Container(
                // child: Align(
                //     alignment: Alignment.centerRight,
                //     child: InkWell(
                //                         onTap: () {
                //                           Navigator.pushNamed(
                //                               context, RegistrationScreen.routeName);
                //                         },
                //                     child: Text("Register")),,
                //         child: Text("Register Now"))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
