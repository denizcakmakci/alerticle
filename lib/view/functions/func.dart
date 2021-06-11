import 'package:flutter/material.dart';

import '../../core/init/theme/app_theme_light.dart';

// A class for the function that sets the icon and color for the card widgets.
class IconColor {
  Image iconSelect(String docs) {
    if (docs == "Listen") {
      return Image.asset(
        'assets/icons/headphones.png',
        width: 30,
      );
    } else if (docs == "Read") {
      return Image.asset(
        'assets/icons/books.png',
      );
    } else {
      return Image.asset(
        'assets/icons/television.png',
      );
    }
  }

// which = 0 -> icon  which = 1 -> color
  generateIconAndColor(String url, int which, String docs) {
    final Color netflixColor = Color(0xffFF7979);
    final Color spotifyColor = Color(0xff1DB954);
    final Color mediumColor = Color(0xffCECECE);
    final Color wattpadColor = Color(0xffFF7238);
    final Color redditColor = Color(0xffFF6D22);
    final Color bundleColor = Color(0xffABABAB);
    final Color udemyColor = Color(0xffF56A6A);
    final Color youtubeColor = Color(0xffffffff);
    final Color amazonColor = Color(0xff00A8E1);
    final Color soundcloudColor = Color(0xffCECECE);
    final Color storytelColor = Color(0xffeec7be);
    final Color fizyColor = Color(0xffFFDA28);

    List hosts = [
      'medium',
      'wattpad',
      'reddit',
      'bundlehaber',
      'spotify',
      'netflix',
      'udemy',
      'youtube',
      'primevideo',
      'soundcloud',
      'storytel',
      'fizy',
      'youtu.be'
    ];

    Map<String, List> websites = {
      hosts[0]: [
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Image.asset(
            'assets/icons/medium.png',
          ),
        ),
        mediumColor
      ],
      hosts[1]: [
        Padding(
          padding: const EdgeInsets.only(top: 3),
          child: Image.asset(
            'assets/icons/wattpad.png',
          ),
        ),
        wattpadColor
      ],
      hosts[2]: [
        Padding(
          padding: const EdgeInsets.only(top: 3),
          child: Image.asset(
            'assets/icons/reddit.png',
          ),
        ),
        redditColor
      ],
      hosts[3]: [
        Image.asset(
          'assets/icons/bundle.png',
          width: 40,
        ),
        bundleColor
      ],
      hosts[4]: [
        Padding(
          padding: EdgeInsets.only(top: 4),
          child: Image.asset(
            'assets/icons/spotify.png',
          ),
        ),
        spotifyColor
      ],
      hosts[5]: [
        Image.asset(
          'assets/icons/netflix.png',
          width: 40,
        ),
        netflixColor
      ],
      hosts[6]: [
        Padding(
          padding: EdgeInsets.only(top: 4),
          child: Image.asset(
            'assets/icons/udemy.png',
          ),
        ),
        udemyColor
      ],
      hosts[7]: [
        Padding(
          padding: EdgeInsets.only(top: 4),
          child: Image.asset(
            'assets/icons/youtube.png',
          ),
        ),
        youtubeColor
      ],
      hosts[8]: [
        Image.asset(
          'assets/icons/amazon.png',
          width: 40,
        ),
        amazonColor
      ],
      hosts[9]: [
        Image.asset(
          'assets/icons/soundcloud.png',
          width: 40,
        ),
        soundcloudColor
      ],
      hosts[10]: [
        Padding(
          padding: EdgeInsets.only(top: 2),
          child: Image.asset(
            'assets/icons/storytel.png',
            width: 40,
          ),
        ),
        storytelColor
      ],
      hosts[11]: [
        Padding(
          padding: EdgeInsets.only(top: 4),
          child: Image.asset(
            'assets/icons/fizy.png',
            width: 32,
          ),
        ),
        fizyColor
      ],
      hosts[12]: [
        Padding(
          padding: EdgeInsets.only(top: 4),
          child: Image.asset(
            'assets/icons/youtube.png',
          ),
        ),
        youtubeColor
      ],
    };
    var uri = Uri.parse(url);
    var hostName = uri.host.split('.')[uri.host.split('.').length - 2];
    if (hosts.contains(hostName)) {
      return websites[hostName][which];
    } else {
      if (which == 0) {
        return Padding(
          padding: const EdgeInsets.only(top: 4),
          child: iconSelect(docs),
        );
      } else {
        return AppThemeLight.instance.colorSchemeLight.defaultCard;
      }
    }
  }
}
