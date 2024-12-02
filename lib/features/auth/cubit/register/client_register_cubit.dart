import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../old_core/functions/checkinternet.dart';

import '../../data/data_source/client_auth_repo.dart';
import '../../data/data_source/google_sigin.dart';

part 'client_register_state.dart';

class ClientRegisterCubit extends Cubit<ClientRegisterState> {
  final ClientAuthRepo clientRegisterRepo;
  ClientRegisterCubit(this.clientRegisterRepo) : super(ClientRegisterInitial());
  static ClientRegisterCubit get(context) => BlocProvider.of(context);
  bool isObscure = true;
  void changeIcon() {
    isObscure = !isObscure;
    emit(ChangeIconState());
  }
  void register(String name,String phone) async {
    if (await checkInternet()) {
      emit(ClientRegisterLoading());
      final result =
          await clientRegisterRepo.
          clientRegisterRepo(name,phone);
      result.fold(
        (l) => emit(ClientRegisterError(l)),
        (r) => emit(ClientRegisterSuccess(r)),
      );
    } else {
      emit(const ClientRegisterError("لا يوجد اتصال بالانترنت"));
    }
  }
     void registerWithGoogle() async {
    if (await checkInternet()) {
      emit(ClientGoogleRegisterLoading());
      final result = await handleSignInWithGoogle();
      result.fold((l) {
        emit(ClientGoogleRegisterError(l));
      }, (r) {
        emit(ClientGoogleRegisterSuccess());
      });
    } else {
      emit(const ClientGoogleRegisterError("لا يوجد اتصال بالانترنت"));
    }
  }
}
