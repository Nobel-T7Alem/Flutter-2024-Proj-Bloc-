import 'package:bloc/bloc.dart';
import 'user_home_event.dart';
import 'user_home_state.dart';

class UserHomeBloc extends Bloc<UserHomeEvent, UserHomeState> {
  UserHomeBloc() : super(UserHomeInitial());

  @override
  Stream<UserHomeState> mapEventToState(UserHomeEvent event) async* {
    if (event is LoadUserHomePage) {
      yield UserHomeLoading();
      try {
        // Simulate fetching data
        await Future.delayed(Duration(seconds: 2));
        yield UserHomeLoaded('User Home Page Data Loaded');
      } catch (e) {
        yield UserHomeError('Failed to load user home page data');
      }
    }
  }
}