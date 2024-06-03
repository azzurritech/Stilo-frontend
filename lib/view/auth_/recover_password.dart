import 'package:flutter/material.dart';
import 'package:flutter_wanna_play_app/utils/extensions.dart';

import '../../controller/auth_controller.dart';
import '../../utils/constant/heading_text_style.dart';
import '../../utils/constant/image_path.dart';
import '../../utils/validators.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/button_widgets.dart';
import '../../widgets/custom_sized_box_widget.dart';
import '../../widgets/textfield_widget.dart';

class RecoverPassword extends StatefulWidget {
  const RecoverPassword({super.key});

  @override
  State<RecoverPassword> createState() => _RecoverPasswordState();
}

class _RecoverPasswordState extends State<RecoverPassword> {
  late GlobalKey<FormState> formKey;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  @override
  void initState() {
    formKey = GlobalKey<FormState>();

    emailController = TextEditingController();

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    formKey.currentState?.reset();

    emailController.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarWidget(
          title: "", background: Colors.transparent.withOpacity(0)),
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
              SizedBox(
                  height: MediaQuery.of(context).viewInsets.bottom > 100
                      ? height * 0.04
                      : height * 0.01),
              SizedBox(
                  height: MediaQuery.of(context).viewInsets.bottom > 100
                      ? height * 0.2
                      : height * 0.4,
                  width: MediaQuery.of(context).viewInsets.bottom > 100
                      ? height * 0.2
                      : height * 0.4,
                  child: Image.asset(AppAssets.spalshicon)),
              CustomSizedBox(
                height: height * 0.01,
              ),
              Text(
                "Recover Password",
                style: heading22BlackStyle,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 40, left: 20, right: 20),
                child: Form(
                  key: formKey,
                  child: TextFields(
                    validator: (p0) => Validators.validateEmail(p0),
                    controller: emailController,
                    text: context.loc.email,
                  ),
                ),
              ),
              CustomButton(
                style: subTitle16lightGreenstyle,
                height: height * 0.05,
                width: width * 0.8,
                text: "Confirm",
                onpressed: () {
                  if (formKey.currentState!.validate()) {
                    Auth.forgetPassword(context, email: emailController.text);
                  } else {
                    return;
                  }

                  // Navigator.of(context).push(
                  //     (MaterialPageRoute(builder: (context) => NewPassword())));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
