import 'package:chewie/chewie.dart';
import 'package:esjourney/utils/constants.dart';
import 'package:esjourney/utils/screen_size.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';

class ShortScreen extends StatefulWidget {
  const ShortScreen({Key? key, required this.short}) : super(key: key);

  final String short;

  @override
  State<ShortScreen> createState() => _ShortScreenState();
}

class _ShortScreenState extends State<ShortScreen> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network('$kbaseUrl${widget.short}');
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
      showControls: true,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        Chewie(
          controller: _chewieController,
        ),
        Positioned(
            top: ScreenSize.height(context)/2.5,
            right: AppSizes.ksmallSpace,
            child: Column(
              children: [
                Icon(FontAwesomeIcons.solidHeart,color: theme.colorScheme.onPrimary),
                Text('1999',style: theme.textTheme.bodySmall!.copyWith(color: theme.colorScheme.onPrimary)),
                const SizedBox(height: AppSizes.ksmallSpace),
                Icon(FontAwesomeIcons.solidComment,color: theme.colorScheme.onPrimary),
                Text('31',style: theme.textTheme.bodySmall!.copyWith(color: theme.colorScheme.onPrimary)),
                const SizedBox(height: AppSizes.ksmallSpace),
                Icon(FontAwesomeIcons.share,color: theme.colorScheme.onPrimary),
                Text('8',style: theme.textTheme.bodySmall!.copyWith(color: theme.colorScheme.onPrimary)),
              ],
            )),
        Positioned(
            bottom: AppSizes.khugeSpace * 5,
            left: AppSizes.ksmallSpace,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nexus Debate',style: theme.textTheme.headlineMedium!.copyWith(color: theme.colorScheme.outline)),
                SizedBox(
                    width: ScreenSize.width(context),
                    child: Text('A club dedicated to the art of debate and public speaking.',style: theme.textTheme.bodySmall!.copyWith(color: theme.colorScheme.onPrimary))),
              ],
            )),
      ],
    );
  }
}
