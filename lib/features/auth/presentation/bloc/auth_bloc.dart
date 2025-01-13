import 'package:etranzazct_test/app/cache/cache_keys.dart';
import 'package:etranzazct_test/app/cache/share_preference.dart';
import 'package:etranzazct_test/features/auth/data/user_model.dart';
import 'package:etranzazct_test/features/auth/presentation/bloc/auth_events.dart';
import 'package:etranzazct_test/features/auth/presentation/bloc/auth_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvents, AuthStates> {
  final _share = AppSharedPreferences.instance;

  AuthBloc() : super(InitialState()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthProcessing());
      await Future.delayed(Duration(seconds: 2));
      final data = await _share.getShareString(CacheKeys.authKey);
      if (data != null) {
        final userData = UserModel.fromJson(data);
        if (event.password == userData.password &&
            event.email == userData.email) {
          await _share.saveBoolShare(data: true, key: CacheKeys.session);
          emit(AuthenticatedState(userData));
        } else {
          emit(UnAuthenticatedState('Wrong credentials'));
        }
      } else {
        emit(UnAuthenticatedState('Wrong credentials'));
      }
    });

    on<SignupEvent>((event, emit) async => _onSignupEvent(event, emit));

    on<LogoutEvent>((event, emit) {
      _share.deleteAllShareData();
      emit(UnAuthenticatedState());
    });

    on<CheckAuthStatusEvent>(
      (event, emit) async {
        final data = await _share.getShareString(CacheKeys.authKey);
        if (data != null) {
          final session = await _share.getShareBool(CacheKeys.session);
          if (session) {
            final userData = UserModel.fromJson(data);
            emit(AuthenticatedState(userData));
          } else {
            emit(UnAuthenticatedState());
          }
        } else {
          emit(UnAuthenticatedState());
        }
        print(state);
      },
    );
  }

  Future<void> _onSignupEvent(
      SignupEvent event, Emitter<AuthStates> emit) async {
    final userData = event.userModel;
    try {
      await _share.saveStringShare(
        key: CacheKeys.authKey,
        data: userData.toJson(),
      );
      await _share.saveBoolShare(data: true, key: CacheKeys.session);
      emit(AuthenticatedState(userData));
    } on Exception catch (e) {
      emit(UnAuthenticatedState(e.toString()));
    }
  }
}
