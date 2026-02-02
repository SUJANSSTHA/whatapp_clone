import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whatapp_clone/features/user/domain/entities/user_entity.dart';
import 'package:whatapp_clone/features/user/domain/usecases/credential/sign_in_with_phone_number.dart';
import 'package:whatapp_clone/features/user/domain/usecases/credential/verify_phone_number.dart';
import 'package:whatapp_clone/features/user/domain/usecases/user/create_user_usercase.dart';

part 'credential_state.dart';

class CredentialCubit extends Cubit<CredentialState> {
  final SignInWithPhoneNumberUseCase signInWithPhoneNumberUseCase;
  final VerifyPhoneNumberUseCase verifyPhoneNumberUseCase;
  final CreateUserUseCase createUserUseCase;

  CredentialCubit({
    required this.signInWithPhoneNumberUseCase,
    required this.verifyPhoneNumberUseCase,
    required this.createUserUseCase,
  }) : super(CredentialInitial());

  Future<void> submitVerifyPhoneNumber({required String phoneNumber}) async {
    try {
      await verifyPhoneNumberUseCase.call(phoneNumber);
      emit(CredentialPhoneAuthSmsCodeReceived());
    } on SocketException catch (_) {
      //* SocketException chai when internet failure hunxa tate khara ko lagi
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }

  Future<void> submitSmsCode({required String smsCode}) async {
    try {
      await signInWithPhoneNumberUseCase.call(smsCode);
      emit(CredentialPhoneAuthProfileInfo());
    } on SocketException catch (_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }

  Future<void> submitProfileInfo({required UserEntity user}) async {
    try {
      await createUserUseCase.call(user);
      emit(CredentialSuccess());
    } on SocketException catch (_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }
}
