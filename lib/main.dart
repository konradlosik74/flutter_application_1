import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'second_screen.dart';
import 'third_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => MyApp(),
      '/second': (context) => SecondScreen(),
      '/third': (context) => ThirdScreen(),
    },
  ));
}

class MyApp extends StatelessWidget {
  final TextEditingController _textController = TextEditingController();
  TextEditingController _textController2 = TextEditingController();

  final items = List<ListItem>.generate(
    3,
    (i) => i % 6 == 0
        ? HeadingItem('Nagłówek $i')
        : MessageItem('Nadawca $i', 'Treść wiadomości $i'),
  );

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
              //return ListView.builder(itemBuilder: Text('Element 1')),

              /* ListView.builder(
                itemCount: items.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ListTile(
                    title: item.buildTitle(context),
                    subtitle: item.buildSubtitle(context),
                  );
                },
              ), */

              // _buildList(),

              /* SingleChildScrollView(
                  child: Column(children: [
                // Inne elementy UI
                Text('Element 1'),
                Text('Element 2'),
                Text('Element 2'),
                Text('Element 2'),
                // ... Dodaj więcej elementów
              ])), */

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

              ElevatedButton(
                onPressed: () {
                  // Otwórz 3 ekran po naciśnięciu przycisku
                  Navigator.pushNamed(context, '/third',
                      arguments: 'Hello from FirstScreen + $enteredText2');
                },
                child: Text('Otwórz 3 ekran'),
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
/////////
///listview
///
abstract class ListItem {
  Widget buildTitle(BuildContext context);
  Widget buildSubtitle(BuildContext context);
}

class HeadingItem implements ListItem {
  final String heading;
  HeadingItem(this.heading);

  @override
  Widget buildTitle(BuildContext context) {
    return Text(
      heading,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }

  @override
  Widget buildSubtitle(BuildContext context) => const SizedBox.shrink();
}

class MessageItem implements ListItem {
  final String sender;
  final String body;
  MessageItem(this.sender, this.body);

  @override
  Widget buildTitle(BuildContext context) => Text(sender);
  @override
  Widget buildSubtitle(BuildContext context) => Text(body);
}

////////////////////////////
Widget _buildList() {
  return ListView(
    children: [
      _tile('CineArts at the Empire', '85 W Portal Ave', Icons.theaters),
      _tile('The Castro Theater', '429 Castro St', Icons.theaters),
      _tile('Alamo Drafthouse Cinema', '2550 Mission St', Icons.theaters),
      _tile('Roxie Theater', '3117 16th St', Icons.theaters),
      _tile('United Artists Stonestown Twin', '501 Buckingham Way',
          Icons.theaters),
      _tile('AMC Metreon 16', '135 4th St #3000', Icons.theaters),
      const Divider(),
      _tile('K\'s Kitchen', '757 Monterey Blvd', Icons.restaurant),
      _tile('Emmy\'s Restaurant', '1923 Ocean Ave', Icons.restaurant),
      _tile('Chaiya Thai Restaurant', '272 Claremont Blvd', Icons.restaurant),
      _tile('La Ciccia', '291 30th St', Icons.restaurant),
    ],
  );
}

ListTile _tile(String title, String subtitle, IconData icon) {
  return ListTile(
    title: Text(title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
        )),
    subtitle: Text(subtitle),
    leading: Icon(
      icon,
      color: Colors.blue[500],
    ),
  );
}
