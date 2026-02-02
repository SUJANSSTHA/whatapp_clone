import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatapp_clone/features/app/const/app_const.dart';
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

String _verificationId = "";
  @override
  Future<void> createUser(UserEntity user) async {
    final userCollection = firestore.collection(FirebaseCollectionConst.users);

    final uid = await getCurrentUID();

    final newUser = UserModel(
      email: user.email,
      uid: uid,
      isOnline: user.isOnline,
      phoneNumber: user.phoneNumber,
      username: user.username,
      profileUrl: user.profileUrl,
      status: user.status,
    ).toDocument();

    try {
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
    } catch (e) {
      // throw UnimplementedError();
      throw Exception('Error creating user: $e');
    }
  }

  @override
  Stream<List<UserEntity>> getAllUsers() {
    //*--->
    final userCollection = firestore.collection(FirebaseCollectionConst.users);

    return userCollection.snapshots().map(
      (querySnapshot) =>
          querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList(),
    );
  }

  @override
  Future<String> getCurrentUID() async => auth.currentUser!.uid;

  @override
  Future<List<ContactEntity>> getDeviceNumber() async {
    List<ContactEntity> contacts = [];

    final getContactsData = await ContactsService.getContacts();

    for (var myContact in getContactsData) {
      for (var phoneData in myContact.phones!) {
        contacts.add(
          ContactEntity(
            phoneNumber: phoneData.value,
            label: myContact.displayName,
            //  uid: uid,
            // status: status,
            userProfile: myContact.avatar,
          ),
        );
      }
    }
    return contacts;
  }
  // * ---> getSingleUser
  @override
  Stream<List<UserEntity>> getSingleUser(String uid) {
    final userCollection = firestore
        .collection(FirebaseCollectionConst.users)
        .where("uid", isEqualTo: uid);

    return userCollection.snapshots().map(
      (querySnapshot) =>
          querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList(),
    );
  }


  // * ---> isSignIn
  @override
  Future<bool> isSignIn() async => auth.currentUser?.uid != null;

  
  // * ---> isSignout
  @override  
  Future<void> isSignout() async => auth.signOut();

  // * ---> signInWithPhoneNumber
  @override
  Future<void> signInWithPhoneNumber(String smsPinCode) async{
  try{

  }
  on FirebaseAuthException catch(e){
    if(e.code == 'invalid-verification-code'){
      toast("Invalid Verification Code");
    }else if(e.code == 'quote-exceeded'){
      toast("SMS quota-exceeded");
    }
  }
  
  catch(e){
    toast("Unknown exeption please try again");
  }
  }
  // * ---> updateUser
  @override
  Future<void> updateUser(UserEntity user) async {
    final userCollection = firestore.collection(FirebaseCollectionConst.users);

    Map<String, dynamic> userInfo = {};

    if (user.username != "" && user.username != null) {
      userInfo['username'] = user.username;
    }
    if (user.profileUrl != "" && user.profileUrl != null) {
      userInfo['profileUrl'] = user.profileUrl;
    }
    if (user.isOnline != null) userInfo['isOnLine'] = user.isOnline;
    userCollection.doc(user.uid).update(userInfo);
  }

  
  // * ---> verifyPhoneNumber
  @override
  Future<void> verifyPhoneNumber(String phoneNumber) async {

    phoneVerificationCompleted(AuthCredential authCredential){
      print("phone verified: Token ${authCredential.token}, ${authCredential.signInMethod}",);
    }
    phoneVerificationFailed(FirebaseAuthException firebaseAuthException){
print("phone failed : ${firebaseAuthException.message}, ${firebaseAuthException.code}");
    }

    phoneCodeAutoRetrievalTimeout(String verificationId)
{
  _verificationId = verificationId;
  print("this out : $verificationId");
}    

phoneCodeSent(String verificationId, int? forceResendingToken){
_verificationId = verificationId;
}
    
    
await auth.verifyPhoneNumber(
  phoneNumber: phoneNumber,
  verificationCompleted: phoneVerificationCompleted, 
  verificationFailed: phoneVerificationFailed,
  timeout: const Duration(seconds: 60),
   codeSent: phoneCodeSent,
    codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout,
    );


  }
  
}
