import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'second_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => //HomePage(),
          MyApp(), //FirstScreen(),
      '/second': (context) => SecondScreen(),
    },
  ));
}

/* class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
} */

/* class _HomePageState extends State<HomePage> {
  //with RestorationMixin {
  /*RestorableBool _enabled = RestorableBool(false); // Przykład stanu dla przełącznika
  RestorableDouble _value = RestorableDouble(0); // Przykład stanu dla suwaka
  RestorableString _restorableString = RestorableString("");
  @override
  String get restorationId => 'home_page'; // Unikalny identyfikator stanu

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_enabled, 'enabled'); // Rejestrujemy stan
    registerForRestoration(_value, 'value');
    registerForRestoration(_restorableString, 'restorableString');
  }

  // Funkcja resetująca stan do początkowego
  void _reset() {
    setState(() {
      _enabled.value = false;
      _value.value = 0;
      _restorableString.value = '';
    });
  }*/

  // Funkcja resetująca stan do początkowego
  void _reset() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: Duration.zero,
        pageBuilder: (_, __, ___) => HomePage(),
      ),
    );
  }
 */
class MyApp extends StatelessWidget {
  final TextEditingController _textController = TextEditingController();
  //final
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
                  enteredText2 = //'Wprowadzony tekst: ' +
                      _textController.text;
                  //_textController2.text = enteredText2;
                  print(enteredText2);
                  /*_enabled.value = true;
                  _value.value = 0;
                  _restorableString.value = _textController.text;*/
                  await saveValue(
                      'myKey',
                      //_textController
                      //  .text); //
                      enteredText2); //'Hello, Flutter!');
                },
                child: Text('Zapisz'),
              ),
              ElevatedButton(
                onPressed: () async {
                  //_textController.text = await readValue('myKey').toString();
                  //enteredText2 = await readValue('myKey').toString();
                  //await saveValue('myKey', enteredText2); //'Hello, Flutter!');

                  //await saveValue('myKey', 'Hello, Flutter!');
                  final value = await readValue('myKey');
                  print('Saved value: $value');
                  _textController.text = '$value';
                },
                child: Text('odczyt'),
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
