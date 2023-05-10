import 'package:esjourney/logic/cubits/application/application_cubit.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterHeader extends StatefulWidget {
  const FilterHeader({super.key, required this.controller});

  final controller;

  @override
  State<FilterHeader> createState() => _FilterHeaderState();
}

class _FilterHeaderState extends State<FilterHeader> {
  var _currentIndex = 0;

  final List<String> _clubs = [
    "All",
    "EcoMinds",
    "Nexus Debate",
    "Health Alliance"
  ];

  @override
  void deactivate() {
    BlocProvider.of<ApplicationCubit>(context).filter("All",true);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: FittedBox(
          child: Row(children: [
            const SizedBox(width: AppSizes.kbigSpace),
            Row(
              children: List.generate(
                  _clubs.length,
                  (index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            _currentIndex = index;
                            BlocProvider.of<ApplicationCubit>(context).filter(_clubs[index],widget.controller.isStart());
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                              right: AppSizes.ksmallSpace),
                          padding: const EdgeInsets.all(AppSizes.ksmallSpace),
                          decoration: BoxDecoration(
                              color: _currentIndex == index
                                  ? theme.colorScheme.primary
                                  : theme.colorScheme.background,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(AppSizes.kradius)),
                              border: Border.all(
                                  color: _currentIndex == index
                                      ? theme.colorScheme.primary
                                      : theme.colorScheme.onBackground)),
                          child: Text(_clubs[index],
                              style: theme.textTheme.bodyMedium!.copyWith(
                                  color: _currentIndex == index
                                      ? theme.colorScheme.onPrimary
                                      : theme.colorScheme.secondary)),
                        ),
                      )),
            ),
          ]),
        ));
  }
}
