import 'package:assignment_16/screens/home.dart';
import 'package:assignment_16/screens/user_detail.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      // onGenerateRoute: ,
      routes: {
        Home.routeName: (context) => const Home(),
        UserDetailScreen.routeName: (context) => const UserDetailScreen(),
      },
      // home: const Home(),
    );
  }
}
