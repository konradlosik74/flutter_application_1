import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'second_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => MyApp(),
      '/second': (context) => SecondScreen(),
    },
  ));
}

class MyApp extends StatelessWidget {
  final TextEditingController _textController = TextEditingController();
  TextEditingController _textController2 = TextEditingController();

  Future<void> saveValue(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String?> readValue(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

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
              //MyListView(),
              TextField(
                controller: _textController,
                decoration: InputDecoration(
                  labelText: 'Wprowadź tekst',
                  hintText: 'Tutaj wpisz swoją wiadomość',
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  enteredText2 = _textController.text;
                  print(enteredText2);
                  await saveValue('myKey', enteredText2);
                },
                child: Text('Zapisz'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final value = await readValue('myKey');
                  print('Saved value: $value');
                  _textController.text = '$value';
                },
                child: Text('odczyt'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Otwórz drugi ekran po naciśnięciu przycisku
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

/* class MyListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20, // Liczba elementów na liście
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text('Element $index'),
          // Dodaj dowolne inne elementy, takie jak obrazki, przyciski itp.
        );
      },
    );
  }
} */
