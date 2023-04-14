import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

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
      color: Colors.blueGrey[900],
      height: 60.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: buildControls(),
      ),
    );
  }

  List<Widget> buildControls() {
    if (!isConnectionFailed!) {
      return <Widget>[
        IconButton(
          onPressed: onVideoToggle,
          icon: Icon(videoEnabled! ? Icons.videocam : Icons.videocam_off),
          color: Colors.white,
          iconSize: 32,
        ),
        IconButton(
          onPressed: onAudioToggle,
          icon: Icon(audioEnabled! ? Icons.mic : Icons.mic_off),
          color: Colors.white,
          iconSize: 32,
        ),
        if (isHost!)
          IconButton(
            onPressed: onHostMenu,
            icon: Icon(Icons.more_vert),
            color: Colors.white,
            iconSize: 32,
          ),
        IconButton(
          onPressed: onHandToggle,
          icon: Icon(handEnabled! ? Icons.back_hand : Icons.back_hand_outlined),
          color: Colors.white,
          iconSize: 32,
        ),
        const SizedBox(width: 25),
        Container(
          width: 70,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            icon: const Icon(
              Icons.call_end,
              color: Colors.white,
            ),
            onPressed: onMeetingEnd!,
          ),
        )
      ];
    } else {
      return <Widget>[
        FormHelper.submitButton(
          'Reconnect',
          onReconnect!,
          btnColor: Colors.red,
          borderRadius: 10,
          width: 200,
          height: 40,
        )
      ];
    }
  }
}
