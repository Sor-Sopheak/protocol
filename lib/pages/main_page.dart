import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:protocol_app/constants/app_constants.dart';
import 'package:protocol_app/pages/navbar.dart';

class MainPage extends StatelessWidget {
  final Widget child;
  const MainPage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = navItems.indexWhere((item) => item.route == location);

    return Scaffold(
      appBar: Navbar(
        currentIndex: currentIndex < 0 ? 0 : currentIndex,
        onSelectedRoute: (index) => context.go(navItems[index].route),
      ),
      body: child,
    );
  }
}
