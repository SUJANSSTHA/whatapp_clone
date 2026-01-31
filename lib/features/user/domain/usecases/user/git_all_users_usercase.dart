import 'package:whatapp_clone/features/user/domain/entities/user_entity.dart';
import 'package:whatapp_clone/features/user/domain/repository/user_repository.dart';

class GetAllUsersUsercase{
  final UserRepository repository;
  GetAllUsersUsercase({required this.repository});

  Stream<List<UserEntity>> call(){    
    return repository.getAllUsers();  
  }
}