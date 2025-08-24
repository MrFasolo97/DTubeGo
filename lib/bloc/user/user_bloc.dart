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
      emit(UserLoadingState());
      try {
        final _avalonApiNode = await sec.getNode();
        final _applicationUser = await sec.getUsername();

        String _username = event.username ?? _applicationUser;
        if (event.username == "you") {
          _username = _applicationUser;
        }

        User? _user = await repository.getAccountData(
            _avalonApiNode, _username, _applicationUser);

        final _verified = await repository.getAccountVerificationOffline(_username);

        if (_user != null) {
          emit(UserLoadedState(user: _user, verified: _verified));
        } else {
          // FIX: Emit state when user is not found
          emit(UserNotFoundState(username: _username));
          // OR emit error state:
          // emit(UserErrorState(message: 'User $_username not found'));
        }
      } catch (e) {
        dev.log('FetchAccountDataEvent error: $e #1');
        emit(UserErrorState(message: 'Failed to load user data: ${e.toString()} #1'));
      }
    });

    on<FetchMyAccountDataEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        final _avalonApiNode = await sec.getNode();
        final _applicationUser = await sec.getUsername();

        User? user = await repository.getAccountData(
            _avalonApiNode, _applicationUser, _applicationUser);

        final _verified = await repository.getAccountVerificationOffline(_applicationUser);

        if (user != null) {
          // FIX: Handle null blocking list gracefully
          if (user.jsonString?.additionals?.blocking != null) {
            await sec.persistBlockedUsers(
                user.jsonString!.additionals!.blocking!.join(","));
          }
          emit(UserLoadedState(user: user, verified: _verified));
        } else {
          // FIX: Handle case when current user data is not found
          emit(UserErrorState(message: 'Your user data could not be loaded'));
        }
      } catch (e) {
        dev.log('FetchMyAccountDataEvent error: $e #2');
        emit(UserErrorState(message: 'Failed to load your data: ${e.toString()} #2'));
      }
    });

    on<FetchDTCVPEvent>((event, emit) async {
      emit(UserDTCVPLoadingState());
      try {
        final _avalonApiNode = await sec.getNode();
        final _applicationUser = await sec.getUsername();

        final vtBalance = await repository.getVP(
            _avalonApiNode, _applicationUser, _applicationUser);
        final dtcBalance = await repository.getDTC(
            _avalonApiNode, _applicationUser, _applicationUser);

        emit(UserDTCVPLoadedState(dtcBalance: dtcBalance, vtBalance: vtBalance));
      } catch (e) {
        dev.log('FetchDTCVPEvent error: $e #3');
        emit(UserErrorState(message: 'Failed to load balance: ${e.toString()} #3'));
      }
    });
  }
}