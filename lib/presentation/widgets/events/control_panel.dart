import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ControlPanel extends StatelessWidget {
  final bool? videoEnabled;
  final bool? audioEnabled;
  final bool? isConnectionFailed;
  final bool? handEnabled;
  final bool? isHost;
  final VoidCallback? onVideoToggle;
  final VoidCallback? onAudioToggle;
  final VoidCallback? onReconnect;
  final VoidCallback? onMeetingEnd;
  final VoidCallback? onHandToggle;
  final VoidCallback? onHostMenu;

  ControlPanel({
    this.videoEnabled,
    this.audioEnabled,
    this.handEnabled,
    this.isConnectionFailed,
    this.onVideoToggle,
    this.onAudioToggle,
    this.onReconnect,
    this.onMeetingEnd,
    this.onHandToggle,
    this.isHost = false,
    this.onHostMenu,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      margin: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: buildControls(),
      ),
    );
  }
  List<Widget> buildControls() {
    if (!isConnectionFailed!) {
      return <Widget>[
        for (var item in [
          IconButtonData(
              onPressed: onVideoToggle,
              iconData: videoEnabled! ? Icons.videocam : Icons.videocam_off),
          IconButtonData(
              onPressed: onAudioToggle,
              iconData: audioEnabled! ? Icons.mic : Icons.mic_off),
          if (isHost!)
            IconButtonData(onPressed: onHostMenu, iconData: Icons.more_vert),
          IconButtonData(
              onPressed: onHandToggle,
              iconData: handEnabled! ? Icons.back_hand : Icons.back_hand_outlined),
        ])
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Material(
              color: Colors.transparent,
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.blueGrey[800],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      offset: Offset(0, 2),
                      blurRadius: 3,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: item.onPressed,
                  icon: Icon(item.iconData),
                  color: Colors.white,
                  iconSize: 32,
                ),
              ),
            ),
          ),
        SizedBox(width: 10),
        Material(
          color: Colors.transparent,
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.red,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(
                Icons.call_end,
                color: Colors.white,
              ),
              onPressed: onMeetingEnd!,
            ),
          ),
        ),
      ];
    } else {
      return <Widget>[
        SizedBox(
          width: 200,
          height: 40,
          child: ElevatedButton(
            onPressed: onReconnect,
            child: const Text(
              'Reconnect',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 4,
            ),
          ),
        ),
      ];
    }
  }
}

class IconButtonData {
  final VoidCallback? onPressed;
  final IconData iconData;

  IconButtonData({this.onPressed, required this.iconData});
}