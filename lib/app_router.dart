import 'package:go_router/go_router.dart';
import 'package:protocol_app/pages/detail_page.dart';
import 'package:protocol_app/pages/login_page.dart';
import 'package:protocol_app/pages/main_page.dart';
import 'pages/home_page.dart';
import 'pages/about_page.dart';
import 'pages/contact_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) => MainPage(child: child),
        routes: [
          GoRoute(
            path: '/',
            name: 'login',
            builder: (context, state) => const LoginPage(),
          ),
          GoRoute(
            path: '/home',
            name: 'home',
            builder: (context, state) => const HomePage(),
            routes: [
              GoRoute(
                path: 'detail/:id',
                name: 'detail',
                builder: (context, state) {
                  final id = state.pathParameters['id']!;
                  return DetailPage(id: id);
                },
              ),
            ],
          ),
          GoRoute(
            path: '/about',
            name: 'about',
            builder: (context, state) => const AboutPage(),
          ),
          GoRoute(
            path: '/contact',
            name: 'contact',
            builder: (context, state) => const ContactPage(),
          ),
        ],
      ),
    ],
  );
}