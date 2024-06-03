import 'package:flutter/material.dart';
import 'package:flutter_wanna_play_app/utils/extensions.dart';


import '../../controller/auth_controller.dart';
import '../../utils/constant/colors.dart';
import '../../utils/constant/heading_text_style.dart';
import '../../utils/constant/image_path.dart';
import '../../utils/validators.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/button_widgets.dart';
import '../../widgets/textfield_widget.dart';
import 'recover_password.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool obsecureVar = true;
  late GlobalKey<FormState> formKey;

  late TextEditingController emailController;
  late TextEditingController passwordController;
  @override
  void initState() {
    formKey = GlobalKey<FormState>();

    emailController = TextEditingController();
    passwordController = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    formKey.currentState?.reset();
    emailController.dispose();
    passwordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBarWidget(
          background: Colors.transparent,
          title:context.loc.logIn,
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 40, right: 40),
          decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage(AppAssets.spalsh)),
          ),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                    height: MediaQuery.of(context).viewInsets.bottom > 100
                        ? height * 0.04
                        : height * 0.019),
                SizedBox(
                    height: MediaQuery.of(context).viewInsets.bottom > 100
                        ? height * 0.1
                        : height * 0.3,
                    width: MediaQuery.of(context).viewInsets.bottom > 100
                        ? height * 0.1
                        : height * 0.4,
                    child: Image.asset(AppAssets.spalshicon)),
                SizedBox(
                  height: MediaQuery.of(context).viewInsets.bottom > 100
                      ? height * 0.04
                      : height * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: TextFields(
                    controller: emailController,
                    validator: (p0) => Validators.validateEmail(p0),
                    text:context.loc.email,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  child: TextFields(
                    controller: passwordController,
                    validator: (p0) => Validators.validatePassword(p0),
                    obsecureText: obsecureVar,
                    suffixicon: IconButton(
                      onPressed: () {
                        setState(() {
                          obsecureVar = !obsecureVar;
                        });
                      },
                      icon: Icon(
                          obsecureVar
                              ? Icons.visibility_off_rounded
                              : Icons.remove_red_eye,
                          size: 16),
                    ),
                    text:context.loc.password,
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                CustomButton(
                  style: subTitle16lightGreenstyle,
                  height: height * 0.06,
                  width: width * 0.8,
                  text: context.loc.logIn,
                  onpressed: () {
                    if (formKey.currentState!.validate()) {
                      Auth.logInAuth(context,
                          email: emailController.text,
                          password: passwordController.text);
                    } else {
                      return;
                    }
                    // Navigator.of(context).push((MaterialPageRoute(
                    //     builder: (context) => const ProfileGecatore())));
                  },
                ),
                const Spacer(),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push((MaterialPageRoute(
                          builder: (context) => const RecoverPassword())));
                    },
                    child:  Text(
                      context.loc.forgotPassword,
                      style: const TextStyle(color: AppColor.maincolor),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
