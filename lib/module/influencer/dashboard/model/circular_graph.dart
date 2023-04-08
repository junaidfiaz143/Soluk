import 'package:flutter/material.dart';

import '../../../../res/color.dart';
import '../../../../utils/app_colors.dart';

class CircularGraphModel {
  final String type;
  final int value;
  final Color color;

  CircularGraphModel(
      {required this.type, required this.value, required this.color});
}

late List<CircularGraphModel> circularGraphData;

getCircularGraphData({required int published, required int unPublished}) {
  if (published == 0 && unPublished == 0) {
    circularGraphData = [
      CircularGraphModel(type: '', value: 100, color: AppColors.silver),
    ];
  } else {
    circularGraphData = [
      CircularGraphModel(
          type: 'Published', value: published, color: PRIMARY_COLOR),
      CircularGraphModel(
          type: 'Unpublishded', value: unPublished, color: SECONDARY_COLOR),
    ];
  }
}
