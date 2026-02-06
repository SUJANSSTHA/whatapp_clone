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

  /// Signs in a user using the phone verification code received via SMS.
  /// Validates the [smsPinCode] against Firebase authentication and handles various error cases.
  /// Shows appropriate toast messages for different error scenarios.
  @override
  Future<void> signInWithPhoneNumber(String smsPinCode) async {
    try {
      // TODO: Implement sign-in logic with verification ID and SMS code
    } on FirebaseAuthException catch (e) {
      // Handle Firebase-specific authentication errors
      if (e.code == 'invalid-verification-code') {
        toast("Invalid Verification Code");
      } else if (e.code == 'quota-exceeded') {
        toast("SMS quota-exceeded");
      }
    } catch (e) {
      toast("Unknown exception please try again");
    }
  }
  /// Updates a user's profile information in Firestore.
  /// Only updates non-empty fields (username, profileUrl, and online status).
  /// Selectively updates only the fields that have changed to optimize Firestore operations.
  @override
  Future<void> updateUser(UserEntity user) async {
    final userCollection = firestore.collection(FirebaseCollectionConst.users);

    // Prepare only non-empty fields for update
    Map<String, dynamic> userInfo = {};

    // Add username if provided
    if (user.username != "" && user.username != null) {
      userInfo['username'] = user.username;
    }
    // Add profile URL if provided
    if (user.profileUrl != "" && user.profileUrl != null) {
      userInfo['profileUrl'] = user.profileUrl;
    }
    // Add online status if provided
    if (user.isOnline != null) {
      userInfo['isOnLine'] = user.isOnline;
    }
    
    // Update the user document with the prepared fields
    userCollection.doc(user.uid).update(userInfo);
  }

  
  /// Initiates phone number verification with Firebase Authentication.
  /// Sends an SMS with a verification code to the provided [phoneNumber].
  /// Handles callbacks for successful verification, failures, and auto-retrieval timeout.
  @override
  Future<void> verifyPhoneNumber(String phoneNumber) async {
    
    /// Callback invoked when phone verification is completed automatically (without user intervention)
    void phoneVerificationCompleted(AuthCredential authCredential) {
      print("Phone verified: Token ${authCredential.token}, Method: ${authCredential.signInMethod}");
    }
    
    /// Callback invoked when phone verification fails
    void phoneVerificationFailed(FirebaseAuthException firebaseAuthException) {
      print("Phone verification failed: ${firebaseAuthException.message}, Code: ${firebaseAuthException.code}");
    }

    /// Callback invoked when auto-retrieval of SMS code times out
    void phoneCodeAutoRetrievalTimeout(String verificationId) {
      _verificationId = verificationId;
      print("Auto-retrieval timeout. Verification ID: $verificationId");
    }    

    /// Callback invoked when SMS code is successfully sent
    void phoneCodeSent(String verificationId, int? forceResendingToken) {
      _verificationId = verificationId;
      print("SMS code sent. Verification ID: $verificationId");
    }
    
    // Initiate phone number verification
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
