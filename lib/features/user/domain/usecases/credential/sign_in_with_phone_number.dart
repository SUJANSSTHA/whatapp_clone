import 'package:whatapp_clone/features/user/domain/repository/user_repository.dart';

class SignInWithPhoneNumberUseCase{
  final UserRepository repository;
  SignInWithPhoneNumberUseCase({required this.repository});

  Future<void> call(String smsPinCode)async{
    // final uid = await repository.getCurrentUID();
    return repository.signInWithPhoneNumber(smsPinCode);
    // return uid != null && uid.isNotEmpty;
  }
}