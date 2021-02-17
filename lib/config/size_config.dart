import 'package:flutter/cupertino.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }

  double getBlockSizeVertical(double size) {
//    print(blockSizeVertical * size);
    return blockSizeVertical * size;
  }

  double getBlockSizeHorizontal(double size) {
//    print(blockSizeHorizontal * size);
    return blockSizeHorizontal * size;
  }
}
