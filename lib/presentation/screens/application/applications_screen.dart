import 'package:esjourney/logic/cubits/application/application_cubit.dart';
import 'package:esjourney/logic/cubits/application/application_state.dart';
import 'package:esjourney/presentation/widgets/application/applications_list.dart';
import 'package:esjourney/presentation/widgets/application/filter_header.dart';
import 'package:esjourney/presentation/widgets/application/loading_applications_list.dart';
import 'package:esjourney/presentation/widgets/drawer_icon.dart';
import 'package:esjourney/presentation/widgets/empty_list.dart';
import 'package:esjourney/utils/screen_size.dart';
import 'package:esjourney/utils/strings.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ApplicationsScreen extends StatefulWidget {
  const ApplicationsScreen({Key? key}) : super(key: key);

  @override
  State<ApplicationsScreen> createState() => _ApplicationsScreenState();
}

class _ApplicationsScreenState extends State<ApplicationsScreen> {

  final ScrollController _scrollController = ScrollController();
  double _topContainer = 0.0;

  void onListener() {
    double value = _scrollController.offset / 119;
    setState(() {
      _topContainer = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(onListener);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            height: ScreenSize.height(context),
            color: theme.colorScheme.background,
          ),
        ),
        Positioned.fill(
          top: AppSizes.khugeSpace * 3.5,
          child: Column(
            children: [
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: (1 - _topContainer).clamp(0.0, 1.0),
                child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: ScreenSize.width(context),
                    alignment: Alignment.topCenter,
                    height: (1 - _topContainer * 2).clamp(0.0, 1.0) * (ScreenSize.height(context) / 4),
                    child: const FilterHeader()),
              ),
            ],
          ),
        ),
        Positioned.fill(
          top: AppSizes.khugeSpace * 5.8,
          child: BlocConsumer<ApplicationCubit, ApplicationState>(
            listener: (context, state) {
              if (state is ApplicationLoadFailure) {
                showTopSnackBar(
                  Overlay.of(context)!,
                  CustomSnackBar.error(
                    message: state.error,
                  ),
                );
              }
            },
            builder: (context, state) {
              return state is ApplicationLoadSuccess && state.applications.isNotEmpty
                  ? ApplicationsList(applications: state.applications, scrollController: _scrollController, topContainer: _topContainer)
                  : state is ApplicationLoadSuccess
                      ? const EmptyList(text: AppStrings.knoApplications)
                      : state is ApplicationLoadInProgress || state is ApplicationLoadFailure
                          ? const LoadingApplicationsList()
                          : const SizedBox();
            },
          ),
        ),
        const Positioned(
            left: AppSizes.ksmallSpace,
            top: AppSizes.khugeSpace * 1.3,
            child: DrawerIcon()),
        Positioned(
            left: AppSizes.ksmallSpace * 6,
            top: AppSizes.khugeSpace * 1.7,
            child: Text(
              AppStrings.kapplications,
              style: theme.textTheme.headlineMedium,
            )),
      ],
    );
  }
}
