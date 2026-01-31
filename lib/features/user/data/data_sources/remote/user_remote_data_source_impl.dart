import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatapp_clone/features/app/const/firebase_collection_const.dart';
import 'package:whatapp_clone/features/user/data/data_sources/remote/user_remote_data_source.dart';
import 'package:whatapp_clone/features/user/data/models/user_model.dart';
import 'package:whatapp_clone/features/user/domain/entities/contact_entity.dart';
import 'package:whatapp_clone/features/user/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:contacts_service/contacts_service.dart';
class UserRemoteDataSourceImpl implements UserRemoteDataSource {

  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  UserRemoteDataSourceImpl({required this.firestore, required this.auth});
  
  
  @override
  Future<void> createUser(UserEntity user) async{
  
  final userCollection = 
  firestore.collection(FirebaseCollectionConst.users);

  final uid = await getCurrentUID();

  final newUser = UserModel(
email: user.email,
uid: uid,
isOnline: user.isOnline,
phoneNumber: user.phoneNumber,
username: user.username,
profileUrl: user.profileUrl,
status: user.status
  ).toDocument();



try{
  userCollection.doc(uid).get().then((userDoc) {
    if (!userDoc.exists) {
      // User does not exist, create a new document
      userCollection.doc(uid).set(newUser);
    } else {
      
      userCollection.doc(uid).update(newUser);
      // User already exists, you can choose to update or ignore
      // print('User with UID $uid already exists.');
    }
  });

}catch(e){
    // throw UnimplementedError();
    throw Exception('Error creating user: $e');
}
  }

  @override
  Stream<List<UserEntity>> getAllUsers() {
   //*--->
     final userCollection = 
  firestore.collection(FirebaseCollectionConst.users);

  return userCollection.snapshots().map((querySnapshot)=>
  querySnapshot.docs.map((e)=>
  UserModel.fromSnapshot(e)).toList());
   
  }

  @override
  Future<String> getCurrentUID()async =>
  auth.currentUser!.uid;

  @override
  Future<List<ContactEntity>> getDeviceNumber() async {
   List<ContactEntity> contacts=[];

   final getContactsData = await ContactsService.getContacts();

   getContactsData.forEach((myContact){
    myContact.phones!.forEach((phoneData){
      contacts.add(ContactEntity(
            phoneNumber: phoneData.value,
        label: myContact.displayName,
        //  uid: uid,
          // status: status,
           userProfile: myContact.avatar,
            ));
    });
   });
   return contacts;
  }

  @override
  Stream<List<UserEntity>> getSingleUser(String uid) {
    // TODO: implement getSingleUser
    throw UnimplementedError();
  }

  @override
  Future<bool> isSignIn() {
    // TODO: implement isSignIn
    throw UnimplementedError();
  }

  @override
  Future<void> isSignout() {
    // TODO: implement isSignout
    throw UnimplementedError();
  }

  @override
  Future<void> signInWithPhoneNumber(String smsPinCode) {
    // TODO: implement signInWithPhoneNumber
    throw UnimplementedError();
  }

  @override
  Future<void> updateUser(UserEntity user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<void> verifyPhoneNumber(String phoneNumber) {
    // TODO: implement verifyPhoneNumber
    throw UnimplementedError();
  }

}