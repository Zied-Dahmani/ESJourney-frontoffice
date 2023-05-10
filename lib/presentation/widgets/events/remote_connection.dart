import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:flutter_webrtc_wrapper/flutter_webrtc_wrapper.dart';

class RemoteConnection extends StatefulWidget {
  final RTCVideoRenderer renderer;
  final Connection connection;
  final String? hostId;

  const RemoteConnection({required this.renderer, required this.connection, required this.hostId});

  @override
  State<RemoteConnection> createState() => _RemoteConnectionState();
}

class _RemoteConnectionState extends State<RemoteConnection> {
  @override
  Widget build(BuildContext context) {
    bool isHost = widget.connection.userId == widget.hostId;

    return Stack(
      children: [
        SizedBox(
          child: RTCVideoView(
            widget.renderer,
            mirror: false,
            objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
          ),
        ),
        Container(
          color: widget.connection.videoEnabled! ? Colors.transparent : Colors.blueGrey[900],
          child: Center(
            child: Text(
              widget.connection.videoEnabled! ? '' : widget.connection.name!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (isHost)
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: SvgPicture.asset(
                      'assets/images/CrownMeeting.svg',
                      width: 20,
                      height: 20,
                    ),
                  ),
                const SizedBox(width: 5),
                Text(
                  widget.connection.name!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(width: 5),
                Icon(
                  widget.connection.audioEnabled! ? Icons.mic : Icons.mic_off,
                  color: Colors.white,
                  size: 15,
                ),
                const SizedBox(width: 5),
                Icon(
                  widget.connection.handEnabled! ? Icons.back_hand : Icons.back_hand_outlined,
                  color: Colors.white,
                  size: 15,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
