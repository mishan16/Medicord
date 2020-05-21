import 'package:flutter/material.dart';
import 'package:medicalrecord/services/auth.dart';
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
    final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          // title: Image.asset('assets/medicalRecordwhite.png', fit: BoxFit.contain,width: 120),
          title:Text('Profile'),
          backgroundColor:Colors.blue,
          elevation: 0.0,
          actions:<Widget>[
            FlatButton.icon(

              icon: Icon(Icons.person),
              label:Text('Logout'),
              onPressed: () async{
                await _auth.signOut();
              },
            )
          ]


        ),
    );
  }
}