import 'package:esjourney/logic/cubits/club/club_cubit.dart';
import 'package:esjourney/logic/cubits/club/club_state.dart';
import 'package:esjourney/presentation/widgets/clubs_list.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClubsScreen extends StatelessWidget {
  const ClubsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: AppSizes.khugeSpace),
          child: BlocBuilder<ClubCubit, ClubState>(builder: (context, state) {
            return state is ClubLoadSuccess && state.clubs.isNotEmpty
                ? ClubsList(clubs: state.clubs)
                : state is ClubLoadSuccess
                  // TODO Display an image
                  ? const Center(child: CircularProgressIndicator())
                : state is ClubLoadInProgress
                    ? const Center(child: CircularProgressIndicator())
                    : state is ClubLoadFailure
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: AppSizes.khugeSpace),
                              // TODO Display an image
                              const SizedBox(height: AppSizes.kbigSpace),
                              Center(
                                child: Text(state.error,
                                    style: Theme.of(context).textTheme.bodySmall),
                              ),
                            ],
                          )
                        : const SizedBox();
          }),
        ),
        // TODO radius
        floatingActionButton: FloatingActionButton(
          onPressed: () {
          },
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
