import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:vinnovatelabzsalmankv/application/login_bloc/login_bloc.dart';
import 'package:vinnovatelabzsalmankv/application/login_bloc/login_event.dart';
import 'package:vinnovatelabzsalmankv/application/login_bloc/login_state.dart';
import 'package:vinnovatelabzsalmankv/presentation/alert/snack_bars.dart';
import 'package:vinnovatelabzsalmankv/presentation/screens/home/home_screen.dart';
import 'package:vinnovatelabzsalmankv/presentation/screens/login/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<LoginBloc>().add(SplashScreenLoginEvent());
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is SplashScreenUserNotLoginedState) {
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
            builder: (context) {
              return const SignInScreen();
            },
          ), (route) => false);
        } else if (state is SplashScreenUserAlredyLoginedState) {
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
            builder: (context) {
              return const HomeScreen();
            },
          ), (route) => false);
        } else if (state is ApiErrorState) {
          SnackBars().errorSnackBar('Api error No data found', context);
          context.read<LoginBloc>().add(SplashScreenLoginEvent());
        }
      },
      child: SafeArea(
          child: Scaffold(
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Center(
              child:
                  Lottie.asset('assets/images/Animation - 1714456993445.json')),
        ),
      )),
    );
  }
}
