import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicalrecord/models/userDetails.dart';
import 'package:medicalrecord/models/event.dart';
class DatabaseService{
final String uid;

DatabaseService({this.uid});

//collection reference 
final CollectionReference userCollection = Firestore.instance.collection('users');
final CollectionReference userHasEventCollection = Firestore.instance.collection('userHasEvents');

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
Future updateEvent(String uid, String dateTime, String timeOfDay,int visitType,String visitReason,String doctor,String specialization,String hospital,String location,String note,bool _checked,String image,String year) async{
  return await userHasEventCollection.document(uid).collection('events').document().setData({

  'date': dateTime,
  'time' : timeOfDay,
  'visitType':visitType,
  'visitReason':visitReason,
  'doctor' : doctor,
    'specialization':specialization,
  'hospital':hospital,
  'location' : location,
    'note':note,
  'eventCompletion' : _checked,
  'image':image,
  'year':year

  

 

}).then((value) {
 return value;
});
}

Future updateEachEvent(String uid, String dateTime, String timeOfDay,int visitType,String visitReason,String doctor,String specialization,String hospital,String location,String note,bool _checked,String image,String year,String euid) async{
  return await userHasEventCollection.document(uid).collection('events').document(euid).setData({

  'date': dateTime,
  'time' : timeOfDay,
  'visitType':visitType,
  'visitReason':visitReason,
  'doctor' : doctor,
    'specialization':specialization,
  'hospital':hospital,
  'location' : location,
    'note':note,
  'eventCompletion' : _checked,
  'image':image,
  'year':year

  

 

}).then((value) {
 return value;
});
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

// List<Event> _eventListFromSnapshot(Query snapshot){
//   return snapshot.documents.map('')
// }
//usereDetails documents


Stream<QuerySnapshot> get users {


  return userCollection.where("uid", isEqualTo: uid).snapshots();

} 
}