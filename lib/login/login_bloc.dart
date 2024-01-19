import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'validators.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState.empty()) {
    on<EmailChanged>((event, emit) => _mapEmailChangedToState(event.email));
    on<PasswordChanged>(
        (event, emit) => _mapPasswordChangedToState(event.password));
    on<LoginWithPassword>((event, emit) => _mapLoginWithPasswordToState(
        email: event.email, password: event.password));
  }

  Stream<LoginState> _mapEmailChangedToState(String email) async* {
    debugPrint(email);
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<LoginState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<LoginState> _mapLoginWithPasswordToState({
    String email = "",
    String password = "",
  }) async* {
    try {
      if (email == "test@example.com" && password == "1234") {
        yield LoginState.success();
      }
    } catch (_) {
      yield LoginState.failure();
    }
  }
}
