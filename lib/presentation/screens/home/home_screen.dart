import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:vinnovatelabzsalmankv/application/login_bloc/login_bloc.dart';
import 'package:vinnovatelabzsalmankv/application/login_bloc/login_state.dart';
import 'package:vinnovatelabzsalmankv/presentation/alert/alert.dart';
import 'package:vinnovatelabzsalmankv/presentation/screens/home/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 239, 239),
      appBar: HomeWidget().homeAppBar(),
      body: ListView(
        children: [
          HomeWidget().searchWidget(context: context),
          BlocConsumer<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state is LoginLoadingState) {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              }
              return Column(
                children: BlocProvider.of<LoginBloc>(context).searchList.isEmpty
                    ? [Lottie.asset('assets/images/no data found.json')]
                    : List.generate(
                        BlocProvider.of<LoginBloc>(context).searchList.length,
                        (index) {
                        return HomeWidget().itemShowingContainer(
                            context: context,
                            productModel: BlocProvider.of<LoginBloc>(context)
                                .searchList[index]);
                      }),
              );
            },
            listener: (context, state) {},
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 61, 61)),
            onPressed: () async {
              Alert().alertFunction(context: context);
            },
            child: const Text(
              'Log Out',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          )
        ],
      ),
    ));
  }
}
