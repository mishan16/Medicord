

import 'package:flutter/material.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:medicalrecord/screens/records/events.dart';
import 'package:medicalrecord/screens/records/prescription.dart';
import 'package:medicalrecord/screens/records/labResults.dart';

class Records extends StatefulWidget {
  @override
  _RecordsState createState() => _RecordsState();
}




class _RecordsState extends State<Records> with SingleTickerProviderStateMixin {


  TabController controller;
  @override
  void initState(){
    super.initState();
    controller = new TabController(length: 3, vsync: this);

  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
       appBar: new AppBar(
         title : new Text("Records"),
         backgroundColor: Colors.blue,
         bottom: new TabBar(
           controller: controller,
           tabs:<Tab>[
             new Tab(icon: new Icon(Icons.event),text: "Events" ),
             new Tab(icon: new Icon(MdiIcons.pill),text: "Prescription"),
             new Tab(icon: new Icon(MdiIcons.file),text: "Lab Results"),
           ]
         )
       ),

       body: new TabBarView(controller:controller,
        children: <Widget>[
          new Events(),
          new Prescription(),
          new LabResults()
          
        ],
       
       ),
    );
  }
}