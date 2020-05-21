import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicalrecord/models/userDetails.dart';
class DatabaseService{
final String uid;

DatabaseService({this.uid});

//collection reference 
final CollectionReference userCollection = Firestore.instance.collection('users');

Future updateUserData(String firstName, String lastName, String bloodGroup, String dob, int gender) async{
  try{
return await userCollection.document(uid).setData({

  'firstName': firstName,
  'lastName' : lastName,
  'bloodGroup':bloodGroup,
  'dob':dob,
  'gender' : gender,

  

 

});
  }catch(e){
    print(e.toString());
  }
}

List<userDetails> _userDetailsFromSnapshot(QuerySnapshot snapshot){
  return snapshot.documents.map((doc){
    return userDetails(
      firstName: doc.data['firstName'] ?? '',
        lastName: doc.data['lastName'] ?? '',
          bloodGroup: doc.data['bloodGroup'] ?? '',
            dob: doc.data['dob'] ?? '',
              gender: doc.data['gender'] ?? 1,
              
    );
  });
}

//usereDetails documents


Stream<QuerySnapshot> get users {


  return userCollection.where("uid", isEqualTo: uid).snapshots();

} 
}