import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatapp_clone/features/user/user_injection_container.dart';

final sl = GetIt.instance;

Future<void> init() async {
  try {
    // Initialize Firebase first
    // Uncomment and configure if you haven't set up Firebase in your app yet
    // await Firebase.initializeApp();
    
    // final FirebaseFirestore firebase = FirebaseFirestore.instance;
    // final FirebaseAuth auth = FirebaseAuth.instance;
    // final firebase = FirebaseFirestore.instance;
    // final auth = FirebaseAuth.instance;
    // sl.registerLazySingleton( FactoryFunc()=> auth);
    // sl.registerLazySingleton( FactoryFunc()=> firebase);

      final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;

  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => fireStore);
    
    
    await userInjectionContainer();
  } catch (e) {
    print('Error during dependency injection: $e');
  }
}