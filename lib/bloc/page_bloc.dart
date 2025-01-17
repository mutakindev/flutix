import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bwa_flutix/models/models.dart';
import 'package:equatable/equatable.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  @override
  Stream<PageState> mapEventToState(
    PageEvent event,
  ) async* {
    if(event is GoToSplashPage){
      yield OnSplashPage();
    }else if(event is GoToLoginPage){
      yield OnLoginPage();
    }else if(event is GoToMainPage){
      yield OnMainPage();
    }
    else if(event is GoToSignUpPage){
      yield OnSignUpPage(event.registrationData);
    }
    else if(event is GoToPreferencePage){
      yield OnPreferencePage(event.registrationData);
    }
    else if(event is GoToAccountConfirmationPage){
      yield OnAccountConfirmationPage(event.registrationData);
    }
  }

  @override
  PageState get initialState => OnInitialPage();
}
