import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pub_chem/app/router/app_routes.dart';
import 'package:pub_chem/splash/view/bloc/splash_bloc.dart';
import 'package:pub_chem/splash/view/bloc/splash_event.dart';
import 'package:pub_chem/splash/view/bloc/splash_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SplashBloc>().add(SplashStarted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashFinished) {
            context.go(AppRoutes.navbar);
          }
        },
        child: _body(),
      ),
    );
  }

  Widget _body() {
    return const Center(
      child: Column(
        mainAxisSize: .min,
        spacing: 24,
        children: [
          Icon(
            Icons.science_outlined,
            size: 120,
          ),
          Text(
            'PubChem',
            style: TextStyle(
              fontWeight: .bold,
              fontSize: 36,
            ),
          ),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
