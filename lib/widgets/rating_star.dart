import 'package:flutter/animation.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

import '../utils/constant/colors.dart';

class CustomRating extends StatefulWidget {
  CustomRating({super.key, this.valueLabelColor, required this.value});
  double? value;
  Color? valueLabelColor;
  @override
  State<CustomRating> createState() => _CustomRatingState();
}

class _CustomRatingState extends State<CustomRating> {
  @override
  Widget build(BuildContext context) {
    return RatingStars(
      starColor: AppColor.starcolor,
      value: widget.value ?? 0,
      valueLabelColor: widget.valueLabelColor ?? const Color(0xff9b9b9b),
      onValueChanged: (valu) {
        setState(() {
          widget.value = valu;
        });
      },
    );
  }
}
