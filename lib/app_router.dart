import 'package:go_router/go_router.dart';
import 'package:protocol_app/pages/detail_page.dart';
import 'package:protocol_app/pages/login_page.dart';
import 'package:protocol_app/pages/main_page.dart';
import 'package:protocol_app/pages/participant_page.dart';
import 'pages/event_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) => MainPage(child: child),
        routes: [
          GoRoute(
            path: '/',
            name: 'event',
            builder: (context, state) => const EventPage(),
          ),
          GoRoute(
            path: '/login',
            name: 'login',
            builder: (context, state) => const LoginPage(),
            // routes: [
            //   GoRoute(
            //     path: 'detail/:id',
            //     name: 'detail',
            //     builder: (context, state) {
            //       final id = state.pathParameters['id']!;
            //       return DetailPage(id: id);
            //     },
            //   ),
            // ],
          ),
          GoRoute(
            path: '/participants',
            name: 'participants',
            builder: (context, state) => const ParticipantPage(),
          ),
        ],
      ),
    ],
  );
}