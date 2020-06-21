import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicalrecord/screens/records/editEvents.dart';
import 'package:provider/provider.dart';
import 'package:medicalrecord/models/user.dart';

class eventList extends StatefulWidget {
  @override
  _eventListState createState() => _eventListState();
}

class _eventListState extends State<eventList> {
  @override
  
  Widget build(BuildContext context) {

      final user = Provider.of<User>(context);



   return new StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('userHasEvents')
          .document(user.uid)
          .collection('events')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return new Text("lmao");
        } else {
        //  return new Text("wow");
          return ListView(
            
            shrinkWrap: true,
            children: snapshot.data.documents.map((e) {

              return Card(
                              child: new ListTile(
                leading:Column(
                  children: <Widget>[
                   

                    
                  
                    if (e['eventCompletion'] == false)
                     Icon(Icons.check_circle_outline),

                     if (e['eventCompletion'] == true)
                     Icon(Icons.check_circle_outline, color: Colors.green,),

                
                    
                    
        

                    new RichText(

                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(text:'${e['date']}\n'),
                          TextSpan(text:'${e['time']}'),

                        ]
                      ),
                    ),
                  ],
                ),
                  title: new Text('${e['visitReason']}',style: TextStyle( fontSize: 15.0),),
                  subtitle: new Text('${e['note']}\nDr. ${e['doctor']}, ${e['specialization']}\n${e['hospital']}, ${e['location']}',
                  
                  style: TextStyle( fontSize: 14.0)
                  
                  
                  
                  ),
                  isThreeLine: true,
                  onTap: () {

                      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => editEvent(e),
          
            
          ),
        );
                   },
                  trailing: IconButton(
                    icon: Icon(Icons.delete_sweep),
                    onPressed: (){
                      Firestore.instance.collection('userHasEvents').document(user.uid).collection('events').document(e.documentID).delete();
                    }
                  

                    ),
                  
          
                  
         
                ),
              );
            }).toList(),
          );
        }
      },
    );
  }
}