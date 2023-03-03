import 'package:esjourney/data/models/club_event_type_enum.dart';
import 'package:esjourney/logic/cubits/club_event/club_event_cubit.dart';
import 'package:esjourney/utils/screen_size.dart';
import 'package:esjourney/utils/strings.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterTopModalSheet extends StatefulWidget {
  FilterTopModalSheet({Key? key}) : super(key: key);

  @override
  State<FilterTopModalSheet> createState() => _FilterTopModalSheetState();
}

class _FilterTopModalSheetState extends State<FilterTopModalSheet> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: ScreenSize.height(context) / 4.5,
      color: theme.colorScheme.background,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: AppSizes.kbigSpace,
                  top: AppSizes.kbigSpace,
                  bottom: AppSizes.ksmallSpace),
              child: Text(AppStrings.keventType, style: theme.textTheme.headlineMedium),
            ),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: [
                      const SizedBox(width: AppSizes.kbigSpace),
                      Row(
                        children:  List.generate(ClubEventType.values.length,
                                (index) => GestureDetector(
                              onTap: (){
                                setState(() {
                                  _currentIndex = index;
                                });
                                BlocProvider.of<ClubEventCubit>(context).filter(ClubEventType.values[index]);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: AppSizes.ksmallSpace),
                                padding: const EdgeInsets.all(AppSizes.ksmallSpace),
                                decoration: BoxDecoration(
                                    color: _currentIndex == index ? theme.colorScheme.primary : theme.colorScheme.background,
                                    borderRadius: const BorderRadius.all(Radius.circular(AppSizes.kradius)),
                                    border: Border.all(color: _currentIndex == index ? theme.colorScheme.primary : theme.colorScheme.outline)),
                                child: Text(ClubEventType.values[index].name!, style: theme.textTheme.bodyMedium!.copyWith(color: _currentIndex == index ? theme.colorScheme.onPrimary : theme.colorScheme.secondary)),
                              ),
                            )),
                      ),
                      const SizedBox(width: AppSizes.ksmallSpace),
                    ]
                )
            ),
          ],
        ),
      ),
    );
  }
}
