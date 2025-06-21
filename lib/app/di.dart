import 'package:behavioral_pattern/data/repositories/auth_repository_impl.dart';
import 'package:behavioral_pattern/data/repositories/user_profile_repository_impl.dart';
import 'package:behavioral_pattern/domain/repositories/user_profile_repository.dart';
import 'package:behavioral_pattern/domain/usecases/get_current_user_usecase.dart';
import 'package:behavioral_pattern/domain/usecases/get_user_profile_usecase.dart';
import 'package:behavioral_pattern/domain/usecases/register_usecase.dart';
import 'package:behavioral_pattern/domain/usecases/sign_in_usecase.dart';
import 'package:behavioral_pattern/presentation/auth/auth_bloc.dart';
import 'package:behavioral_pattern/presentation/auth/auth_bloc_proxy.dart';
import 'package:behavioral_pattern/presentation/profile/profile_bloc.dart';
import 'package:behavioral_pattern/presentation/profile/profile_bloc_proxy.dart';
import 'package:behavioral_pattern/app/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppDI {
  // Firebase core instances
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // Repositories
  static final UserProfileRepository userProfileRepository =
      UserProfileRepositoryImpl(firestore);

  static final AuthRepositoryImpl authRepository =
      AuthRepositoryImpl(firebaseAuth);

  // Use cases
  static final GetUserProfileUseCase getUserProfileUseCase =
      GetUserProfileUseCase(userProfileRepository);

  static final UpdateUserProfileUseCase updateUserProfileUseCase =
      UpdateUserProfileUseCase(userProfileRepository);

  static final SignInUseCase signInUseCase = SignInUseCase(authRepository);
  static final RegisterUseCase registerUseCase = RegisterUseCase(authRepository);

  static final GetCurrentUserUseCase getCurrentUserUseCase =
      GetCurrentUserUseCase(authRepository);

  // Logger
  static final ConsoleLogger logger = ConsoleLogger();

  // BLoCs
  static final AuthBloc authBloc = AuthBloc(signInUseCase, registerUseCase);

  static final ProfileBloc profileBloc = ProfileBloc(
    getUserProfileUseCase: getUserProfileUseCase,
    updateUserProfileUseCase: updateUserProfileUseCase,
    userId: firebaseAuth.currentUser?.uid ?? 'default_user_id',
  );

  // Proxy BLoCs
  static final AuthBlocProxy authBlocProxy =
      AuthBlocProxy(inner: authBloc, logger: logger);

  static final ProfileBlocProxy profileBlocProxy =
      ProfileBlocProxy(profileBloc, logger);
}
