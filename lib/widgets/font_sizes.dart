import 'size_config.dart';

getHeadingFontSize() {
  double fontSize = SizeConfig.isPhone
      ? SizeConfig.blockSizeVertical * 6
      : SizeConfig.isPort
          ? SizeConfig.blockSizeVertical * 4
          : SizeConfig.blockSizeVertical * 5.5;
  return fontSize;
}

getInfoFontSize() {
  double fontSize = SizeConfig.isPhone
      ? SizeConfig.blockSizeVertical * 4
      : SizeConfig.isPort
          ? SizeConfig.blockSizeVertical * 2
          : SizeConfig.blockSizeVertical * 3.5;
  return fontSize;
}
