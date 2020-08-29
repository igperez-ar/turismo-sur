import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum ProfileImageSize {
  small,
  medium,
  big,
  large
}

class ProfileImage extends StatelessWidget {

  final String image;
  final bool group;
  final ProfileImageSize size;

  const ProfileImage({
    Key key,
    @required this.image,
    @required this.size,
    this.group = false,
  }) : super(key: key);

  double _iconSize() {
    switch (size) {
      case ProfileImageSize.small:
        return 40;
        break;
      case ProfileImageSize.medium:
        return 55;
        break;
      case ProfileImageSize.big:
        return 95;
        break;
      case ProfileImageSize.large:
        return 145;
        break;
    }
  }

  double _widgetSize() {
    switch (size) {
      case ProfileImageSize.small:
        return 40;
        break;
      case ProfileImageSize.medium:
        return 60;
        break;
      case ProfileImageSize.big:
        return 100;
        break;
      case ProfileImageSize.large:
        return 150;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final _wSize = _widgetSize();
    final _iSize = _iconSize();

    /* Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[400]
              ),
              child: Icon(
                Icons.people,
                color: Colors.white,
              ),
            ), */

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[400],
        border: Border.all(color: Colors.grey, width: 2)
      ),
      child: (image != null
        ? SvgPicture.asset(
            'assets/profile_pics/pic_$image.svg',
            height: _wSize,
            width: _wSize,
          )
        : Container(
          width: _wSize,
          height: _wSize,
          child: Icon((group 
              ? Icons.people
              : Icons.account_circle
            ),
            color: Colors.white,
            size: _iSize - (group ? 20 : 0),
          )
        )
      )
    );
  }
}