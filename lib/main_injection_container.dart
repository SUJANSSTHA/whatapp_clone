import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatapp_clone/features/user/user_injection_container.dart';

import 'features/chart/chat_injection_container.dart';

final sl = GetIt.instance;

Future<void> init() async {
  try {
    // Register Firebase instances
    final auth = FirebaseAuth.instance;
    final fireStore = FirebaseFirestore.instance;

    sl.registerLazySingleton(() => auth);
    sl.registerLazySingleton(() => fireStore);
    
    // Initialize user dependencies
    await userInjectionContainer();
    await chatInjectionContainer();
  } catch (e) {
    print('Error during dependency injection: $e');
    rethrow; // Re-throw to ensure the error is visible in logs
  }
}