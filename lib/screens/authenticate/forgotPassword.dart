  import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicalrecord/screens/authenticate/authenticate.dart';
import 'package:medicalrecord/screens/authenticate/sign_in.dart';
import 'package:medicalrecord/services/auth.dart';
import 'package:medicalrecord/shared/constants.dart';
import 'package:medicalrecord/shared/loading.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  String regEmail;
  final _formKey = GlobalKey<FormState>();
    final AuthService _auth = AuthService();
  String error = '';
  bool loading = false;


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold (
  backgroundColor: Colors.white,
     appBar: AppBar(
     backgroundColor: Colors.redAccent[300],
     elevation:0.0,
     title: Text('Reset Password'),
     actions: <Widget>[
       FlatButton.icon(
         icon: Icon(Icons.arrow_back,
         color: Colors.white,
         ),
     
         label: Text('Back',
         style: TextStyle(
           color:Colors.white,
         ),
         
         ),
         onPressed: (){
           Navigator.pushReplacement(context,
                             MaterialPageRoute(builder: (BuildContext context) => Authenticate()));
         },

       ),
     ],
     ),
      
      body: Container(
  padding: EdgeInsets.symmetric(vertical:20.0, horizontal:50.0),
  child: Form(



         key: _formKey, 
    child: Column(
          children: <Widget>[
            
             SizedBox(height: 20.0),
            Text(
              "Please enter your Registerd email"
            ,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize:16.0,
              

            ),
            ),
      SizedBox(height: 30.0),
             TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    validator: (val) => val.isEmpty ? 'Please enter email' : null,
                 onChanged: (val){
                   setState(() => regEmail = val.trim() );
                 }
               ),


                   SizedBox(height: 20.0),
               Text(error,
               style: TextStyle(
                 color: Colors.red,
                 fontSize:14.0
               )),
   SizedBox(height: 30.0),


                RaisedButton(
                color: Colors.lightBlue[400],
                child:Text(
                  'Reset',
                  style: TextStyle(color: Colors.white),

                ),
                onPressed: () async{
                  error= '';
                if(_formKey.currentState.validate()){
                
        setState(() =>loading = true);

                  try{
                  dynamic result = await _auth.resetPassword(regEmail);
                  }catch(e){
                    setState((){ 
                      error = "Email is not registered";
                      print("holo");
                      loading = false;
                      
                      });
                  }
                  
                 
            Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Authenticate()));
                  
                  
                  }
                },
              ),






           ],
        ),


  ),


      )
     );
  
  }
}