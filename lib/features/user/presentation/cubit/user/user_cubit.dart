import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whatapp_clone/features/user/domain/entities/user_entity.dart';
import 'package:whatapp_clone/features/user/domain/usecases/user/git_all_users_usercase.dart';
import 'package:whatapp_clone/features/user/domain/usecases/user/update_user_usercase.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UpdateUserUseCase updateUserUseCase;
  final GetAllUsersUsercase getAllUsersUsercase;
  UserCubit({
    required this.updateUserUseCase,
    required this.getAllUsersUsercase,
  }) : super(UserInitial());

  Future<void> getAllusers() async {
    emit(UserLoading());
    final streamResponse = getAllUsersUsercase.call();
    streamResponse.listen((users){
emit(UserLoaded(users: users));
    });
  }
  
  Future<void> updateuser({required UserEntity user})async{
    try{
      await updateUserUseCase.call(user);
    }catch(e){
      emit(UserInitial());
    }
  }
  
}
