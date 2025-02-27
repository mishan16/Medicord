import 'package:firebase_auth/firebase_auth.dart';
import 'package:medicalrecord/models/user.dart';
import 'package:medicalrecord/services/database.dart';

class AuthService {

final FirebaseAuth _auth = FirebaseAuth.instance;


//create the user oject based on firebase user
User _userFromFirebaseUser(FirebaseUser user){
return user != null ? User(uid: user.uid) : null; 
}

//auth change user stream
 
Stream<User> get user{

  return  _auth.onAuthStateChanged.map(_userFromFirebaseUser);

}



//register with email and password

Future registerWithEmailAndPassword(String email, String password, String firstName, String lastName,String bloodGroup,String dob, int gender) async{
  try{
    AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    FirebaseUser user= result.user;
      // create a new document for the user with the uid
  await DatabaseService(uid: user.uid).updateUserData(firstName, lastName,bloodGroup,dob,gender);
    return _userFromFirebaseUser(user);


  }catch(e){
    print(e.toString());
    return null;
  }
}

//sign in with email and password
Future signInWithEmailAndPassword(String email, String password) async{
  try{
    AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user= result.user;



    return _userFromFirebaseUser(user);


  }catch(e){
    print(e.toString());
    return null;
  }
}


Future resetPassword(String email) async{
  try{
return  await _auth.sendPasswordResetEmail(email: email).then((value) => print("success"));
  }catch( error){
    print(error.toString());
  }
}

// signout
Future signOut() async{
  try{
return await  _auth.signOut();
  }catch(e){
    print(e.toString());
    return null; 
  }
}
}