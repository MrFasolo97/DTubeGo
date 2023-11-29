import 'package:bloc/bloc.dart';
import 'package:ovh.fso.dtubego/bloc/accountHistory/accountHistory_event.dart';
import 'package:ovh.fso.dtubego/bloc/accountHistory/accountHistory_state.dart';
import 'package:ovh.fso.dtubego/bloc/accountHistory/accountHistory_response_model.dart';
import 'package:ovh.fso.dtubego/bloc/accountHistory/accountHistory_repository.dart';
import 'package:ovh.fso.dtubego/utils/GlobalStorage/SecureStorage.dart' as sec;

class AccountHistoryBloc
    extends Bloc<AccountHistoryEvent, AccountHistoryState> {
  AccountHistoryRepository repository;
  bool isFetching = false;

  AccountHistoryBloc({required this.repository})
      : super(AccountHistoryInitialState()) {
    on<FetchAccountHistorysEvent>((event, emit) async {
      String? _applicationUser = await sec.getUsername();
      String _avalonApiNode = await sec.getNode();
      emit(AccountHistoryLoadingState());
      try {
        List<AvalonAccountHistoryItem> accountHistory =
            await repository.getAccountHistory(
                _avalonApiNode,
                event.accountHistoryTypes,
                event.username != null ? event.username! : _applicationUser,
                event.fromBloc);

        emit(AccountHistoryLoadedState(
            historyItems: accountHistory,
            username:
                event.username != null ? event.username! : _applicationUser));
      } catch (e) {
        emit(AccountHistoryErrorState(message: e.toString()));
      }
    });
  }
}
