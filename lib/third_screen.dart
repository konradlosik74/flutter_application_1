import 'package:flutter/material.dart';

class ThirdScreen extends StatelessWidget {
  final items = List<ListItem>.generate(
    30,
    (i) => i % 6 == 0
        ? HeadingItem('Nagłówek $i')
        : MessageItem('Nadawca $i', 'Treść wiadomości $i'),
  );
  void _addItem(String item) {
    //setState(() {
    items.add(HeadingItem(item));
    //});
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;

    return Scaffold(
      appBar: AppBar(title: Text('3 ekran ')),
      body: //Center(

          ListView.builder(
        itemCount: items.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            title: item.buildTitle(context),
            subtitle: item.buildSubtitle(context),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddItemPage(onAddItem: _addItem),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      //);
      //}

      /* child: Text(            'Witaj na 3 ekranie! Params przekazane z pierwszego ekranu: $args'),      ) */
      //);
    );
  }
}

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

class AddItemPage extends StatefulWidget {
  final Function(String) onAddItem;

  AddItemPage({required this.onAddItem});

  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Item name',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.onAddItem(_controller.text);
                Navigator.pop(context);
              },
              child: Text('Add Item'),
            ),
          ],
        ),
      ),
    );
  }
}
