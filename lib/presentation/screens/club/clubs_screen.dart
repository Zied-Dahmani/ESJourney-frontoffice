import 'package:esjourney/logic/cubits/club/club_cubit.dart';
import 'package:esjourney/logic/cubits/club/club_state.dart';
import 'package:esjourney/presentation/widgets/club/clubs_list.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

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
                    ? const Center(child: Icon(FontAwesomeIcons.xmark))
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium),
                                  ),
                                ],
                              )
                            : const SizedBox();
          }),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: const RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(AppSizes.kradius))),
          child: const Icon(FontAwesomeIcons.plus),
          onPressed: () {
            HydratedBloc.storage.clear();
          },
        ),
      ),
    );
  }
}
