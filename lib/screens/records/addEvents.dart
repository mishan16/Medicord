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


class addEvent extends StatefulWidget {
  @override
  _addEventState createState() => _addEventState();
}

class _addEventState extends State<addEvent> {


      final _formKey = GlobalKey<FormState>();
        final DatabaseService dataServices = DatabaseService();

          int group =1;
            bool loading = false;
       DateTime _dateTime = new DateTime.now();
       TimeOfDay _timeOfDay = new TimeOfDay.now(); 
       String _value = '';
       String doctor='';
       String specialization='';
       String hospital='';
       String location='';
       String note='';
       bool _checked = false;
       List<String> _values = new List<String>();
       File _imageFile;
         String _imageURL ='';
        String error='';

        // String _path;
        // Map<String,String> _paths;
        // String _extension;
        // FileType _picktype;
        // GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
        bool _uploaded  = false;
         

       void initState(){
         _values.addAll([ "Checkup","LabTest","Operation","Vaccination"]);
         _value = _values.elementAt(0);
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

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
         return loading ? Loading(): Scaffold(
                   backgroundColor:Colors.white,
       appBar: new AppBar(
         title : new Text("Add Event"),
         backgroundColor: Colors.blue,
          actions:<Widget>[
            FlatButton.icon(

              icon: Icon(Icons.save ,color: Colors.white,),
              label:Text('Save', style: TextStyle(color:Colors.white)),
              onPressed: () async{
  

                 if(_formKey.currentState.validate()){
                        setState(() => loading = true);
                         await uploadImage();
                      dynamic result = await dataServices.updateEvent( user.uid,
                      formatDate(_dateTime,[yyyy ,'-', mm,'-',dd]), _timeOfDay.format(context),group,
                      _value,doctor,specialization,hospital,location,note,_checked,_imageURL,formatDate(_dateTime,[yyyy]));
                      
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
                               '${ formatDate(_dateTime,[yyyy ,'-', mm,'-',dd])}',
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
            _timeOfDay.format(context),
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
             
               onChanged: (val){
                 setState(() => note = val.trim() );
               }
             ),
                     SizedBox(height:10),
      
        Align(
                   alignment:Alignment.bottomLeft,
             child: Text(
               
                                   
            "Add Image",
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
          _imageFile ==null ? Container(): Image.file(_imageFile,
          height:90.0 , width: 70.0,),
              SizedBox(height: 10.0),
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