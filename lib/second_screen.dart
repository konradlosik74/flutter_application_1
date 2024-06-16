import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;

    return Scaffold(
      appBar: AppBar(title: Text('Drugi ekran ')),
      body: Center(
        child: Text(
            'Witaj na drugim ekranie! Params przekazane z pierwszego ekranu: $args'),
      ),
    );
  }
}
