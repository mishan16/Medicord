import 'package:flutter/material.dart';
import 'package:medicalrecord/screens/authenticate/authenticate.dart';
import 'package:medicalrecord/screens/authenticate/register.dart';
import 'package:medicalrecord/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:medicalrecord/models/user.dart';
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   

   final user = Provider.of<User>(context);
   print(user);
   //return either home or authentication widget
  
  
  if(user == null){
   return Authenticate();
  }else{


    return Home();
  }
  }
}