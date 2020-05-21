import 'package:flutter/material.dart';

 class PaginaInicial extends StatelessWidget {
   PaginaInicial({this.username});
   String username;


   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(title: Text("Pagina Inicial"),),
       body: Column(
         children: <Widget>[
           Text("hello $username")
         ],
         
       ),
       
     );
   }
 }