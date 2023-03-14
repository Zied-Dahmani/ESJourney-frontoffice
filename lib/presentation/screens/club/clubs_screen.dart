import 'package:esjourney/logic/cubits/club/club_cubit.dart';
import 'package:esjourney/logic/cubits/club/club_state.dart';
import 'package:esjourney/presentation/widgets/club/clubs_list.dart';
import 'package:esjourney/presentation/widgets/club/loading_clubs_list.dart';
import 'package:esjourney/presentation/widgets/empty_list.dart';
import 'package:esjourney/utils/strings.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ClubsScreen extends StatelessWidget {
  const ClubsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            padding: const EdgeInsets.symmetric(vertical: AppSizes.kbigSpace),
            child:
                BlocConsumer<ClubCubit, ClubState>(listener: (context, state) {
              if (state is ClubLoadFailure) {
                showTopSnackBar(
                  Overlay.of(context)!,
                  CustomSnackBar.error(
                    message: state.error,
                  ),
                );
              }
            }, builder: (context, state) {
              return state is ClubLoadSuccess && state.clubs.isNotEmpty
                  ? ClubsList(clubs: state.clubs)
                  : state is ClubLoadSuccess
                  ? const Center(child: EmptyList(text:AppStrings.knoClubs))
                      : state is ClubLoadInProgress || state is ClubLoadFailure
                          ? const LoadingClubsList()
                          : const SizedBox();
            })),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: const RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(AppSizes.kradius))),
          child:  Icon(FontAwesomeIcons.plus,color: Theme.of(context).colorScheme.onPrimary),
          onPressed: () {
            HydratedBloc.storage.clear();
          },
        ),
      ),
    );
  }
}
