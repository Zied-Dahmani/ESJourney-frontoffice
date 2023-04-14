import 'package:esjourney/logic/cubits/user/user_cubit.dart';
import 'package:esjourney/logic/cubits/user/user_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../utils/screen_size.dart';
import '../../../widgets/button.dart';

class EthQrCodeScreen extends StatefulWidget {
  const EthQrCodeScreen({Key? key}) : super(key: key);

  @override
  State<EthQrCodeScreen> createState() => _EthQrCodeScreenState();
}

class _EthQrCodeScreenState extends State<EthQrCodeScreen> {
  int _selectedAmount = 0;
  int userCoins = 0;

  @override
  Widget build(BuildContext context) {
    final double width = ScreenSize.width(context);
    final theme = Theme.of(context);
    return Scaffold(
      body: Builder(
        builder: (context) {
          final userState = context.watch<UserCubit>().state;

          if (userState is UserLoadInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (userState is UserLogInSuccess) {
            userCoins = userState.user.coins.toInt();
            List<String> myList = [
              userState.user.walletAddress!,
              userState.user.privateKey!,
              _selectedAmount.toString()
            ];
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonWidget(
                    width: 10,
                    backgroundColor: theme.colorScheme.primary,
                    function: () {
                      _showAmountPicker(context);
                    },
                    text: 'Choose Amount',
                  ),
                  ButtonWidget(
                    function: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            //surfaceTintColor: Colors.white,
                            content: SizedBox(
                              width: width * 0.8,
                              height: width * 0.8,
                              child: Center(
                                child: QrImage(
                                  data: myList.join(","),
                                  // Convert list to comma-separated string
                                  version: QrVersions.auto,
                                  size: width * 0.6,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    text: 'Generate QR Code',
                    backgroundColor: theme.colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    ' Amount to be generated is : $_selectedAmount',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'VisbyRoundCF',
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('Something went wrong'));
          }
        },
      ),
    );
  }

  void _showAmountPicker(BuildContext context) {
    final theme = Theme.of(context);
    final double width = ScreenSize.width(context);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          //surfaceTintColor: Colors.white,
          title: const Text(
            'Select Amount',
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'VisbyRoundCF',
                fontWeight: FontWeight.w700),
          ),
          content: SizedBox(
            width: width * 0.8,
            height: width * 0.8,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: CupertinoPicker(
                itemExtent: 32,
                onSelectedItemChanged: (index) {
                  setState(() {
                    _selectedAmount =
                        index + 1; // Add 1 to index to get values from 1 to 20
                  });
                },
                scrollController: FixedExtentScrollController(
                    initialItem: _selectedAmount - 1),
                children: List.generate(userCoins, (index) {
                  // Generate Text widgets with black text color
                  return GestureDetector(
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'VisbyRoundCF',
                          fontWeight: FontWeight.w700),
                    ),
                  );
                }),
              ),
            ),
          ),
        );
      },
    );
  }
}
