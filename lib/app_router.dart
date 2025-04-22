import 'package:go_router/go_router.dart';
import 'package:protocol_app/pages/event_page/event_detail_page.dart';
import 'package:protocol_app/pages/login_page.dart';
import 'package:protocol_app/pages/main_page.dart';
import 'package:protocol_app/pages/participant_page.dart';
import 'pages/event_page/event_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      ShellRoute(
        builder: (context, state, child) => MainPage(child: child),
        routes: [
          GoRoute(
            path: '/event',
            name: 'event',
            builder: (context, state) => const EventPage(),
            routes: [
              GoRoute(
                path: ':eventId',
                name: 'eventDetail',
                builder: (context, state) => EventDetailPage(eventId: state.pathParameters['eventId']!),
              ),
            ]
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