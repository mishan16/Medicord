import 'package:flutter/material.dart';
import 'package:medicalrecord/screens/wrapper.dart';
import 'package:medicalrecord/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:medicalrecord/models/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
        value: AuthService().user,
          child: MaterialApp(
        home:Wrapper(), 
 
      ),
    );
  }
}



