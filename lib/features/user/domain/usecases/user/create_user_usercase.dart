import 'package:whatapp_clone/features/user/domain/entities/user_entity.dart';
import 'package:whatapp_clone/features/user/domain/repository/user_repository.dart';

class CreateUserUseCase{
  final UserRepository repository;
  CreateUserUseCase({required this.repository});

  Future<void> call(UserEntity user)async{
    // final uid = await repository.getCurrentUID();
    return repository.createUser(user);
    // return uid != null && uid.isNotEmpty;
  }
}