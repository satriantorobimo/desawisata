import 'dart:developer';
import 'dart:io';

import 'package:desa_wisata_nusantara/resources/route_string.dart';
import 'package:desa_wisata_nusantara/util/navigation_service.dart';
import 'package:desa_wisata_nusantara/util/setup_locator.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

import 'shared_preff.dart';

class DynamicLinkService {
  final NavigationService _navigationService = locator<NavigationService>();

  Future<void> initDynamicLinks(BuildContext context) async {
    if (Platform.isIOS) {
      FirebaseDynamicLinks.instance.onLink(
          onSuccess: (PendingDynamicLinkData dynamicLink) async {
        final Uri deepLink = dynamicLink?.link;
        print('Deeplink OnLink: $deepLink');
        print('DeeplinkPath OnLink: ${deepLink.path}');
        print('DeeplinkScheme OnLink: ${deepLink.scheme}');
        print('DeeplinkOrigin OnLink: ${deepLink.origin}');
        print('DeeplinkQuery OnLink: ${deepLink.query}');

        if (deepLink.path != null) {
          String code = deepLink.queryParameters['code'];

          Future<void>.delayed(const Duration(seconds: 3), () async {
            _navigationService.push(tempatDetailRoute, arguments: code);
          });
        }
      }, onError: (OnLinkErrorException e) async {
        print('onLinkError');
        print(e.message);
      });

      final PendingDynamicLinkData data =
          await FirebaseDynamicLinks.instance.getInitialLink();
      final Uri deepLink = data?.link;
      print('Deeplink : $deepLink');
      print('DeeplinkPath : ${deepLink.path}');
      print('DeeplinkScheme : ${deepLink.scheme}');
      print('DeeplinkOrigin : ${deepLink.origin}');
      print('DeeplinkQuery : ${deepLink.query}');

      if (deepLink.path != null) {
        String code = deepLink.queryParameters['code'];
        Future<void>.delayed(const Duration(seconds: 3), () async {
          _navigationService.push(tempatDetailRoute, arguments: code);
        });
      }
    } else {
      FirebaseDynamicLinks.instance.onLink(
          onSuccess: (PendingDynamicLinkData dynamicLink) async {
        final Uri deepLink = dynamicLink?.link;
        print('Deeplink OnLink: $deepLink');
        print('DeeplinkPath OnLink: ${deepLink.path}');
        print('DeeplinkScheme OnLink: ${deepLink.scheme}');
        print('DeeplinkOrigin OnLink: ${deepLink.origin}');
        print('DeeplinkQuery OnLink: ${deepLink.query}');

        if (deepLink.path != null) {
          String code = deepLink.queryParameters['code'];
          Future<void>.delayed(const Duration(seconds: 2), () async {
            _navigationService.push(tempatDetailRoute, arguments: code);
          });
        }
      }, onError: (OnLinkErrorException e) async {
        print('onLinkError');
        print(e.message);
      });

      //ini klo dari tutup apps
      final PendingDynamicLinkData data =
          await FirebaseDynamicLinks.instance.getInitialLink();
      final Uri deepLink = data?.link;
      print('Deeplink : $deepLink');
      print('DeeplinkPath : ${deepLink.path}');
      print('DeeplinkScheme : ${deepLink.scheme}');
      print('DeeplinkOrigin : ${deepLink.origin}');
      print('DeeplinkQuery : ${deepLink.query}');

      if (deepLink.path != null) {
        String code = deepLink.queryParameters['code'];
        SharedPreff().savedSharedBool('intro', true);
        Future<void>.delayed(const Duration(seconds: 3), () async {
          _navigationService.push(tempatDetailRoute, arguments: code);
        });
      }
    }
  }

  Future<Uri> createDynamicLink(String code) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://desawisata.page.link/',
      link: Uri.parse(
          'https://desawisata.page.link.com/wisata_detail?code=$code'),
      androidParameters: AndroidParameters(
          packageName: 'desa_wisata_nusantara.go.desa_wisata_nusantara',
          minimumVersion: 21),
      iosParameters: IosParameters(
        bundleId: 'your_ios_bundle_identifier',
        minimumVersion: '1',
        appStoreId: 'your_app_store_id',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: 'Hai',
        description: 'Aku mambagikan wisata dari aplikas desa wisata nusantara',
        imageUrl: Uri.parse(''),
      ),
    );
    final ShortDynamicLink shortDynamicLink = await parameters.buildShortLink();
    final Uri shortUrl = shortDynamicLink.shortUrl;
    log('$shortUrl');
    return shortUrl;
  }
}
