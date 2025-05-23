import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_example/my_router.dart';
import 'package:flutter_example/pages/firebase/bloc/app_bloc.dart';
import 'package:flutter_example/pages/firebase/firebase_login/cubit/login_cubit.dart';
import 'package:flutter_example/pages/firebase/firebase_signup/sign_up_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

class FirebaseLoginForm extends StatelessWidget {
  const FirebaseLoginForm({super.key});
  @override
  Widget build(BuildContext context) {
    String? userEmail = context.select((AppBloc bloc) => bloc.state.user.email);
    return BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
      if (state.status.isFailure) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'Authentication Failure'),
            ),
          );
      }
      if (state.status.isSuccess) {
        String email = userEmail ?? "";
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Text('$email login success'),
            backgroundColor: Colors.green,
          ));
        Navigator.pushNamed(context, RouteName.member);
      }
    }, builder: (context, state) {
      return Align(
        alignment: const Alignment(0, -1 / 3),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/back.jpg',
                height: 120,
              ),
              const SizedBox(height: 16),
              _EmailInput(),
              const SizedBox(height: 8),
              _PasswordInput(),
              const SizedBox(height: 8),
              _LoginButton(),
              const SizedBox(height: 8),
              _FirebaseLoginButton(),
              const SizedBox(height: 8),
              _GoogleLoginButton(),
              const SizedBox(height: 4),
              _SignUpButton(),
            ],
          ),
        ),
      );
    });
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormField(
          key: const Key('loginForm_emailInput_textField'),
          initialValue: context.read<LoginCubit>().state.email.value,
          onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'email',
            helperText: '',
            errorText:
                state.email.displayError != null ? 'invalid email' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormField(
          key: const Key('loginForm_passwordInput_textField'),
          initialValue: context.read<LoginCubit>().state.password.value,
          onChanged: (password) =>
              context.read<LoginCubit>().passwordChanged(password),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'password',
            helperText: '',
            errorText:
                state.password.displayError != null ? 'invalid password' : null,
          ),
        );
      },
    );
  }
}

class _FirebaseLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('loginForm_continue_raisedButton'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: const Color(0xFFFFD600),
                ),
                onPressed: state.isValid
                    ? () => context
                        .read<LoginCubit>()
                        .logInWithFirebaseCredentials()
                    : null,
                child: const Text('FirebaseLogin'),
              );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('loginForm_continue_raisedButton'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: const Color(0xFFFFD600),
                ),
                onPressed: state.isValid
                    ? () => context.read<LoginCubit>().logInWithPassword()
                    : null,
                child: const Text('Login'),
              );
      },
    );
  }
}

class _GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton.icon(
      key: const Key('loginForm_googleLogin_raisedButton'),
      label: const Text(
        'SIGN IN WITH GOOGLE',
        style: TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: theme.colorScheme.secondary,
      ),
      icon: const Icon(FontAwesomeIcons.google, color: Colors.white),
      onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      key: const Key('loginForm_createAccount_flatButton'),
      onPressed: () => Navigator.of(context).push<void>(SignUpPage.route()),
      child: Text(
        'CREATE ACCOUNT',
        style: TextStyle(color: theme.primaryColor),
      ),
    );
  }
}
