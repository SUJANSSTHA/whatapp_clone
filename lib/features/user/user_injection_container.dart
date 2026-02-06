import 'package:whatapp_clone/features/user/data/data_sources/remote/user_remote_data_source.dart';
import 'package:whatapp_clone/features/user/data/data_sources/remote/user_remote_data_source_impl.dart';
import 'package:whatapp_clone/features/user/data/repository/user_repository_impl.dart';
import 'package:whatapp_clone/features/user/domain/repository/user_repository.dart';
import 'package:whatapp_clone/features/user/domain/usecases/credential/get_current_uid_usercase.dart';
import 'package:whatapp_clone/features/user/domain/usecases/credential/is_sign_in_usercase.dart';
import 'package:whatapp_clone/features/user/domain/usecases/credential/sign_in_with_phone_number.dart';
import 'package:whatapp_clone/features/user/domain/usecases/credential/sign_out_usercase.dart';
import 'package:whatapp_clone/features/user/domain/usecases/credential/verify_phone_number.dart';
import 'package:whatapp_clone/features/user/domain/usecases/user/create_user_usercase.dart';
import 'package:whatapp_clone/features/user/domain/usecases/user/get_single_user_usecase.dart';
import 'package:whatapp_clone/features/user/domain/usecases/user/git_all_users_usercase.dart';
import 'package:whatapp_clone/features/user/domain/usecases/user/update_user_usercase.dart';
import 'package:whatapp_clone/features/user/presentation/cubit/auth/auth_cubit.dart';
import 'package:whatapp_clone/features/user/presentation/cubit/credential/credential_cubit.dart';
import 'package:whatapp_clone/features/user/presentation/cubit/get_device_number/get_device_number_cubit.dart';
import 'package:whatapp_clone/features/user/presentation/cubit/get_single_user/get_single_user_cubit.dart';
import 'package:whatapp_clone/features/user/presentation/cubit/user/user_cubit.dart';
import 'package:whatapp_clone/main_injection_container.dart';

Future <void> userInjectionContainer() async {

  // * CUBITS INJECTION
// 
  sl.registerFactory<AuthCubit>(()=>AuthCubit(
getCurrentUidUsercase: sl.call(),
isSignInUsercase: sl.call(),
signOutUsercase: sl.call()
  ));

sl.registerFactory<UserCubit>(()=> UserCubit(
getAllUsersUsercase: sl.call(),
updateUserUseCase: sl.call(),
));

sl.registerFactory<GetSingleUserCubit>(()=> GetSingleUserCubit(
getSingleUserUseCase: sl.call(),
));

sl.registerFactory<CredentialCubit>(()=> CredentialCubit(
createUserUseCase: sl.call(),
signInWithPhoneNumberUseCase: sl.call(),
verifyPhoneNumberUseCase: sl.call(),
));

sl.registerFactory<GetDeviceNumberCubit>(()=> GetDeviceNumberCubit(
getDeviceNumberUsercase: sl.call(),

));


  // sl.registerFactory(<>)
  
  // * USE CASES INJECTION


   sl.registerLazySingleton<GetCurrentUidUsercase>(()=>
   GetCurrentUidUsercase(repository: sl.call()));

   sl.registerLazySingleton<IsSignInUsercase>(()=>
   IsSignInUsercase(repository: sl.call()));

   sl.registerLazySingleton<SignOutUsercase>(()=>
   SignOutUsercase(repository: sl.call()));

   sl.registerLazySingleton<CreateUserUseCase>(()=>
   CreateUserUseCase(repository: sl.call()));

   sl.registerLazySingleton<GetAllUsersUsercase>(()=>
   GetAllUsersUsercase(repository: sl.call()));

   sl.registerLazySingleton<UpdateUserUseCase>(()=>
   UpdateUserUseCase(repository: sl.call()));

   sl.registerLazySingleton<SignInWithPhoneNumberUseCase>(()=>
   SignInWithPhoneNumberUseCase(repository: sl.call()));

   sl.registerLazySingleton<VerifyPhoneNumberUseCase>(()=>
   VerifyPhoneNumberUseCase(repository: sl.call()));

   sl.registerLazySingleton<GetSingleUserUsecase>(()=>
   GetSingleUserUsecase(repository: sl.call()));

   
   

  // * RESPOSITORY AND DATA SOUCES INJECTION
  sl.registerLazySingleton<UserRepository>(
    ()=>UserRepositoryImpl(remoteDataSource: sl.call())
  );


sl.registerLazySingleton<UserRemoteDataSource>(()=>
UserRemoteDataSourceImpl(
  firestore: sl.call(),
 auth: sl.call(),
 )
);




}