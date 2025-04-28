import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:protocol_app/app_router.dart';
import 'package:protocol_app/providers/auth_provider.dart';
import 'package:protocol_app/providers/event_provider.dart';
import 'package:protocol_app/providers/participant_provider.dart';
import 'package:protocol_app/providers/user_provider.dart';
import 'package:protocol_app/services/auth_service.dart';
import 'package:protocol_app/services/event_service.dart';
import 'package:protocol_app/services/participant_service.dart';
import 'package:protocol_app/services/user_service.dart';
import 'package:provider/provider.dart';

void main() {
  usePathUrlStrategy();

  final client = http.Client();
  final participantService = ParticipantService(client: client);
  final eventService = EventService(client: client);
  final userService = UserService(client: client);
  final authService = AuthService(client: client);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(authService: authService),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(userService: userService),
        ),
        ChangeNotifierProvider(
          create: (_) => EventProvider(eventService: eventService),
        ),
        ChangeNotifierProvider(
          create: (_) => ParticipantProvider(participantService: participantService),
        ),
      ],
      child: MyApp(),
    ),
    );
}

class MyApp extends StatelessWidget {
  final _router = AppRouter.router;

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      title: 'Protocol Functionality Web',
      builder: (context, child) {
        return Overlay(
          initialEntries: [
            OverlayEntry(builder: (context) => child ?? const SizedBox()),
          ],
        );
      },
    );
  }
}
