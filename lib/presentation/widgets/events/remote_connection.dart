// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_webrtc/flutter_webrtc.dart';
// import 'package:flutter_webrtc_wrapper/flutter_webrtc_wrapper.dart';
//
// class RemoteConnection extends StatefulWidget {
//   final RTCVideoRenderer renderer;
//   final Connection connection;
//   final String? hostId;
//
//   const RemoteConnection({required this.renderer, required this.connection, required this.hostId});
//
//   @override
//   State<RemoteConnection> createState() => _RemoteConnectionState();
// }
//
// class _RemoteConnectionState extends State<RemoteConnection> {
//   @override
//   Widget build(BuildContext context) {
//     bool isHost = widget.connection.userId == widget.hostId;
//
//     return Stack(
//       children: [
//         SizedBox(
//           child: RTCVideoView(
//             widget.renderer,
//             mirror: false,
//             objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
//           ),
//         ),
//         Container(
//           color: widget.connection.videoEnabled! ? Colors.transparent : Colors.blueGrey[900],
//           child: Center(
//             child: Text(
//               widget.connection.videoEnabled! ? '' : widget.connection.name!,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 30,
//               ),
//             ),
//           ),
//         ),
//         // Add the custom crown image for the host
//         if (isHost)
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             child: Image.asset(
//               'assets/images/crown.png',
//             ),
//           ),
//         Positioned(
//           child: Container(
//             padding: const EdgeInsets.all(5),
//             color: Colors.black,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   widget.connection.name!,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 15,
//                   ),
//                 ),
//                 Icon(
//                   widget.connection.audioEnabled! ? Icons.mic : Icons.mic_off,
//                   color: Colors.white,
//                   size: 15,
//                 ),
//                 Icon(
//                   widget.connection.handEnabled! ? Icons.back_hand : Icons.back_hand_outlined,
//                   color: Colors.white,
//                   size: 15,
//                 ),
//               ],
//             ),
//           ),
//           bottom: 10,
//           left: 10,
//         ),
//       ],
//     );
//   }
// }
//
