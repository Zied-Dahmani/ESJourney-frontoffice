import 'package:esjourney/logic/cubits/club_event/club_event_cubit.dart';
import 'package:esjourney/logic/cubits/club_event/club_event_state.dart';
import 'package:esjourney/logic/cubits/location/location_cubit.dart';
import 'package:esjourney/presentation/widgets/club_event/event_details_card.dart';
import 'package:esjourney/presentation/widgets/club_event/event_marker.dart';
import 'package:esjourney/presentation/widgets/club_event/my_location_marker.dart';
import 'package:esjourney/presentation/widgets/drawer_icon.dart';
import 'package:esjourney/utils/constants.dart';
import 'package:esjourney/utils/screen_size.dart';
import 'package:esjourney/utils/strings.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong2/latlong.dart';

// TODO Event details card, and check again the code

class ClubEventsMapScreen extends StatefulWidget {
  const ClubEventsMapScreen({Key? key}) : super(key: key);

  @override
  State<ClubEventsMapScreen> createState() => _ClubEventsMapScreenState();
}

class _ClubEventsMapScreenState extends State<ClubEventsMapScreen> with SingleTickerProviderStateMixin {

  final _pageController = PageController();
  late final AnimationController _animationController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Builder(builder: (context) {
      final locationState = context.watch<LocationCubit>().state;
      final clubEventState = context.watch<ClubEventCubit>().state;

      if (locationState is LocationTurnOnSuccess && clubEventState is ClubEventLoadSuccess) {
        final clubEvents = _clubEventMarkers(clubEventState.clubEvents);
        return Stack(
          children: [
            FlutterMap(
              options: MapOptions(
                  maxZoom: 16, zoom: 13, center: locationState.latLng),
              nonRotatedChildren: [
                TileLayer(
                  urlTemplate: mapUrlTemplate,
                  additionalOptions: const {
                    'accessToken': mapToken,
                    'id': mapStyle
                  },
                ),
                MarkerLayer(markers: clubEvents),
                MarkerLayer(
                  markers: [
                    Marker(
                        height: AppSizes.kmarkerSizeExpanded,
                        width: AppSizes.kmarkerSizeExpanded,
                        point: locationState.latLng,
                        builder: (_) {
                          return MyLocationMarker(
                              animation: _animationController);
                        })
                  ],
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: AppSizes.ksmallSpace,
                  height: ScreenSize.height(context) * .3,
                  child: PageView.builder(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: clubEvents.length,
                      itemBuilder: (context, index) {
                        return EventDetailsCard(marker: clubEvents[index]);
                      }),
                ),
                const Positioned(
                    left: AppSizes.ksmallSpace,
                    top: AppSizes.khugeSpace,
                    child: DrawerIcon())
              ],
            ),
          ],
        );
      } else if (locationState is LocationTurnOffSuccess || clubEventState is ClubEventLoadFailure) {
        return Scaffold(
            appBar: AppBar(leading: const DrawerIcon()),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: AppSizes.kbigImageSize,
                      width: AppSizes.kbigImageSize,
                      child: SvgPicture.asset(
                          locationState is LocationTurnOffSuccess
                              ? 'assets/images/turn_on_location.svg'
                              : 'assets/images/no_internet.svg')),
                  const SizedBox(height: AppSizes.kbigSpace),
                  AbsorbPointer(
                    absorbing: locationState is! LocationTurnOffSuccess,
                    child: GestureDetector(
                        onTap: () => BlocProvider.of<LocationCubit>(context).currentLocation(false),
                        child: Text(
                            locationState is LocationTurnOffSuccess
                                ? AppStrings.kturnOnLocation
                                : kcheckInternetConnection,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: locationState is LocationTurnOffSuccess
                                        ? theme.colorScheme.primary
                                        : theme.colorScheme.secondary))),
                  )
                ],
              ),
            ));
      } else {
        return Scaffold(
            appBar: AppBar(leading: const DrawerIcon()),
            body: const Center(child: CircularProgressIndicator()));
      }
    });
  }

  List<Marker> _clubEventMarkers(clubEvents) {
    final events = <Marker>[];
    for (int i = 0; i < clubEvents.length; i++) {
      events.add(Marker(
          height: AppSizes.kmarkerSizeExpanded,
          width: AppSizes.kmarkerSizeExpanded,
          point: LatLng(clubEvents[i].latLng[0], clubEvents[i].latLng[1]),
          builder: (_) {
            return GestureDetector(
              onTap: () {
                _selectedIndex = i;
                setState(() {
                  _pageController.animateToPage(i,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut);
                });
              },
              child: EventMarker(isSelected: _selectedIndex == i),
            );
          }));
    }
    return events;
  }
}
