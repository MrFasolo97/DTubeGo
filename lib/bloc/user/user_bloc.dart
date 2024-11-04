import 'package:ovh.fso.dtubego/utils/GlobalStorage/SecureStorage.dart' as sec;
import 'package:bloc/bloc.dart';
import 'package:ovh.fso.dtubego/bloc/user/user_event.dart';
import 'package:ovh.fso.dtubego/bloc/user/user_state.dart';
import 'package:ovh.fso.dtubego/bloc/user/user_response_model.dart';
import 'package:ovh.fso.dtubego/bloc/user/user_repository.dart';
import 'dart:developer' as dev;
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserRepository repository;

  UserBloc({required this.repository}) : super(UserInitialState()) {
    on<FetchAccountDataEvent>((event, emit) async {
      String _avalonApiNode = await sec.getNode();
      String _applicationUser = await sec.getUsername();
      emit(UserLoadingState());
      try {
        String _username =
            event.username != null ? event.username! : _applicationUser;
        if (event.username == "you") {
          _username = await sec.getUsername();
        }
        User? _user = await repository.getAccountData(
            _avalonApiNode, _username, _applicationUser);
        bool _verified =
            await repository.getAccountVerificationOffline(_username);
        if (_user != null) {
          emit(UserLoadedState(user: _user, verified: _verified));
        }
      } catch (e) {
        dev.log(e.toString()+'#1');
        emit(UserErrorState(message: e.toString()+'#1'));
      }
    });

    on<FetchMyAccountDataEvent>((event, emit) async {
      String _avalonApiNode = await sec.getNode();
      String _applicationUser = await sec.getUsername();
      emit(UserLoadingState());
      try {
        User? user = await repository.getAccountData(
            _avalonApiNode, _applicationUser, _applicationUser);
        bool _verified = await repository.getAccountVerificationOffline(_applicationUser);

        if (user != null && user.jsonString?.additionals?.blocking != null) {
          await sec.persistBlockedUsers(
              user.jsonString!.additionals!.blocking!.join(","));
          emit(UserLoadedState(user: user, verified: _verified));
        }
      } catch (e) {
        dev.log(e.toString()+' #2');
        emit(UserErrorState(message: e.toString() + ' #2'));
      }
    });

    on<FetchDTCVPEvent>((event, emit) async {
      String _avalonApiNode = await sec.getNode();
      String _applicationUser = await sec.getUsername();
      emit(UserDTCVPLoadingState());
      try {
        Map<String, int> vtBalance = await repository.getVP(
            _avalonApiNode, _applicationUser, _applicationUser);
        int dtcBalance = await repository.getDTC(
            _avalonApiNode, _applicationUser, _applicationUser);

        emit(
            await UserDTCVPLoadedState(dtcBalance: dtcBalance, vtBalance: vtBalance));
      } catch (e) {
        emit(UserErrorState(message: e.toString()+'#3'));
      }
    });
  }
}
