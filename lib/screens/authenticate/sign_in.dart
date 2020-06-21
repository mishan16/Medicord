import 'package:flutter/material.dart';
import 'package:medicalrecord/screens/authenticate/forgotPassword.dart';
import 'package:medicalrecord/services/auth.dart';
import 'package:medicalrecord/shared/constants.dart';
import 'package:medicalrecord/shared/loading.dart';

class SignIn extends StatefulWidget {
    final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}


class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
    final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
   return loading ? Loading() : Scaffold(
     backgroundColor: Colors.white,
     appBar: AppBar(
     backgroundColor: Colors.blue,
     elevation:0.0,
     title: Text('Sign in to MediCord'),
     actions: <Widget>[
       FlatButton.icon(
         icon: Icon(Icons.person,
         color: Colors.white,
         ),
         label: Text('Register',
         style: TextStyle(
  color: Colors.white,
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
 SizedBox(height: 40.0),
             Image(
               image:AssetImage('assets/medicalRecord.png'),
               width: 200,

             ),
    
            //  Text(
            //    "Sign In",
            //    textDirection: TextDirection.ltr,
            //   textAlign: TextAlign.left,
            //    style: TextStyle(
            //      fontSize: 25.0,
            //      fontWeight: FontWeight.bold,
            
                 
            //    ),
            //  ),

             SizedBox(height: 40.0),
             TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  validator: (val) => val.isEmpty ? 'Please enter email' : null,
               onChanged: (val){
                 setState(() => email = val.trim() );
               }
             ),
          SizedBox(height: 20.0),
          TextFormField(
            decoration: textInputDecoration.copyWith(hintText: 'Password'),  
            obscureText: true,
             validator: (val) => val.length<6 ? 'The password must be 6 characters long' : null,
            onChanged: (val){
              setState(() => password = val.trim() );
            }, 
          ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.lightBlue[400],
                child:Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white),

                ),
                onPressed: () async{
                  error= '';
                if(_formKey.currentState.validate()){
                  setState(() =>loading = true);

                  dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                  if(result ==null){
                    setState((){ 
                      error = "Email or Password is incorrect";
                      loading = false;
                      
                      });
                  }
                  
                  }
                },
              ),
              SizedBox(height: 20.0),
               Text(error,
               style: TextStyle(
                 color: Colors.red,
                 fontSize:14.0
               )),
                      //Forgot Password

                      Align(
                    alignment: Alignment.bottomRight,
             
                     child:InkWell(
                        onTap:(){
                            Navigator.pushReplacement(context,
                             MaterialPageRoute(builder: (BuildContext context) => ForgotPassword()));

                        } ,
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.black)
                        ),
                      ),
            
                  ),
                




           ],
         ),

       ),

       ),
     );
  } 
  }
