import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicalrecord/services/auth.dart';
import 'package:medicalrecord/services/database.dart';
import 'package:medicalrecord/shared/loading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'package:medicalrecord/models/user.dart';

import 'dart:io';


class editEvent extends StatefulWidget {
  @override

  _editEventState createState() => _editEventState();
      final DocumentSnapshot e;
  editEvent(this.e);

}

class _editEventState extends State<editEvent> {


      





      final _formKey = GlobalKey<FormState>();
        final DatabaseService dataServices = DatabaseService();

       List<String> _values = new List<String>();
              String _value = '';

      
        String error='';
          File _imageFile;
             String _imageURL ='';
    
           

        // String _path;
        // Map<String,String> _paths;
        // String _extension;
        // FileType _picktype;
        // GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
        bool _uploaded  = false;
        
         

       void initState(){
         _values.addAll([ "Checkup","LabTest","Operation","Vaccination"]);
 
       }

       void _onChangedCategory(String value){
         setState(() {
           _value = value;
           print(_value);
         });
       }

       Future<void> _pickImage(ImageSource source ) async{
         File selected = await ImagePicker.pickImage(source: source);

         setState(() {
           _imageFile = selected;
         });
       }


      Future uploadImage() async{
        if(_imageFile !=null){
        StorageReference reference = FirebaseStorage.instance.ref().child('${DateTime.now()}');
        StorageUploadTask uploadTask = reference.putFile(_imageFile);
         await uploadTask.onComplete;
        print('File Uploaded');    

 
        
        
  

         await reference.getDownloadURL().then((fileURL) {    
     setState(() {    
       _imageURL = fileURL;
            print(fileURL);
     });    
     print(_imageURL);

   });    
        }
      }

      editValue(){
       
      }

  @override
  Widget build(BuildContext context) {
      

    final user = Provider.of<User>(context);

          int group =1;
            bool loading = false;
       DateTime _dateTime = new DateTime.now();
       TimeOfDay _timeOfDay = new TimeOfDay.now(); 

       String doctor=widget.e['doctor'];
       String specialization=widget.e['specialization'];
       String hospital=widget.e['hospital'];
       String location=widget.e['location'];
       String note=widget.e['note'];
       bool _checked = false;
     

       setState((){

                 _value = widget.e['visitReason'];
              }); 
              if(widget.e['eventCompletion'] == true){
                _checked = true;
              }
      String currentImage = widget.e['image'];
  
     

         return loading ? Loading(): Scaffold(
                   backgroundColor:Colors.white,
       appBar: new AppBar(
         title : new Text("Edit Event"),
         backgroundColor: Colors.blue,
          actions:<Widget>[
            FlatButton.icon(

              icon: Icon(Icons.save ,color: Colors.white,),
              label:Text('Save', style: TextStyle(color:Colors.white)),
              onPressed: () async{
  

                 if(_formKey.currentState.validate()){
                        setState(() => loading = true);
                         await uploadImage();
                      dynamic result = await dataServices.updateEachEvent( user.uid,
                      formatDate(_dateTime,[yyyy ,'-', mm,'-',dd]), _timeOfDay.format(context),group,
                      _value,doctor,specialization,hospital,location,note,_checked,_imageURL,formatDate(_dateTime,[yyyy]),widget.e.documentID);
                      
                      if(result ==null){
                        setState(() { 
                        error = "Add event";
                        loading = false;
                        });
                   
                        Navigator.pop(context);
                      }
                         

                      }
          
              },
            )
          ]
       )
       ,body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical:20.0, horizontal:30.0),
          
   child:Form(


         key: _formKey, 


          child:Column(



            children: <Widget>[
                 Text(error,
               style: TextStyle(
                 color: Colors.red,
                 fontSize:14.0
               )),
                Align(
                   alignment:Alignment.bottomLeft,
             child: Text(
                                   
            "Date and Time",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            )
            ),
                ),

        
              
                  Row(
                    children: <Widget>[
                      Text(
            widget.e['date'],
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 16.0,

            )
            ),
           
            IconButton(
                
                color: Colors.blue[400],
                      icon: Icon(Icons.mode_edit,size: 20.0,), 
                onPressed: () async{
                  showDatePicker(context: context,
                   initialDate: _dateTime, 
                   firstDate: DateTime(1940), 
                   lastDate: DateTime.now()).then((date) {
                     if(date !=null){ 
                       setState(() {
                       _dateTime = date;
                     });
                     }
                     
                   });
                },
              ),

              SizedBox(width:40),
        Text(
            widget.e['time'],
            textAlign: TextAlign.left,
            style: TextStyle( 
              fontSize: 16.0,

            )
            ),
           
                IconButton(
                
                color: Colors.blue[400],
                      icon: Icon(Icons.mode_edit,size: 20.0,), 
                onPressed: () async{
                  showTimePicker(context: context, initialTime: _timeOfDay).then((time){
                    setState(() {
                      _timeOfDay = time;
                    });
                  });
                },
              ),
           

                    ],
                  ),
             
             RadioListTile(
              title:Text('New Event'),
            value:1,

            groupValue: group,
            onChanged: (T){
              print(T);

              setState((){

                group=T; 
              }); 
            },


            ),
            RadioListTile(
            value:2,
              title:Text('Follow up'),
            groupValue: group,
            onChanged: (T){
              print(T);

              setState((){

                group=T; 
              }); 
            },

),

  SizedBox(height:40),
                Align(
                   alignment:Alignment.bottomLeft,
             child: Text(
                                   
            "Select Category",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            )
            ),
                ),

            Align(
              alignment:Alignment.bottomLeft,
           
              child: DropdownButton(

              
                value: _value,
                items: _values.map((String value){
                return new DropdownMenuItem(
                  
                  value: value,
                  child: Text('${value}',),


                );
              }).toList(),
               onChanged: (String value){
                 _onChangedCategory(value);

               }),
            ),
 SizedBox(height: 23.0),
             TextFormField(
              
               decoration: InputDecoration(
                 hintText: 'Doctor Name'
               ),
               initialValue: widget.e['doctor'],

               validator: (val) => val.isEmpty ? 'Please enter Doctor\'s Name' : null,
               onChanged: (val){
                 setState(() => doctor = val.trim() );
               }
             ),
          SizedBox(height: 10.0),
           TextFormField(
              
               decoration: InputDecoration(
                 hintText: 'Specialization'
               ),
               initialValue: widget.e['specialization'],
               validator: (val) => val.isEmpty ? 'Please enter Specialization' : null,
               onChanged: (val){
                 setState(() => specialization = val.trim() );
               }
             ),
          SizedBox(height: 10.0),
           TextFormField(
              
               decoration: InputDecoration(
                 hintText: 'Hospital'
               ),
               initialValue: widget.e['hospital'],
               validator: (val) => val.isEmpty ? 'Please enter Hospital' : null,
               onChanged: (val){
                 setState(() => hospital = val.trim() );
               }
             ),
          SizedBox(height: 10.0),
          TextFormField(
              
               decoration: InputDecoration(
                 hintText: 'Location'
               ),
               initialValue: widget.e['location'],
               validator: (val) => val.isEmpty ? 'Please enter Location' : null,
               onChanged: (val){
                 setState(() => location = val.trim() );
               }
             ),
          SizedBox(height: 10.0),
                TextFormField(
              
               decoration: InputDecoration(
                 hintText: 'Note'
               ),
                initialValue: widget.e['note'],
               onChanged: (val){
                 setState(() => note = val.trim() );
               }
             ),
                     SizedBox(height:10),
      
        Align(
                   alignment:Alignment.bottomLeft,
             child: Text(
               
                                   
            "Change Image",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            )
            ),
                ),

          Row(
            children: <Widget>[


              IconButton(

                icon:Icon(Icons.photo_camera),
                onPressed: (){
                  _pickImage(ImageSource.camera);
                },
              ),
              IconButton(

                icon:Icon(Icons.photo_library),
                onPressed: (){
                  _pickImage(ImageSource.gallery);
                },
              )


            ],
          ),
          _imageFile ==null ? Container():{ Image.file(_imageFile,
          height:90.0 , width: 70.0,),

        
          },
              SizedBox(height: 10.0),

              currentImage.trim() !=''  && _imageFile == null ?Image.network(currentImage,  height:90.0 , width: 70.0,): Container(),
          CheckboxListTile(
            title: Text('Event Completed'),
            value : _checked,
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (bool value){
              setState(() {
                _checked = value;

              });
            },

          ),
          

            ],
            
          )
       )
       )
    );
  }
}