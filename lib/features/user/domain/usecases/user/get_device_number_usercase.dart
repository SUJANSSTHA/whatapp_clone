import 'package:whatapp_clone/features/user/domain/entities/contact_entity.dart';
import 'package:whatapp_clone/features/user/domain/repository/user_repository.dart';

class GetDeviceNumberUsercase{
  final UserRepository repository;
  GetDeviceNumberUsercase({required this.repository});

  Future<List<ContactEntity>> call()async{
    return repository.getDeviceNumber();
  }
}