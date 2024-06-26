import 'package:Sebawi/data/models/validate_form.dart';
import 'package:Sebawi/data/services/api_path.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../presentation/Events/login_user_event.dart';
import '../../presentation/States/login_user_state.dart';

class LoginUserBloc extends Bloc<LoginUserEvent, LoginUserState> {
  LoginUserBloc() : super(const LoginUserState()) {
    on<LoginUserInitialEvent>(_initState);
    on<LoginSubmitted>(_onLoginSubmitted);
    on<NavigateToSignupEvent>(_onNavigateToSignup);
    on<UsernameChangedEvent>(_onUsernameChanged);
    on<PasswordChangedEvent>(_onPasswordChanged);
  }

  final _formKey = GlobalKey<FormState>();

  Future<void> _initState(LoginUserInitialEvent event,
      Emitter<LoginUserState> emit) async {
    emit(state.copyWith(formKey: _formKey));
  }

  Future<void> _onUsernameChanged(UsernameChangedEvent event,
      Emitter<LoginUserState> emit) async {
    emit(state.copyWith(username: ValidateForm(value: event.username.value)));
  }

  Future<void> _onPasswordChanged(PasswordChangedEvent event,
      Emitter<LoginUserState> emit) async {
    emit(state.copyWith(password: ValidateForm(value: event.password.value)));
  }

  Future<void> _onLoginSubmitted(LoginSubmitted event,
      Emitter<LoginUserState> emit) async {
    String? usernameError;
    String? passwordError;

    if (state.username.value.isEmpty) {
      usernameError = 'Username is required';
    }
    if (state.password.value.isEmpty) {
      passwordError = 'Password is required';
    }
    if(usernameError == null && passwordError == null) {
      final response = await RemoteService().logIn(
        state.username.value,
         state.password.value,
      );
      if(response == "user") {
        emit(const LoginUserNavigationSuccess('/user_home'));
        return;
      }
      else if(response == "agency") {
        emit(const LoginUserNavigationSuccess('/agency_home'));
        return;
      } else if (response == "admin"){
        emit(const LoginUserNavigationSuccess('/admin_home'));
        return;
      }
      else {
        emit(state.copyWith(apiError: response));
        return;
      }
      return;
    } else{
      emit(state.copyWith(
        username: ValidateForm(value: state.username.value, error: usernameError),
        password: ValidateForm(value: state.password.value, error: passwordError),
      ));

    }
  }

  void _onNavigateToSignup(NavigateToSignupEvent event, Emitter<LoginUserState> emit) {
    emit(const LoginUserNavigationSuccess('/signup'));
  }
}
