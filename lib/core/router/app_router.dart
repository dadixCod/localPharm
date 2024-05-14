import 'package:flutter/material.dart';
import 'package:localpharm/backend/models/medicament.dart';
import 'package:localpharm/presentation/screens/add_medicament_screen.dart';
import 'package:localpharm/presentation/screens/home_screen.dart';
import 'package:localpharm/presentation/screens/medicament_details_screen.dart';
import 'package:localpharm/presentation/screens/search_screen.dart';
import 'package:localpharm/presentation/screens/update_medicament_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/add_med':
        return MaterialPageRoute(builder: (_) => const AddMedicamentScreen());
      case '/update_med':
        {
          final medicament = settings.arguments as Medicament;
          return MaterialPageRoute(
            builder: (_) => UpdateMedicamentScreen(
              medicament: medicament,
            ),
          );
        }
      case '/details':
        {
          final medicament = settings.arguments as Medicament;
          return MaterialPageRoute(
            builder: (_) => MedicamentDetailScreen(medicament: medicament),
          );
        }
      case '/search':
        return MaterialPageRoute(builder: (_) => const SearchScreen());

      default:
        throw 'error';
    }
  }
}
