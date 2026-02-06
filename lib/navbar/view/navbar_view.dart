import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pub_chem/app/config/service_locator.dart';
import 'package:pub_chem/home/view/home_screen.dart';
import 'package:pub_chem/l10n/l10n.dart';
import 'package:pub_chem/more/view/more_screen.dart';
import 'package:pub_chem/navbar/cubit/navbar_index_cubit.dart';

class NavbarView extends StatefulWidget {
  const NavbarView({super.key});

  @override
  State<NavbarView> createState() => _NavbarViewState();
}

class _NavbarViewState extends State<NavbarView> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final pageList = [
      const HomeScreen(),
      const MoreScreen(),
    ];
    return Scaffold(
      body: BlocBuilder<NavbarIndexCubit, int>(
        bloc: sl<NavbarIndexCubit>(),
        builder: (context, state) {
          return pageList[state];
        },
      ),
      bottomNavigationBar: BlocBuilder<NavbarIndexCubit, int>(
        bloc: sl<NavbarIndexCubit>(),
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: state,
            type: .fixed,
            onTap: (index) {
              sl<NavbarIndexCubit>().changeIndex(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: l10n.home,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.more_horiz_outlined),
                label: l10n.moreScreenTitle,
              ),
            ],
          );
        },
      ),
    );
  }
}
