import 'package:whatapp_clone/features/user/domain/repository/user_repository.dart';

class IsSignInUsercase{
  final UserRepository repository;
  IsSignInUsercase({required this.repository});

  Future<bool> call()async{
    // final uid = await repository.getCurrentUID();
    return repository.isSignIn();
    // return uid != null && uid.isNotEmpty;
  }
}