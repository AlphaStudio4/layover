import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layover/blocs/auth/auth_bloc.dart';
import 'package:layover/blocs/onboarding/onboarding_bloc.dart';
import 'package:layover/blocs/profile/profile_bloc.dart';
import 'package:layover/blocs/swipe/swipe_bloc.dart';
import 'package:layover/config/app_router.dart';
import 'package:layover/cubits/login/login_cubit.dart';
import 'package:layover/cubits/signup/signup_cubit.dart';
import 'package:layover/respositories/auth_repository.dart';
import 'package:layover/config/theme.dart';
import 'package:layover/respositories/database/database_repository.dart';
import 'package:layover/respositories/storage/storage_repository.dart';
import 'package:layover/screens/splash/splash_screen.dart';

import 'blocs/chatlist/chat_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'layoverdating-app',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthRepository()),
        RepositoryProvider(create: (context) => StorageRepository()),
        RepositoryProvider(create: (context) => DatabaseRepository()),
      ],
      child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthBloc(
                authRepository: context.read<AuthRepository>(),
              ),
            ),
            BlocProvider<SignupCubit>(
                create: (context) => SignupCubit(
                    authRepository: context.read<AuthRepository>())),
            BlocProvider<LoginCubit>(
                create: (context) =>
                    LoginCubit(authRepository: context.read<AuthRepository>())),
            BlocProvider<OnboardingBloc>(
                create: (context) => OnboardingBloc(
                    databaseRepository: context.read<DatabaseRepository>(),
                    storageRepository: context.read<StorageRepository>())),
            BlocProvider(
                create: (context) => SwipeBloc(
                      authBloc: context.read<AuthBloc>(),
                      databaseRepository: context.read<DatabaseRepository>(),
                    )
                //BlocProvider.of<AuthBloc>(context).state.user!.uid),
                ),
            BlocProvider(
                create: (context) => ChatBloc(
                      authBloc: context.read<AuthBloc>(),
                      databaseRepository: context.read<DatabaseRepository>(),
                    )
                //BlocProvider.of<AuthBloc>(context).state.user!.uid),
                ),
            BlocProvider(
                create: (context) => ProfileBloc(
                      authBloc: context.read<AuthBloc>(),
                      databaseRepository: context.read<DatabaseRepository>(),
                    )..add(LoadProfile(
                        userId: (context.read<AuthBloc>().state.user!.uid))))
          ],
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Layover Dating App',
            theme: theme(),
            onGenerateRoute: AppRouter.onGenerateRoute,
            initialRoute: SplashScreen.routeName,
          )),
    );
  }
}
