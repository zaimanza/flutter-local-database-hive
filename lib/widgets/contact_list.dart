// Shows our entire list of contacts, made up of contact_tile objects.
import 'package:flutter/material.dart';
import 'contact_tile.dart';
import 'package:provider/provider.dart';
import 'package:hive_database/models/contact_data.dart';

class ContactsList extends StatelessWidget {
  const ContactsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ContactTile(tileIndex: index);
      },
      itemCount: Provider.of<ContactsData>(context).contactCount,
    );
  }
}
