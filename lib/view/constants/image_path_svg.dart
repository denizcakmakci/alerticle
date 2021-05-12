import '../../core/init/extensions/extensions.dart';

class SVGImagePaths {
  static SVGImagePaths _instace;
  static SVGImagePaths get instance {
    if (_instace == null) _instace = SVGImagePaths._init();
    return _instace;
  }

  SVGImagePaths._init();

  final calendarSVG = 'Calendar'.toSVG;
  final designSVG = 'design'.toSVG;
  final notificationSVG = 'Social_notification'.toSVG;
  final videoSVG = 'Video'.toSVG;
  final googleSVG = 'google'.toSVG;
  final flutterSVG = 'flutter'.toSVG;
}
