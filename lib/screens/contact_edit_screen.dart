import 'package:flutter/material.dart';
import 'package:hive_database/models/contact.dart';
import 'package:provider/provider.dart';
import 'package:hive_database/widgets/common_toast.dart';
import 'package:hive_database/models/contact_data.dart';

class ContactEditScreen extends StatefulWidget {
  final Contact currentContact;
  // ignore: use_key_in_widget_constructors
  const ContactEditScreen({required this.currentContact});

  @override
  _ContactEditScreenState createState() => _ContactEditScreenState();
}

class _ContactEditScreenState extends State<ContactEditScreen> {
  late String newContactName;
  late String newContactEmail;
  late String newContactPhone;

  void _editContact(context) {
    /// Validate the client name input
    // ignore: unnecessary_null_comparison
    if (newContactName == null) {
      commonToast("You must include a name.");
      return;
    }
    if (newContactName.length < 3) {
      commonToast("The name must be at least 3 characters.");
      return;
    }

    /// Save contact data, email and phone are optional - null values replaced by empty string
    Provider.of<ContactsData>(context, listen: false).editContact(
      contact: Contact(
        name: newContactName,
        // ignore: unnecessary_null_comparison
        email: (newContactEmail != null) ? newContactEmail : '',
        // ignore: unnecessary_null_comparison
        phone: (newContactPhone != null) ? newContactPhone : '',
      ),
      contactKey: widget.currentContact.key,
    );
    Navigator.pop(context);
  }

  // Controllers for form text controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    /// Set the initial text field value and state value for the currentClient on initial load
    _nameController.text = widget.currentContact.name;
    newContactName = widget.currentContact.name;

    _phoneController.text = widget.currentContact.phone;
    newContactPhone = widget.currentContact.phone;

    _emailController.text = widget.currentContact.email;
    newContactEmail = widget.currentContact.email;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Edit ${widget.currentContact.name}'),
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
              _editContact(context);
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
                controller: _nameController,
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
                controller: _phoneController,
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
                controller: _emailController,
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
