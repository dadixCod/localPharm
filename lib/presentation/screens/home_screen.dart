import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localpharm/core/extensions/extensions.dart';
import 'package:localpharm/services/notification_service.dart';
import '../../logic/blocs/medicament_bloc.dart';
import '../widgets/medicament_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NotificationsServices notificationsServices = NotificationsServices();
  @override
  void initState() {
    super.initState();
    notificationsServices.initializeNotifications();
  }

  @override
  Widget build(BuildContext context) {
    context.read<MedicamentBloc>().add(GetAllMedicaments());
    final size = context.deviceSize;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Ma Pharmacie",
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/search');
            },
            icon: const Icon(
              Icons.search_rounded,
            ),
          )
        ],
        foregroundColor: context.colorScheme.background,
        backgroundColor: context.colorScheme.primary,
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<MedicamentBloc, MedicamentState>(
          builder: (context, state) {
            if (state is MedicamentsLoaded) {
              final medicaments = state.medicaments;
              if (medicaments.isEmpty) {
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 100, bottom: 15),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Image.asset('assets/images/empty_list.png'),
                    ),
                    const Text(
                      "Aucun médicament n'est ajouté",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                );
              }
              return Container(
                  height: size.height * 0.9,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return MedicamentCard(
                        medicament: medicaments[index],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 10);
                    },
                    itemCount: medicaments.length,
                  ));
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/add_med');
        },
        backgroundColor: context.colorScheme.primaryContainer,
        child: const Icon(
          Icons.add_rounded,
          size: 35,
        ),
      ),
    );
  }
}
