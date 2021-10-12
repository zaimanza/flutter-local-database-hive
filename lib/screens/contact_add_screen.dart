import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_database/widgets/common_toast.dart';
import 'package:hive_database/models/contact_data.dart';
import 'package:hive_database/models/contact.dart';

class ContactAddScreen extends StatefulWidget {
  @override
  _ContactAddScreenState createState() => _ContactAddScreenState();
}

class _ContactAddScreenState extends State<ContactAddScreen> {
  late String newContactName;
  late String newContactEmail;
  late String newContactPhone;

  void _addContact(context) {
    /// Validate the client name input
    if (newContactName == null) {
      commonToast("You must include a name.");
      return;
    }
    if (newContactName.length < 3) {
      commonToast("The name must be at least 3 characters.");
      return;
    }

    /// Save contact data, email and phone are optional - null values replaced by empty string
    Provider.of<ContactsData>(context, listen: false).addContact(
      Contact(
        name: newContactName,
        // ignore: unnecessary_null_comparison
        email: (newContactEmail != null) ? newContactEmail : '',
        // ignore: unnecessary_null_comparison
        phone: (newContactPhone != null) ? newContactPhone : '',
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Add A Contact'),
        actions: <Widget>[
          // ignore: deprecated_member_use
          FlatButton(
            child: const Text(
              'Save',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
            onPressed: () {
              _addContact(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Name',
                ),
                onChanged: (nameV) {
                  setState(() {
                    newContactName = nameV;
                  });
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Phone',
                ),
                onChanged: (phoneV) {
                  setState(() {
                    newContactPhone = phoneV;
                  });
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
                onChanged: (emailV) {
                  setState(() {
                    newContactEmail = emailV;
                  });
                },
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
