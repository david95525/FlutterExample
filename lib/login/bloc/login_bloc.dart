import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_example/repository/user_repository.dart';
import 'validators.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(LoginState.empty()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<LoginWithPassword>(_onLoginWithPassword);
  }
  final UserRepository _userRepository;
  Future<void> _onEmailChanged(
      EmailChanged event, Emitter<LoginState> emit) async {
    emit(state.update(isEmailValid: Validators.isValidEmail(event.email)));
  }

  Future<void> _onPasswordChanged(
      PasswordChanged event, Emitter<LoginState> emit) async {
    emit(state.update(
        isPasswordValid: Validators.isValidPassword(event.password)));
  }

  Future<void> _onLoginWithPassword(
      LoginWithPassword event, Emitter<LoginState> emit) async {
    try {
      final user = await _tryGetUser();
      if (user != null) {
        if (event.isSuceess) {
          emit(LoginState.success());
        } else {
          emit(LoginState.failure());
        }
      } else {
        emit(LoginState.failure());
      }
    } catch (err) {
      emit(LoginState.failure());
    }
  }

  Future<User?> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser();
      return user;
    } catch (_) {
      return null;
    }
  }
}
