import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ui_hlb_ekyc_mobile/core/utils/form_validators.dart';
import 'package:meta/meta.dart';

import '../../models/models.dart';
import '../../../domain/repositories/apply_product_repository.dart';

part 'new_form_event.dart';
part 'new_form_state.dart';

class NewFormBloc extends Bloc<NewFormEvent, NewFormState> {
  
  NewFormBloc({
    @required this.applyProductRepository
  });

  final ApplyProductRepository applyProductRepository;

  @override
  NewFormState get initialState => NewFormState.initial();

  @override
  Stream<NewFormState> mapEventToState(NewFormEvent event) async* {

    if(event is SavePersonalInformation) {
      yield* _mapPersonalInfoToState(event);
    }

    if(event is SaveAddressInformation) {
      // todo:- handle for address info state
    }

    if(event is ResetBasicInformation) {
      yield  NewFormState.initial();
    }
  }

  Stream<NewFormState> _mapPersonalInfoToState(SavePersonalInformation event) async* {
    yield NewFormSaving(message: 'Submitting your application...');
    try {
      await Future.delayed(Duration(seconds: 3));
      // Send data to domain layer (repository)
      await applyProductRepository.submitForm(personalInformation: event.personalInformation);
      yield state.copyWith(personal: event.personalInformation);
      yield NewFormSubmitted(message: 'Application submitted successfully!');
      
    } catch(err) {
      yield NewFormSubmitFailed(message: 'Unable to save your ');
    }
  }

  String isValidEmail(String value) {
    if(isBlank(value: value)) {
      return 'Email can not be blank';
    }
    if(!isEmail(value: value)) {
      return 'Email is not valid';
    }
    return null;
  }

  String isValidMobileNum(String value) {
    if(isBlank(value: value)) {
      return 'Mobile number can not be blank';
    }
    if(!isMobileNumber(value: value)) {
      return 'Mobile number is not valid';
    }
    return null;
  }

  String isValidMyKadNumber(String value) {
    return isBlank(value: value) ? 'MyKad number can not be blank' : null;
  }

  String isValidFullName(String value) {
    // if(isBlank(value: value)) {
    //   return 'Full name can not be blank';
    // }
    // if(!isOnlyAlphabet(value: value)) {
    //   return 'Please enter a valid name';
    // }
    return null;
  }

  @override
  void onTransition(Transition<NewFormEvent, NewFormState> transition) {
    print('STATE Transition :: $transition');
    super.onTransition(transition);
  }
}
