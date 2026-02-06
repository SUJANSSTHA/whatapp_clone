import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatapp_clone/features/user/user_injection_container.dart';

final sl = GetIt.instance;
Future <void> init() async{
    // firestore: sl.call(),
    
    
 final firebase = FirebaseFirestore.instance;
 final auth = FirebaseAuth.instance;
  await userInjectionContainer();
}