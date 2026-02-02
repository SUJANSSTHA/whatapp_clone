import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatapp_clone/features/user/domain/entities/user_entity.dart';
class UserModel extends UserEntity {

  @override
  final String? username;
  

  @override
  final String? email;
  @override
  final String? phoneNumber;
  @override
  final bool? isOnline;
  @override
  final String? uid;
  @override
  final String? status;
  @override
  final String? profileUrl;

  const UserModel({
    this.username,
    this.email,
    this.phoneNumber,
    this.isOnline,
    this.uid,
    this.status,
    this.profileUrl,
  }):super(
    username: username,
    email: email,
    phoneNumber: phoneNumber,
    isOnline: isOnline,
    uid: uid,
    status: status,
    profileUrl: profileUrl,
  );

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return UserModel(
      status: data['status'],
      profileUrl: data['profileUrl'],
      phoneNumber: data['phoneNumber'],
      isOnline: data['isOnline'],
      email: data['email'],
      username: data['username'],
      uid: data['uid'],
    );
  }
  Map<String, dynamic> toDocument()=>{
    'username':username,
    'email':email,
    'phoneNumber':phoneNumber,
    'isOnline':isOnline,
    'uid':uid,
    'status':status,
    'profileUrl':profileUrl,
  };
}