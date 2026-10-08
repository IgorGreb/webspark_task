import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark_task/components/home_page/bloc/home_bloc.dart';
import 'package:webspark_task/components/home_page/view/home_view.dart';
import 'package:webspark_task/shared/di/injection.dart';

class HomeBlocProvider extends StatelessWidget {
  const HomeBlocProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (_) => getIt<HomeBloc>(),
      child: const HomeView(),
    );
  }
}
