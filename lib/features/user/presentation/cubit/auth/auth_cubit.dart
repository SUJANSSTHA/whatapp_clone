import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whatapp_clone/features/user/domain/usecases/credential/get_current_uid_usercase.dart';
import 'package:whatapp_clone/features/user/domain/usecases/credential/is_sign_in_usercase.dart';
import 'package:whatapp_clone/features/user/domain/usecases/credential/sign_out_usercase.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  // final GetAllUsersUsercase getAllUsersUsercase;
  final IsSignInUsercase isSignInUsercase;
  final SignOutUsercase signOutUsercase;
  final GetCurrentUidUsercase getCurrentUidUsercase;

  AuthCubit({
    // required this.getAllUsersUsercase,
    required this.getCurrentUidUsercase,
    required this.isSignInUsercase,
    required this.signOutUsercase,
  }) : super(AuthInitial());

  Future<void> appStarted() async {
    try {
      bool isSignIn = await isSignInUsercase.call();

      if (isSignIn) {
        final uid = await getCurrentUidUsercase.call();
        emit(Authenticated(uid: uid));
      } else {
        emit(unAuthenticated());
      }
    } catch (_) {
      emit(unAuthenticated());
    }
  }

  Future<void> loggedIn() async {
    try {
      final uid = await getCurrentUidUsercase.call();
      emit(Authenticated(uid: uid));
    } catch (_) {
      emit(unAuthenticated());
    }
  }

  Future<void> loggedOut() async {

try{
  await signOutUsercase.call();
  emit(unAuthenticated());

}
catch(_){
  emit(unAuthenticated());
}




  }
}
