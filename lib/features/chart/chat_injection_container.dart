
import 'package:whatapp_clone/features/chart/presentation/cubit/chat/chat_cubit.dart';
import 'package:whatapp_clone/features/chart/presentation/cubit/message/message_cubit.dart';

import '../../main_injection_container.dart';
import 'data/remote/chart_remote_data_source.dart';
import 'data/remote/chart_remote_data_source_impl.dart';
import 'data/repositories_impl/chart_repository_imp.dart';
import 'domain/repositories/chart_repositories.dart';
import 'domain/use_cases/delete_message_usecase.dart';
import 'domain/use_cases/delete_my_chat_usecase.dart';
import 'domain/use_cases/get_messages_usecase.dart';
import 'domain/use_cases/get_my_chat_usecase.dart';
import 'domain/use_cases/seen_message_update_usecase.dart';
import 'domain/use_cases/send_message_usecase.dart';

Future<void> chatInjectionContainer() async {

  // * CUBITS INJECTION

  sl.registerFactory<ChatCubit>(() => ChatCubit(
      getMyChatUseCase: sl.call(),
    deleteMyChatUseCase: sl.call()
  ));

  sl.registerFactory<MessageCubit>(() => MessageCubit(
      getMessagesUseCase: sl.call(),
    deleteMessageUseCase: sl.call(),
    sendMessageUseCase: sl.call(),
    seenMessageUpdateUseCase: sl.call(),
     getAllUsersUsercase: sl.call()
  ));


  // * USE CASES INJECTION


  sl.registerLazySingleton<DeleteMessageUseCase>(() => 
  DeleteMessageUseCase(repository: sl.call()));

  sl.registerLazySingleton<DeleteMyChatUseCase>(
          () => DeleteMyChatUseCase(repository: sl.call()));

  sl.registerLazySingleton<GetMessagesUseCase>(
          () => GetMessagesUseCase(repository: sl.call()));

  sl.registerLazySingleton<GetMyChatUseCase>(
          () => GetMyChatUseCase(repository: sl.call()));

  sl.registerLazySingleton<SendMessageUseCase>(
          () => SendMessageUseCase(repository: sl.call()));

  sl.registerLazySingleton<SeenMessageUpdateUseCase>(
          () => SeenMessageUpdateUseCase(repository: sl.call()));



  // * REPOSITORY & DATA SOURCES INJECTION

  sl.registerLazySingleton<ChatRepository>(
          () => ChartRepositoryImpl(remoteDataSource: sl.call()));

  sl.registerLazySingleton<ChartRemoteDataSource>(() => ChartRemoteDataSourceImpl(
     firestore: sl.call(),
  ));
  

}