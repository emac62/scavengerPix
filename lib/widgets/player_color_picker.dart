import 'package:flutter/material.dart';

import 'package:scavenger_hunt_pictures/widgets/app_colors.dart';
import 'package:scavenger_hunt_pictures/widgets/font_sizes.dart';
import 'package:scavenger_hunt_pictures/widgets/size_config.dart';

class PlayerColorPicker extends StatefulWidget {
  final Function
      onSelectColor; // This function sends the selected color to outside
  final List<Color> availableColors; // List of pickable colors
  final Color initialColor; // The default picked color
  final bool circleItem;
  final String player; // Determnie shapes of color cells

  const PlayerColorPicker(
      {Key? key,
      required this.onSelectColor,
      required this.availableColors,
      required this.initialColor,
      required this.player,
      this.circleItem = true})
      : super(key: key);

  @override
  PlayerColorPickerState createState() => PlayerColorPickerState();
}

class PlayerColorPickerState extends State<PlayerColorPicker> {
  // This variable used to determine where the checkmark will be
  Color? _pickedColor;

  @override
  void initState() {
    _pickedColor = widget.initialColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.transparent)),
      width: double.infinity,
      height: getHeadingFontSize(),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: SizeConfig.blockSizeHorizontal * 8,
            childAspectRatio: SizeConfig.isPhone ? 5 / 4 : 2 / 1,
            crossAxisSpacing: SizeConfig.blockSizeHorizontal * 1,
            mainAxisSpacing: SizeConfig.blockSizeHorizontal * 1),
        shrinkWrap: true,
        itemCount: widget.availableColors.length,
        itemBuilder: (context, index) {
          final itemColor = widget.availableColors[index];
          return InkWell(
            onTap: () {
              widget.onSelectColor(itemColor);

              setState(() {
                _pickedColor = itemColor;
              });
            },
            child: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                  color: itemColor,
                  shape: widget.circleItem == true
                      ? BoxShape.circle
                      : BoxShape.rectangle,
                  border: Border.all(width: 2, color: AppColor.textColor)),
              child: itemColor == _pickedColor
                  ? Center(
                      child: Icon(
                        Icons.check,
                        color: AppColor.textColor,
                        size: getInfoFontSize(),
                      ),
                    )
                  : Container(),
            ),
          );
        },
      ),
    );
  }
}
