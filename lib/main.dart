import 'package:flutter/material.dart';
import 'package:todolist/cadastro_page.dart';
import 'package:todolist/home_page.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      initialRoute: "/",
      routes: {
        "/": (context) => HomePage(),
        "/cadastro": (context) => CadastroPage(),
      },
    ),
  );
}
