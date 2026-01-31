import 'package:whatapp_clone/features/user/domain/repository/user_repository.dart';

class GetCurrentUidUsercase{
  final UserRepository repository;
  GetCurrentUidUsercase({required this.repository});

  Future<String> call()async{
    return await repository.getCurrentUID();
  }
}