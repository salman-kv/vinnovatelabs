import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:vinnovatelabzsalmankv/application/login_bloc/login_event.dart';
import 'package:vinnovatelabzsalmankv/application/login_bloc/login_state.dart';
import 'package:vinnovatelabzsalmankv/domain/api/fake_store_api.dart';
import 'package:vinnovatelabzsalmankv/domain/product_model/product_model.dart';
import 'package:vinnovatelabzsalmankv/domain/shared_prefrence_fuction/shared_prefrence.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  String phoneNumber = '';
  List<ProductModel> mainList = [];
  List<ProductModel> searchList = [];

  final otpController = TextEditingController();
  LoginBloc() : super(InitialLoginState()) {
    on<SplashScreenLoginEvent>((event, emit) async {
      // future delayed only given for showing the splashscreen atleast 3 seconds
      await Future.delayed(const Duration(seconds: 3));
      // checking the user is alredy logined or not and re-direct to diffrent pages
      String login = await SharedPrefrenceFunction().userLoginCheck();
      if (login != '') {
        var result = await FakeStoreAPI().getProductDeatails();
        if (result == null) {
          emit(ApiErrorState());
        } else {
          mainList = result;
          searchList = [...mainList];
          emit(SplashScreenUserAlredyLoginedState());
        }
      } else {
        emit(SplashScreenUserNotLoginedState());
      }
    });

    // otp verification
    on<SignInOtpSendEvent>((event, emit) async {
      phoneNumber = event.phoneNumber;
      emit(OtpSendLoadingState());
      await FirebaseAuth.instance.verifyPhoneNumber(
        verificationCompleted: (phoneAuthCredential) {
          log('verification compleated');
        },
        verificationFailed: (error) {
          log('error $error');
        },
        codeSent: (verificationId, forceResendingToken) {
          add(SignInOtpSendedEvent(verificationId: verificationId));
        },
        codeAutoRetrievalTimeout: (verificationId) {
          log('time out -----------');
        },
        phoneNumber: event.phoneNumber,
      );
    });
    on<SignInOtpSendedEvent>((event, emit) {
      emit(OtpVerificationCodeSentState(verificationId: event.verificationId));
    });
    on<OtpVerificationEvent>((event, emit) async {
      try {
        PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
            verificationId: event.verificationId, smsCode: event.otp);
        await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
        await SharedPrefrenceFunction().userLogin(phoneNumber);
        emit(OtpverificationSuccessState());
      } catch (e) {
        emit(OtpverificationFailedState());
      }
    });
    // logout logic
    on<LogoutEvent>((event, emit) async {
      await SharedPrefrenceFunction().userLogOut();
      phoneNumber = '';
      searchList = [...mainList];
    });

    // searching algorithom without calling api
    // only search when enter minimum 3 character
    on<SearchingEvent>(
      (event, emit) {
        emit(LoginLoadingState());
        searchList.clear();
        for (ProductModel i in mainList) {
          if (i.title.toLowerCase().contains(event.text.toLowerCase())) {
            searchList.add(i);
          }
        }
        emit(SearchSuccessState());
      },
    );

    on<CancelSearchEvent>((event, emit) {
      searchList = [...mainList];
      emit(SearchSuccessState());
    });
  }
}
