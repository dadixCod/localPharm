import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localpharm/core/extensions/extensions.dart';

import 'package:localpharm/logic/search_bloc.dart/bloc/search_bloc.dart';
import 'package:localpharm/presentation/widgets/medicament_card.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SearchBloc>().add(SearchMedicament(''));
    ScrollController controller = ScrollController();
    final size = context.deviceSize;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: context.colorScheme.secondaryContainer,
        title: const Text(
          "Medicaments",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
          ),
        ),
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchInitial) {
            return Column(
              children: [
                Container(
                  height: 70,
                  padding: const EdgeInsets.only(bottom: 20),
                  margin: const EdgeInsets.only(bottom: 20),
                  color: context.colorScheme.secondaryContainer,
                  child: Center(
                    child: Container(
                      width: size.width * 0.9,
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      height: 50,
                      decoration: BoxDecoration(
                        color: context.colorScheme.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_rounded,
                            color:
                                context.colorScheme.background.withOpacity(0.7),
                          ),
                          const SizedBox(width: 10),
                          Center(
                            child: SizedBox(
                              width: size.width * 0.7,
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Recherche ...',
                                  hintStyle: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: context.colorScheme.background
                                        .withOpacity(0.6),
                                  ),
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(
                                  color: context.colorScheme.background,
                                  decoration: TextDecoration.none,
                                ),
                                textCapitalization:
                                    TextCapitalization.values[0],
                                onChanged: (text) {
                                  context.read<SearchBloc>().add(
                                      SearchMedicament(text.toLowerCase()));
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                state.medicaments.isEmpty
                    ? Container(
                        margin: const EdgeInsets.only(
                            bottom: 150, left: 15, right: 15),
                        child: Image.asset('assets/images/empty_list.png'),
                      )
                    : SizedBox(
                        height: size.height * 0.75,
                        child: ListView.separated(
                          separatorBuilder: ((context, index) => const SizedBox(
                                height: 15,
                              )),
                          controller: controller,
                          itemCount: state.medicaments.length,
                          itemBuilder: (context, index) {
                            final medicament = state.medicaments[index];

                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed('/details',
                                    arguments: medicament);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: MedicamentCard(
                                  medicament: medicament,
                                ),
                              ),
                            );
                          },
                        ),
                      )
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
