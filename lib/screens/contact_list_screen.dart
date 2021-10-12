import 'package:flutter/material.dart';
import 'package:hive_database/widgets/contact_list.dart';
import 'package:provider/provider.dart';
import 'package:hive_database/models/contact_data.dart';

class ContactListScreen extends StatelessWidget {
  const ContactListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get list of contacts but do not listen (would trigger a loop)
    Provider.of<ContactsData>(context, listen: false).getContacts();

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Contacts'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ContactsList(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/AddContactScreen');
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
