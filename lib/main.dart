import 'package:behavioral_pattern/app/di.dart';
import 'package:behavioral_pattern/app/navigation_router.dart';
import 'package:behavioral_pattern/data/models/movie_model.dart';
import 'package:behavioral_pattern/domain/usecases/get_user_profile_usecase.dart';
import 'package:behavioral_pattern/presentation/auth/auth_bloc_proxy.dart';
import 'package:behavioral_pattern/presentation/auth/auth_state_listener.dart';
import 'package:behavioral_pattern/presentation/profile/profile_bloc.dart';
import 'package:behavioral_pattern/presentation/profile/profile_bloc_proxy.dart';
import 'package:behavioral_pattern/theme/theme_notifier.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(MovieModelAdapter());

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ru')],
      path: 'assets/langs',
      fallbackLocale: const Locale('en'),
      child: MultiProvider(
        providers: [
          Provider.value(value: AppDI.authBloc),
          Provider<AuthBlocProxy>(
            create: (context) => AuthBlocProxy(
              inner: context.read(),
              logger: AppDI.logger,
            ),
            dispose: (_, proxy) => proxy.dispose(),
          ),
          Provider.value(value: AppDI.getUserProfileUseCase),
          Provider.value(value: AppDI.updateUserProfileUseCase),
          StreamProvider<User?>.value(
            value: FirebaseAuth.instance.authStateChanges().map((user) {
              debugPrint('🔁 [main] FirebaseAuth state changed: $user');
              return user;
            }),
            initialData: null,
          ),
          ProxyProvider<User?, ProfileBloc?>(
            update: (context, user, previous) {
              previous?.dispose();
              if (user == null) return null;

              final profileBloc = ProfileBloc(
                getUserProfileUseCase: context.read<GetUserProfileUseCase>(),
                updateUserProfileUseCase:
                    context.read<UpdateUserProfileUseCase>(),
                userId: user.uid,
              );

              return ProfileBlocProxy(profileBloc, AppDI.logger);
            },
            dispose: (_, bloc) => bloc?.dispose(),
          ),
          ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AuthBlocProxy _authBlocProxy;

  @override
  void initState() {
    super.initState();
    _authBlocProxy = context.read<AuthBlocProxy>();
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = context.watch<ThemeNotifier>();
    final router = NavigationRouter(authBlocProxy: _authBlocProxy);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: themeNotifier.themeData,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      onGenerateRoute: router.generateRoute,
      home: AuthStateListener(authBloc: _authBlocProxy),
    );
  }
}
