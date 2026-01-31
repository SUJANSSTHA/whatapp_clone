import 'package:whatapp_clone/features/user/domain/repository/user_repository.dart';

class SignOutUsercase{
  final UserRepository repository;
  SignOutUsercase({required this.repository});

  Future<void> call()async{
    // final uid = await repository.getCurrentUID();
    return repository.isSignout();
    // return uid != null && uid.isNotEmpty;
  }
}