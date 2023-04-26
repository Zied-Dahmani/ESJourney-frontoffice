import 'package:esjourney/presentation/screens/club/short_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';

class ShortsScreen extends StatefulWidget {
  const ShortsScreen({Key? key, required this.shorts, required this.startIndex})
      : super(key: key);

  final List<String> shorts;
  final startIndex;

  @override
  State<ShortsScreen> createState() => _ShortsScreenState();
}

class _ShortsScreenState extends State<ShortsScreen> {
  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
    ));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Theme.of(context).colorScheme.onBackground,
        ),
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return ShortScreen(short: widget.shorts[index]);
          },
          itemCount: widget.shorts.length,
          scrollDirection: Axis.vertical,
        ));
  }
}
