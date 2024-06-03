import 'package:flutter/material.dart';


import '../../utils/constant/heading_text_style.dart';
import '../../utils/constant/image_path.dart';
import '../../view/auth_/login_view.dart';
import '../../widgets/button_widgets.dart';
import '../../widgets/custom_sized_box_widget.dart';
import '../../widgets/textfield_widget.dart';


class NewPassword extends StatelessWidget {
  const NewPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover, image: AssetImage(AppAssets.spalsh)),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomSizedBox(
                height: height * 0.15,
              ),
              Image.asset(AppAssets.spalshicon),
              CustomSizedBox(
                height: height * 0.04,
              ),
              Text(
                "Recover Password",
                style: heading22BlackStyle,
              ),
              CustomSizedBox(
                height: height * 0.9,
              ),
              TextFields(
                height: height * 0.06,
                width: width * 0.7,
                text: 'New Password',
              ),
              CustomSizedBox(
                height: height * 0.03,
              ),
              TextFields(
                height: height * 0.06,
                width: width * 0.7,
                text: 'Repeat ',
              ),
              CustomSizedBox(
                height: height * 0.06,
              ),
              CustomButton(
                height: height * 0.06,
                width: width * 0.65,
                text: "Confirm",
                onpressed: () {
                  Navigator.of(context).push(
                      (MaterialPageRoute(builder: (context) => const LoginView())));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
