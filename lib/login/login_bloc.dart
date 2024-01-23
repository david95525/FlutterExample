import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'validators.dart';
import '../repository/user_repository.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(LoginState.empty()) {
    on<EmailChanged>(_mapEmailChangedToState);
    on<PasswordChanged>(_mapPasswordChangedToState);
    on<LoginWithPassword>(_mapLoginWithPasswordToState);
  }
  final UserRepository _userRepository;
  Future<void> _mapEmailChangedToState(
      EmailChanged event, Emitter<LoginState> emit) async {
    emit(state.update(isEmailValid: Validators.isValidEmail(event.email)));
  }

  Future<void> _mapPasswordChangedToState(
      PasswordChanged event, Emitter<LoginState> emit) async {
    emit(state.update(
        isPasswordValid: Validators.isValidPassword(event.password)));
  }

  Future<void> _mapLoginWithPasswordToState(
      LoginWithPassword event, Emitter<LoginState> emit) async {
    try {
      final user = await _tryGetUser();
      if (user != null) {
        if (event.email == user.email && event.password == user.password) {
          emit(LoginState.success());
          debugPrint(user.toString());
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
