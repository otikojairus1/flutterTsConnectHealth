import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whats_app/screens/Signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:whats_app/screens/profile.dart';

import 'package:whats_app/screens/services/fbApi.dart';
import 'package:whats_app/screens/widgets/alert.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Signup());
}

class Signup extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Signup> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //bool _isLoading = false;

  // Future<bool> _loginUser(String email, String password) async {
  //   final api = await FBApi.signInWithEmail(
  //     email: emailController.text,
  //     password: passwordController.text,
  //   );
  //   if (api != null) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.healing,
                    size: 26.0,
                  ),
                )),
          ],
          title: Text('TSCONNECT'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'TsConnectHealth',
                      style: TextStyle(
                          color: Colors.purple,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    //forgot password screen
                  },
                  textColor: Colors.purple,
                  child: Text('Forgot Password'),
                ),
                Container(
                  height: 50,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.purple,
                      child: Text('Login to your TSCONNECT account'),
                      onPressed: () async {
                        // setState(() => _isLoading = true);

                        try {
                          UserCredential userCredential = await FirebaseAuth
                              .instance
                              .signInWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WelcomePage()),
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            showAlertDialog(context);
                            //print('No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            showAlertDialog(context);
                          }
                        }

                        // UserCredential user = await FirebaseAuth.instance
                        //     .signInWithEmailAndPassword(
                        //         email: emailController.text,
                        //         password: passwordController.text);

                        // if (user != null) {
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => ProfileApp()),
                        //   );
                        // } else {
                        //   print("issue");
                        // }
                        // bool b = await _loginUser(
                        //     emailController.text, passwordController.text);
                        // //setState(() => _isLoading = false);
                        // if (b == true) {
                        //   Scaffold.of(context)
                        //       .showSnackBar(SnackBar(content: Text("success")));
                        // } else {
                        //   Scaffold.of(context)
                        //       .showSnackBar(SnackBar(content: Text("error")));
                        // }
                        // print(emailController.text);
                        // print(passwordController.text);
                      }),
                ),
                Container(
                    child: Row(
                  children: <Widget>[
                    Text('Does not have account?'),
                    FlatButton(
                      textColor: Colors.blue,
                      child: Text(
                        'Create account',
                        style: TextStyle(fontSize: 20, color: Colors.purple),
                      ),
                      onPressed: () {
                        //signup screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Signin()),
                        );
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ))
              ],
            )));
  }
}
