import 'package:flutter/material.dart';
import 'package:hive_database/models/contact.dart';
import 'package:hive_database/screens/contact_add_screen.dart';
import 'package:provider/provider.dart';
import 'package:hive_database/models/contact_data.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_database/screens/contact_list_screen.dart';

void main() {
  Hive.registerAdapter(ContactAdapter());
  runApp(const MyApp());
}

Future _initHive() async {
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ContactsData(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => FutureBuilder(
                future: _initHive(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.error != null) {
                      // ignore: avoid_print
                      print(snapshot.error);
                      return const Scaffold(
                        body: Center(
                          child: Text('Error initializing hive data store.'),
                        ),
                      );
                    } else {
                      return const ContactListScreen();
                    }
                  } else {
                    return const Scaffold();
                  }
                },
              ),
          '/AddContactScreen': (context) => ContactAddScreen(),
        },
      ),
    );
  }
}
