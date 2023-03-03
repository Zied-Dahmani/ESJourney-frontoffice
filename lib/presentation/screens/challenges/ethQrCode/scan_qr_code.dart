import 'dart:developer';
import 'dart:io';

import 'package:esjourney/logic/cubits/user/user_cubit.dart';
import 'package:esjourney/logic/cubits/user/user_state.dart';
import 'package:esjourney/presentation/animations/face_id_animation_controller.dart';
import 'package:esjourney/presentation/animations/face_id_painter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRViewExample extends StatefulWidget {
  const QRViewExample({
    Key? key,
    this.customPaintSize = 200.0,
  }) : super(key: key);
  final double customPaintSize;
  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

String senderWalletAddress = "";
String senderPrivateKey = "";
String receiverToken = "";
double  amount = 0.1;
class _QRViewExampleState extends State<QRViewExample>     with SingleTickerProviderStateMixin {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late final FaceIDAnimationController _controller;
  @override
  void initState() {
    super.initState();

  }
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          final userState = context.watch<UserCubit>().state;
          final user = userState is UserLogInSuccess ? userState.user : null;

          if (userState is UserLoadInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (userState is UserLogInSuccess) {
            receiverToken = userState.user.token!;
            return Column(
              children: <Widget>[
                Expanded(flex: 4, child: _buildQrView(context)),
                Expanded(
                  flex: 1,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        if (result != null)
                          Text(
                              'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                        else
                          const Text('Scan a code'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.all(8),
                              child: ElevatedButton(
                                  onPressed: () async {
                                    await controller?.toggleFlash();
                                    setState(() {});
                                  },
                                  child: FutureBuilder(
                                    future: controller?.getFlashStatus(),
                                    builder: (context, snapshot) {
                                      return Text('Flash: ${snapshot.data}');
                                    },
                                  )),
                            ),
                            Container(
                              margin: const EdgeInsets.all(8),
                              child: ElevatedButton(
                                  onPressed: () async {
                                    await controller?.flipCamera();
                                    setState(() {});
                                  },
                                  child: FutureBuilder(
                                    future: controller?.getCameraInfo(),
                                    builder: (context, snapshot) {
                                      if (snapshot.data != null) {
                                        return Text(
                                            'Camera facing ${describeEnum(snapshot.data!)}');
                                      } else {
                                        return const Text('loading');
                                      }
                                    },
                                  )),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.all(8),
                              child: ElevatedButton(
                                onPressed: () async {
                                  await controller?.pauseCamera();
                                },
                                child: const Text('pause',
                                    style: TextStyle(fontSize: 20)),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(8),
                              child: ElevatedButton(
                                onPressed: () async {
                                  await controller?.resumeCamera();
                                },
                                child: const Text('resume',
                                    style: TextStyle(fontSize: 20)),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.first.then((scanData) {

       setState(() {
        result = scanData;
        List<String> dataList = scanData.code!.split(",");

        senderWalletAddress = dataList[0];
        senderPrivateKey = dataList[1];
      });


     BlocProvider.of<UserCubit>(context).sendEth(
        senderWalletAddress,
        senderPrivateKey,
        amount,
        receiverToken,
      );
       AudioPlayer audioPlayer = AudioPlayer();
       audioPlayer.setAsset('assets/sound/scan_complete.mp3');
       audioPlayer.play();

    });

    /*controller.scannedDataStream.first.then((scanData) {
      print("scan data ${scanData.code}");
      print("scan complete last");

    });*/
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
