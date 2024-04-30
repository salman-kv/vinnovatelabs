import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinnovatelabzsalmankv/application/login_bloc/login_bloc.dart';
import 'package:vinnovatelabzsalmankv/application/login_bloc/login_event.dart';
import 'package:vinnovatelabzsalmankv/application/login_bloc/login_state.dart';
import 'package:vinnovatelabzsalmankv/presentation/alert/snack_bars.dart';
import 'package:vinnovatelabzsalmankv/presentation/screens/login/otp_screen.dart';
import 'package:vinnovatelabzsalmankv/presentation/widget/common_widget/common_widget.dart';

class LoginWidget {
  whiteContainer({required BuildContext context}) {
    TextEditingController phoneNumberController = TextEditingController();
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          roundImage(context: context),
          const Text('Login',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
          CommonWidget().textFormFieldWidget(
              context: context,
              controller: phoneNumberController,
              secure: false,
              labelText: 'Phone Number'),
          BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is OtpVerificationCodeSentState) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return OtpScreen(verificationId: state.verificationId);
                  },
                ));
              }
            },
            builder: (context, state) {
              if (state is OtpSendLoadingState) {
                return const CupertinoActivityIndicator(
                  radius: 20,
                );
              }
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 61, 61)),
                onPressed: () async {
                  if (phoneNumberController.text.isNotEmpty &&
                      phoneNumberController.text.length == 10) {
                    BlocProvider.of<LoginBloc>(context).phoneNumber =
                        phoneNumberController.text;
                    BlocProvider.of<LoginBloc>(context).add(
                      SignInOtpSendEvent(
                        phoneNumber: '+91${phoneNumberController.text}',
                      ),
                    );
                  } else {
                    SnackBars().errorSnackBar(
                      'Enter 10 digit valid phone number',
                      context,
                    );
                  }
                },
                child: const Text(
                  'Log In',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              );
            },
          ),
          const SizedBox(height: 10,)
        ],
      ),
    );
  }

  roundImage({required BuildContext context}) {
    return Container(
      margin: const EdgeInsets.all(25),
      height: MediaQuery.of(context).size.width * 0.28,
      width: MediaQuery.of(context).size.width * 0.28,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1000),
        border: Border.all(
          color: const Color.fromARGB(255, 244, 244, 244),
          width: 2,
        ),
        color: const Color.fromARGB(255, 238, 238, 238),
        image: const DecorationImage(
          image: AssetImage('assets/images/stand.png'),
        ),
      ),
    );
  }
}
