import 'package:flutter/material.dart';

import 'second_screen.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => MyApp(), //FirstScreen(),
      '/second': (context) => SecondScreen(),
    },
  ));
}

class MyApp extends StatelessWidget {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _textController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String enteredText2 = '';

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Zapis danych do zmiennej '),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _textController2,
                readOnly: true,
                style: TextStyle(color: Colors.red),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    enabledBorder:
                        UnderlineInputBorder(borderSide: BorderSide.none)),
              ),
              TextField(
                controller: _textController,
                decoration: InputDecoration(
                  labelText: 'Wprowadź tekst',
                  hintText: 'Tutaj wpisz swoją wiadomość',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  enteredText2 = 'Wprowadzony tekst: ' + _textController.text;
                  _textController2.text = enteredText2;
                  print(enteredText2);
                },
                child: Text('Zapisz'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Otwórz drugi ekran po naciśnięciu przycisku
                  //Navigator.push(context,MaterialPageRoute(builder: (context) => SecondScreen()));
                  //+przekaz params
                  Navigator.pushNamed(context, '/second',
                      arguments: 'Hello from FirstScreen + $enteredText2');
                },
                child: Text('Otwórz drugi ekran'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
