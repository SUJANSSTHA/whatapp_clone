import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whatapp_clone/features/user/domain/entities/contact_entity.dart';
import 'package:whatapp_clone/features/user/domain/usecases/user/get_device_number_usercase.dart';

part 'get_device_number_state.dart';

class GetDeviceNumberCubit extends Cubit<GetDeviceNumberState> {
  GetDeviceNumberUsercase getDeviceNumberUsercase;
  GetDeviceNumberCubit({
    required this.getDeviceNumberUsercase
  }) : super(GetDeviceNumberInitial());

  Future<void> getDeviceNumber() async {
    try{
      final contactNumbers = await getDeviceNumberUsercase.call();
      emit(GetDeviceNumberLoaded(contacts: contactNumbers));
    }catch(_){
      emit(GetDeviceNumberFailure());
    }
  }
}


