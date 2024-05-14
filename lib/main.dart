import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localpharm/backend/database_provider.dart';
import 'package:localpharm/core/router/app_router.dart';
import 'package:localpharm/logic/blocs/medicament_bloc.dart';
import 'package:localpharm/logic/search_bloc.dart/bloc/search_bloc.dart';

import 'core/theme/app_theme.dart';


void main() {
  final DbProvider dbProvider = DbProvider();
  final AppRouter appRouter = AppRouter();
  runApp(
    MainApp(
      dbProvider: dbProvider,
      appRouter: appRouter,
    ),
  );

}

class MainApp extends StatelessWidget {
  final DbProvider dbProvider;
  final AppRouter appRouter;
  const MainApp({super.key, required this.dbProvider, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [ 
        BlocProvider(create: (context) => MedicamentBloc(dbProvider),),
        BlocProvider(create: (context) => SearchBloc(dbProvider),),
      ],
      child: MaterialApp(
        theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
        darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
