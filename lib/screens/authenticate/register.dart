import 'package:flutter/material.dart';

import 'package:medicalrecord/services/auth.dart';
import 'package:medicalrecord/shared/constants.dart';
import 'package:medicalrecord/shared/loading.dart';
import 'package:date_format/date_format.dart';
class Register extends StatefulWidget {

   final Function toggleView;

  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
 DateTime _dateTime = null;  

  //text field state

  String email = '';
  String password = '';
  String firstName = '';
  String lastName = '';
  String error = '';
  String bloodGroup = '';
  int group =1;
  bool register = false;
  bool loading = false;

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();


  Widget build(BuildContext context) {
      



    return loading ? Loading(): Scaffold(
     backgroundColor: Colors.white,
     appBar: AppBar(
     backgroundColor: Colors.redAccent[300],
     elevation:0.0,
     title: Text('Sign Up to Medical App'),
     actions: <Widget>[
       FlatButton.icon(
         icon: Icon(Icons.person,
         color: Colors.white,
         ),
     
         label: Text('Sign In',
         style: TextStyle(
           color:Colors.white,
         ),
         
         ),
         onPressed: (){
           widget.toggleView();
         },

       ),
     ],
     ),
     body: SingleChildScrollView(
       padding: EdgeInsets.symmetric(vertical:20.0, horizontal:50.0),
       child:Form(
        key: _formKey, 
         child: Column(
           
           children: <Widget>[

          Text(
               "Register",
               textDirection: TextDirection.ltr,
              textAlign: TextAlign.left,
               style: TextStyle(
                 fontSize: 25.0,
                 fontWeight: FontWeight.bold,
            
                 
               ),
             ),
             SizedBox(height: 20.0),
//EMAIL
             TextFormField(
              
               decoration: textInputDecoration.copyWith(labelText:'Email'),
               validator: (val) => val.isEmpty ? 'Please enter email' : null,
               onChanged: (val){
                 setState(() => email = val.trim() );
               }
             ),
          SizedBox(height: 10.0),

//PASSWORD
          TextFormField(
              decoration: textInputDecoration.copyWith(labelText:'Password'),
              validator: (val) => val.length<6 ? 'The password must be 6 characters long' : null,
              
            obscureText: true,
            onChanged: (val){
              setState(() => password = val.trim() );
            }, 
          ),
              SizedBox(height: 20.0),


//FirstName
             TextFormField(
              
               decoration: textInputDecoration.copyWith(labelText:'First Name'),
               validator: (val) => val.isEmpty ? 'Please enter First Name' : null,
               onChanged: (val){
                 setState(() => firstName = val.trim() );
               }
             ),
          SizedBox(height: 10.0),

//LastName
             TextFormField(
              
               decoration: textInputDecoration.copyWith(labelText:'Last Name'),
               validator: (val) => val.isEmpty ? 'Please enter Last Name' : null,
               onChanged: (val){
                 setState(() => lastName = val.trim() );
               }
             ),
          SizedBox(height: 10.0),
          //Blood Group
             TextFormField(
              
               decoration: textInputDecoration.copyWith(labelText:'Blood Group'),
               validator: (val) => val.isEmpty ? 'Please enter blood group' : null,
               onChanged: (val){
                 setState(() => bloodGroup = val.trim() );
               }
             ),
          SizedBox(height: 15.0),
 //dob         
Row(
  children: <Widget>[
     Align(child: Text(_dateTime == null ? "Date of Birth" :
     
     '${ formatDate(_dateTime,[yyyy ,'-', mm,'-',dd])}',
 
     style: TextStyle(
            
                 fontSize:16.0
     )
     ),
 
    ),
     SizedBox(width: 25.0),
        Align(
      alignment: Alignment.centerRight,
              child:RaisedButton(
                
                color: Colors.grey[400],
                child: Text('Pick a date',
                          style: TextStyle(color: Colors.white),
                   ),
                onPressed: () async{
                  showDatePicker(context: context,
                   initialDate: DateTime.now(), 
                   firstDate: DateTime(1940), 
                   lastDate: DateTime.now()).then((date) {
                     setState(() {
                       _dateTime = date;
                     });
                   });
                },
              ),
    ),
     
    
  ],
),
        SizedBox(height: 15.0),
            //GENDER 
Align(
  alignment: Alignment.bottomLeft,
  child:   Text('Gender',
  
  style: TextStyle(
    fontSize: 16.0,
  
  ),
 
  ),
),

         
            RadioListTile(
              title:Text('Male'),
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
              title:Text('Female'),
            groupValue: group,
            onChanged: (T){
              print(T);

              setState((){

                group=T; 
              }); 
            },

),


 SizedBox(height: 25.0),
  //SIgn UP BUTTON
Row(
  children: <Widget>[
        Align(
      alignment: Alignment.bottomLeft,
                 child: RaisedButton(
                    color: Colors.lightBlue[400],
                    child:Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
    
                    ),
                    onPressed: () async{
                      if(_formKey.currentState.validate()){
                        setState(() => loading = true);
                      dynamic result = await _auth.registerWithEmailAndPassword(email, password,firstName,lastName,bloodGroup,formatDate(_dateTime,[yyyy ,'-', mm,'-',dd]).toString(),group);
                      if(result ==null){
                        setState(() { error = "Please enter valid email";
                        loading = false;
                        });
                      }
                      }
                    },
                  ),
    ),
    
  ],
),
               SizedBox(height: 20.0), 
               Text(error,
               style: TextStyle(
                 color: Colors.red,
                 fontSize:14.0
               ))
           ],
         ),

       ),

       ),
     );
  }
}