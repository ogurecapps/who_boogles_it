import 'package:flutter_svg/flutter_svg.dart';
import 'package:multiavatar/multiavatar.dart';

class AvatarGenerator {
  final String _nickname;
  final double _width;
  final double _height;

  AvatarGenerator(this._nickname, this._width, this._height);

  Future<SvgPicture> generate() async {
    return SvgPicture.string(
      multiavatar(_nickname),
      width: _width,
      height: _height,
    );
  }
}
