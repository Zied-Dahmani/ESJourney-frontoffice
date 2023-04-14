import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DynamicLink {
  Future<String> init() async {
    final instanceLink = await FirebaseDynamicLinks.instance.getInitialLink();
    if (instanceLink != null) {
      return instanceLink.link.queryParameters['clubId'].toString();
    } else {
      return '';
    }
  }

  Future<String> create(String clubId) async {
    final String url = 'https://com.esprit.esjourney?clubId=$clubId';
    final DynamicLinkParameters parameters = DynamicLinkParameters(
        androidParameters: const AndroidParameters(
            packageName: 'com.esprit.esjourney', minimumVersion: 0),
        iosParameters: const IOSParameters(
            bundleId: 'com.esprit.esjourney', minimumVersion: '0'),
        link: Uri.parse(url),
        uriPrefix: 'https://esjourney.page.link');

    final link = await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    return link.shortUrl.toString();
  }
}
