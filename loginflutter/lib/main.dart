import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:loginflutter/paginaInicial.dart';

void main() => runApp(new MyApp());

String username='';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login PHP',
      home: MyHomePage(),   
      routes: <String,WidgetBuilder>{
      '/PaginaInicial':  (BuildContext context)=> PaginaInicial(username:username,),
      }
          );
        }
      }
      class MyHomePage extends StatefulWidget {
        @override
        _MyHomePageState createState() => _MyHomePageState();
      }
      
      class _MyHomePageState extends State<MyHomePage> {

        TextEditingController user = TextEditingController();
        TextEditingController pass = TextEditingController();

        String msg ='';

        Future<List> _login() async {
          final response = await http.post("http://192.168.42.66/my_store/login.php", body: {
              "username": user.text,
              "password": pass.text,
          });
          var datauser = json. decode(response.body);
          if(datauser.length==0){
            setState(() {
              msg = "login falha";
            });
          }else{
           Navigator.pushReplacementNamed(context, '/PaginaInicial');
           setState(() {
             username=datauser[0]['username'];
           });
          }

          return datauser;
        }

        @override
        Widget build(BuildContext context) {
          return Scaffold(
            appBar: AppBar(title: Text('Login'),),
            body: Container(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text('Username', style: TextStyle(fontSize: 18),),
                    TextField(
                      controller: user,
                      decoration: InputDecoration(
                        hintText: 'Usename'
                      ),
                    ),
                    Text('Password', style: TextStyle(fontSize: 18),),
                    TextField(
                      controller: pass,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password'
                      ),
                    ),
                    RaisedButton(
                      child: Text("login"),
                      onPressed: (){
                        _login();
                      },
                    ),
                    Text(msg,style: TextStyle(fontSize: 20.0,
                    color: Colors.red),)
                  ],
                ),

              ),
            ),
            
          );
        }
      }