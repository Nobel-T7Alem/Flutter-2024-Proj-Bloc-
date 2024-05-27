import 'package:bloc/bloc.dart';
import 'agency_signup_event.dart';
import 'agency_signup_state.dart';

class AgencySignupBloc extends Bloc<AgencySignupEvent, AgencySignupState> {
  AgencySignupBloc() : super(AgencySignupInitial());

  @override
  Stream<AgencySignupState> mapEventToState(AgencySignupEvent event) async* {
    if (event is SubmitAgencySignup) {
      yield AgencySignupLoading();
      try {
        // Simulate a signup process
        await Future.delayed(const Duration(seconds: 2));
        yield const AgencySignupSuccess('Agency Signup Successful');
      } catch (e) {
        yield const AgencySignupFailure('Agency Signup Failed');
      }
    }
  }
}
