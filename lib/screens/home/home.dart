
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicalrecord/screens/home/Infos.dart';
import 'package:medicalrecord/screens/profile/profile.dart';
import 'package:medicalrecord/services/auth.dart';
import 'package:medicalrecord/services/database.dart';
import 'package:provider/provider.dart';
import 'package:medicalrecord/screens/records/records.dart';

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}




class _HomeState extends State<Home> {

  final AuthService _auth = AuthService();
  int _currentIndex = 0;

  final tabs = [

  Center(child:Text('Home')),
  Container(child: Records()),
  Container(child: Profile()),
  ];

   
  @override
  Widget build(BuildContext context) {

      
    return StreamProvider<QuerySnapshot>.value(
      value:DatabaseService().users,
          child: Scaffold(

        backgroundColor: Colors.brown[50],
        // appBar: AppBar(
        //   title: Image.asset('assets/medicalRecordwhite.png', fit: BoxFit.contain,width: 120),
        //   backgroundColor:Colors.cyan[200],
        //   elevation: 0.0,
        //   actions:<Widget>[
        //     FlatButton.icon(

        //       icon: Icon(Icons.person),
        //       label:Text('Logout'),
        //       onPressed: () async{
        //         await _auth.signOut();
        //       },
        //     )
        //   ]


        // ),
        body: tabs[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedFontSize: 15,
          // backgroundColor: Colors.blue,
          items: [
            BottomNavigationBarItem(  icon: Icon(Icons.home),
            title: Text('Home'),
            backgroundColor: Colors.white
            ),
            BottomNavigationBarItem(  icon: Icon(Icons.storage),
            title: Text('Records'),
            backgroundColor: Colors.yellow,
            ),
             BottomNavigationBarItem(  icon: Icon(Icons.person_outline
             
             ),
            title: Text('Profile'),
         
            ),
         
          ],
           onTap:(index){
                    setState(() {
                    _currentIndex = index;
                    });
            }
        ),
      ),
    ); 
  }
}