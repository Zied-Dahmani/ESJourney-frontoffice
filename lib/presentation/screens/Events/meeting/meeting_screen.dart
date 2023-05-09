import 'package:esjourney/presentation/screens/zoom_drawer_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc_wrapper/flutter_webrtc_wrapper.dart';
import 'package:esjourney/presentation/widgets/events/remote_connection.dart';
import '../../../../data/models/events/event_model.dart';
import '../../../../logic/cubits/user/user_cubit.dart';
import '../../../../logic/cubits/user/user_state.dart';
import '../../../../utils/constants.dart';
import '../../../../data/models/events/meeting/meeting_details.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:esjourney/presentation/widgets/events/control_panel.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../../widgets/events/poll.dart';
import '../../../widgets/events/poll_users.dart';



class MeetingPage extends StatefulWidget {

  final Event event;

  const MeetingPage(
      {Key? key, required this.event})
      : super(key: key);

  @override
  State<MeetingPage> createState() => _MeetingPageState();
}


class _MeetingPageState extends State<MeetingPage> {
  late String handUser;
  final _localRenderer = RTCVideoRenderer();
  final Map<String, dynamic> mediaConstraints = {'audio': true, 'video': true};
  bool isConnectionFailed = false;
  WebRTCMeetingHelper? meetingHelper;
  bool _isHost = false;
  bool _isPollDisplayed = false;
  String? _pollQuestion;
  List<String>? _pollOptions;
  Map<String, int>? _pollVotes;
  int _remainingTime = 0;
  String? _votedOption;

  //final FlutterTts flutterTts = FlutterTts();
  @override
  void dispose() {
    _localRenderer.dispose();
    if (meetingHelper != null) {
      meetingHelper!.destroy();
      meetingHelper = null;
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final userState = context.read<UserCubit>().state;
    if (userState is UserLogInSuccess) {
      initRenderers();
      handUser = userState.user.username;
      //isHost = userState.user.username == widget.event.host;
      _isHost = userState.user.id == widget.event.meeting?.hostId;
      startMeeting(userState.user.id);
    }
  }

  initRenderers() async {
    await _localRenderer.initialize();
  }

  void startMeeting(String userId) async {
    final userState = context.read<UserCubit>().state;
    if (userState is! UserLogInSuccess) return;
    final userId = userState.user.id;
    final userName = userState.user.username;
    print('event: ${widget.event}');
    print('userId: $userId');
    print('meetingid${widget.event.meeting?.id}');
    meetingHelper = WebRTCMeetingHelper(
      url: kmeetingUrl,
      meetingId: widget.event.meeting?.id,
      userId: userId,
      name: userName,
    );
    MediaStream _localStream =
    await navigator.mediaDevices.getUserMedia(mediaConstraints);
    _localRenderer.srcObject = _localStream;
    meetingHelper!.stream = _localStream;
    meetingHelper!.on(
      'open',
      this,
          (ev, _) {
        setState(() {
        });
      },
    );
    meetingHelper!.on(
      'connection',
      this,
          (ev, _) {
        setState(() {
        });
      },
    );
    meetingHelper!.on(
      'user-left',
      this,
          (ev, _) {
        setState(() {
          print('user-left');
        });
      },
    );
    meetingHelper!.on(
      'video-toggle',
      this,
          (ev, _) {
        setState(() {});
      },
    );
    meetingHelper!.on(
      'audio-toggle',
      this,
          (ev, _) {
        setState(() {});
      },
    );
    meetingHelper!.on('poll-result', null, (ev, context) {
      final pollResult = ev.eventData as PollData;
      setState(() {
        _pollQuestion = pollResult.question;
        _pollOptions = pollResult.options;
        _pollVotes = pollResult.votes;
      });
      print('Poll Result: $_pollVotes');
    });
    meetingHelper!.on('poll-data', null, (ev, context) {
      final pollData = ev.eventData as PollData;
      setState(() {
        _pollQuestion = pollData.question;
        _pollOptions = pollData.options;
        _pollVotes = pollData.votes; // Set the votes map
        _isPollDisplayed = true;
        _remainingTime = 30; // Set the remaining time to 30 seconds
        _startTimer(); // Start the timer
      });
      print('Votes: $_pollVotes'); // Print the votes map
    });

    meetingHelper!.on(
        'hand-toggle',
        this,
            (ev, _) {
          setState(() {
            print('hand-toggle');
            onHandToggle();
          });
        }
    );
    meetingHelper!.on(
      'meeting-ended',
      this,
          (ev, _) {
        setState(() {
          print('meeting-ended');
          onMeetingEnd();
        });
      },
    );
    meetingHelper!.on(
      'connection-setting-changed',
      this,
          (ev, _) {
        setState(() {
        });
      },
    );
    meetingHelper!.on(
      'stream-changed',
      this,
          (ev, _) {
        setState(() {
        });
      },
    );
    setState(() {});
  }

  Future<void> _showPollCreationDialog() async {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Create Poll'),
          content: SingleChildScrollView(
            child: PollCreationForm(
              onSubmit: (String question, List<String> options) {
                print('Question: $question');
                print('Options: $options');
                meetingHelper!.sendPollData(question, options);
                Navigator.of(context).pop();
              },
            ),
          ),
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: GestureDetector(
        onDoubleTap: () {
          if (meetingHelper != null) {
            meetingHelper!.switchCameraForCurrentUser();
          }
        },
        child: _buildMeetingRoom(),
      ),
      bottomNavigationBar: ControlPanel(
        onHostMenu: _showPollCreationDialog, // Add this line
        onAudioToggle: onAudioToggle,
        onVideoToggle: onVideoToggle,
        videoEnabled: isVideoEnabled(),
        audioEnabled: isAudioEnabled(),
        isConnectionFailed: isConnectionFailed,
        onReconnect: handleReconnect,
        onMeetingEnd: onMeetingEnd,
        onHandToggle: onHandToggle,
        handEnabled: isHandEnabled(),
        isHost: _isHost,
      ),
    );
  }
//print('meeting id1: ${widget.event.meeting?.id}');
  _buildMeetingRoom() {

    return Stack(
      children: [
        meetingHelper != null && meetingHelper!.connections.isNotEmpty ?
        GridView.count(
          crossAxisCount: meetingHelper!.connections.length < 3 ? 1 : 2,
          children: List.generate(meetingHelper!.connections.length, (index) {
            return Padding(
              padding: const EdgeInsets.all(1),
              child: RemoteConnection(
                renderer: meetingHelper!.connections[index].renderer,
                connection: meetingHelper!.connections[index],
                hostId: widget.event.meeting?.hostId,
              ),
            );
          }),
        ) : const Center(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Waiting for other participants to join',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 24,
              ),
            ),
          ),
        ),
        if (_isPollDisplayed)
          Positioned.fill(
            child: Container(
              color: Colors.black54,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PollResult(
                        question: _pollQuestion!,
                        options: _pollOptions!,
                        votes: _pollVotes!,
                        displayTime: 30,
                        onVote: _onVote,
                        votedOption: _votedOption,
                        onClose: () {
                          setState(() {
                            _isPollDisplayed = false;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      _remainingTime > 0
                        ?Text(
                        'Results will be hidden in $_remainingTime seconds...',
                        style: const TextStyle(fontSize: 16),
                        )
                        :const Text(
                          'Poll ended',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        Positioned(
          bottom: 10,
          right: 0,
          child: SizedBox(
            width: 150,
            height: 200,
            child: RTCVideoView(_localRenderer),
          ),
        ),
      ],
    );
  }

  void _onVote(String option) {
    if (_votedOption != null) {
      setState(() {
        if (_pollVotes!.containsKey(_votedOption!)) {
          _pollVotes!.update(_votedOption!, (value) => value - 1);
        }
      });
    }

    setState(() {
      _votedOption = option;
      if (_pollVotes!.containsKey(option)) {
        _pollVotes!.update(option, (value) => value + 1);
      } else {
        _pollVotes![option] = 1;
      }
    });

    if (meetingHelper != null) {
      meetingHelper!.broadcastPollResult(_pollQuestion!, _pollOptions!, _pollVotes!);
    }
  }



  void _startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _remainingTime--;
        if (_remainingTime > 0) {
          _startTimer();
        }
      });
    });
  }


  void onMeetingEnd() {
    if (meetingHelper != null) {
      meetingHelper!.endMeeting();
      meetingHelper!.destroy();
      setState(() {
        isConnectionFailed = false;
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ZoomDrawerScreen()));
    }
  }

  void onHandToggle() {
    if (meetingHelper != null) {
      setState(() {
        meetingHelper!.toggleHand();
        //if (meetingHelper!.handEnabled!) {
        //print('condition ${meetingHelper!.handEnabled!}');
        //flutterTts.speak('$handUser Hand raise enabled');
        //}
      });
    }
  }

  void onAudioToggle() {
    if (meetingHelper != null) {
      setState(() {
        meetingHelper!.toggleAudio();
      });
    }
  }

  void onVideoToggle() {
    if (meetingHelper != null) {
      setState(() {
        meetingHelper!.toggleVideo();
      });
    }
  }

  void handleReconnect() {
    if (meetingHelper != null) {
      meetingHelper!.reconnect();
    }
  }

  bool isAudioEnabled() {
    return meetingHelper != null ? meetingHelper!.audioEnabled! : false;
  }

  bool isVideoEnabled() {
    return meetingHelper != null ? meetingHelper!.videoEnabled! : false;
  }

  bool isHandEnabled() {
    return meetingHelper != null ? meetingHelper!.handEnabled! : true;
  }

  void goToHomePage() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const ZoomDrawerScreen()));
  }
}