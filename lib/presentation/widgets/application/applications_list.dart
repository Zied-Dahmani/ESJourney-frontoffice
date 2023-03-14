import 'package:esjourney/presentation/widgets/application/application_card.dart';
import 'package:flutter/material.dart';

class ApplicationsList extends StatelessWidget {
  const ApplicationsList({Key? key, required this.applications, required this.scrollController, required this.topContainer}) : super(key: key);

  final applications,scrollController,topContainer;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: scrollController,
        itemCount: applications.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          double scale = 1.0;
          scale = (index + 1.0 - topContainer).clamp(0.0, 1.0);

          return Opacity(
            opacity: scale,
            child: Transform(
              transform: Matrix4.identity()..scale(scale, scale),
              alignment: Alignment.bottomCenter,
              child: Align(
                  heightFactor: 0.7,
                  alignment: Alignment.topCenter,
                  child: ApplicationCard(
                    application: applications[index],
                  )),
            ),
          );
        });
  }
}
