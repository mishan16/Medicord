import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:medicalrecord/screens/records/addEvents.dart';
import 'package:medicalrecord/screens/records/eventlist.dart';
import 'package:provider/provider.dart';
import 'package:medicalrecord/models/user.dart';
class Events extends StatefulWidget {
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  
  @override
  Widget build(BuildContext context) {
        final user = Provider.of<User>(context);

    return Scaffold(
      body:SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical:0.0, horizontal:30.0),
        child: Column(
          children: <Widget>[
            
            SizedBox(height: 20.0),
            Align(
              alignment: Alignment.topRight,
                          child: RaisedButton.icon( icon:  Icon(MdiIcons.plus,color:Colors.white),color: Colors.blue, label: Text('Add Event', style:TextStyle(color:Colors.white)),
              elevation: 5.0,
              
              
              
              
               onPressed: (){

                 Navigator.push(context,
                             MaterialPageRoute(builder: (BuildContext context) => addEvent()));
               },),
            ),

            eventList()

            
          ],
        ),
      ),

    );
    // return Center(
    //   child:Text('Events')
    // );
  }
}