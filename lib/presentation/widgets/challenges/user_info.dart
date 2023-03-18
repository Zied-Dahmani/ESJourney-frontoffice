import 'package:flutter/material.dart';
class UserInfo extends StatelessWidget {
  const UserInfo({
    super.key,
    required this.infoTitle,
    required this.infoValue,

    this.onTap,
  });

  final String infoTitle;
final void Function()? onTap;
  final String infoValue;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: GestureDetector(
        child: Container(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 11.0, bottom: 11.0),
          color: Colors.white,
          margin:
          const EdgeInsets.only(left: 15, right: 15, top: 5.0, bottom: 5.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              infoTitle,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'VisbyRoundCF',
              ),
            ),
            Row(
              children: [
                Text(
                  infoValue,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'VisbyRoundCF',
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 15,
                  color: Colors.grey[600],
                ),
              ],
            )
          ]),
        ),
      ),
    );

  }
}