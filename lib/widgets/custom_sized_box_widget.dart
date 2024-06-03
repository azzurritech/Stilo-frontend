import 'package:flutter/cupertino.dart';

class CustomSizedBox extends StatelessWidget {
  double? height;
  double? width;
  CustomSizedBox({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SizedBox(
        height: height ?? 0,
        width: width ?? 0,
      ),
    );
  }
}
