import 'package:flutter/material.dart';
import 'package:one_way_hashing/src/model/encryption.dart';
import 'package:one_way_hashing/src/page/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Encryption(),
      child: MaterialApp(
        title: 'One Way Hash',
        theme: ThemeData(primarySwatch: Colors.green),
        home: const HomePage(),
      ),
    );
  }
}
