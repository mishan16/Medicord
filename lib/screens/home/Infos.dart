import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:medicalrecord/models/user.dart';

class UserInfos extends StatefulWidget {
  @override
  _UserInfosState createState() => _UserInfosState();
}

class _UserInfosState extends State<UserInfos> {
  @override
  
  Widget build(BuildContext context) {

      final user = Provider.of<User>(context);



   return new StreamBuilder(
      stream: Firestore.instance.collection('users').document(user.uid).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return new Text("Loading");
        }
        var userDocument = snapshot.data;
        return new Text(userDocument["firstName"]);
      }
  );
  }
}