import 'package:flutter/material.dart';
import 'package:hive_database/screens/contact_edit_screen.dart';
import 'package:hive_database/models/contact_data.dart';
import 'package:provider/provider.dart';
import 'package:hive_database/models/contact.dart';

class ContactViewScreen extends StatelessWidget {
  const ContactViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Delete confirmation dialogue
    void _showDeleteConfirmation(currentClient) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Are You Sure?"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                      'You are about to delete ${currentClient.name} and all of their content.'),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    'You cannot undo this action.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              // ignore: deprecated_member_use
              FlatButton(
                child: const Text('Delete'),
                onPressed: () {
                  // ignore: avoid_print
                  print("Deleting ${currentClient.name}...");
                  Provider.of<ContactsData>(context, listen: false)
                      .deleteContact(currentClient.key);
                  Navigator.popUntil(
                      context, ModalRoute.withName(Navigator.defaultRouteName));
                },
              ),
              // ignore: deprecated_member_use
              FlatButton(
                child: const Text('Cancel'),
                onPressed: () {
                  // ignore: avoid_print
                  print("Canceled delete.");
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Consumer<ContactsData>(builder: (context, contactData, child) {
      Contact currentContact = contactData.getActiveContact();

      return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(currentContact.name),
          actions: <Widget>[
            PopupMenuButton(
              onSelected: (selection) {
                switch (selection) {
                  case 1:
                    // ignore: avoid_print
                    print("Selected Edit");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ContactEditScreen(
                            currentContact: currentContact,
                          );
                        },
                      ),
                    );
                    break;

                  case 2:
                    // ignore: avoid_print
                    print("Selected Delete");
                    _showDeleteConfirmation(currentContact);
                    break;
                }
              },
              itemBuilder: (context) => <PopupMenuEntry>[
                const PopupMenuItem(
                  child: Text("Edit"),
                  value: 1,
                ),
                const PopupMenuItem(
                  child: Text("Delete"),
                  value: 2,
                ),
              ],
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: <Widget>[
                Text(currentContact.email),
                Text(currentContact.phone),
              ],
            ),
          ),
        ),
      );
    });
  }
}
