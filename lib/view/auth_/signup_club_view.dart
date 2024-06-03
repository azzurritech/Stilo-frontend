import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wanna_play_app/controller/auth_controller.dart';
import 'package:flutter_wanna_play_app/utils/extensions.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../helper/basehelper.dart';
import '../../utils/constant/button_text_style.dart';
import '../../utils/constant/colors.dart';
import '../../utils/constant/heading_text_style.dart';
import '../../utils/constant/image_path.dart';
import '../../utils/validators.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/button_widgets.dart';
import '../../widgets/chechk_listTile_widget.dart';
import '../../widgets/circle_widget.dart';
import '../../widgets/dialog_box_widget.dart';
import '../../widgets/google_places_location_widget.dart';
import '../../widgets/textfield_widget.dart';

class SignupClubView extends StatefulWidget {
  const SignupClubView({super.key});

  @override
  State<SignupClubView> createState() => _SignupClubViewState();
}

class _SignupClubViewState extends State<SignupClubView> {
  bool updated = false;
  bool privacyCheck = false;
  bool barCheck = false;
  bool spogliatoiCheck = false;
  bool venditaPallineCheck = false;
  bool negozioInternoCheck = false;
  bool servizioIncordaturaCheck = false;
  bool ristoranteCheck = false;
  List seviziList = [];
  List campi = [];
  bool playIt = false;
  bool cemento = false;
  bool terra = false;
  bool erba = false;
  bool luci = false;
  bool riscldamento = false;
  bool coperto = false;
  bool scoperto = false;
  String? imageUrl;
  String? genderRadio;
  bool obsecureVar = true;
  String rankingRadio = "Si";
  String federationRank = '';
  late GlobalKey<FormState> formKey;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  late TextEditingController cityController;

  // TextEditingController? phoneNumberController;

  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();

    cityController = TextEditingController();

    // phoneNumberController = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    formKey.currentState?.reset();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    cityController.dispose();

    // phoneNumberController?.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        BaseHelper.hideKeypad(context);
        bool? shouldPop;
        if (updated == true) {
          shouldPop = await showDialog(
              context: context,
              builder: (context) => customDialogBox(context, onCancel: () {
                    Navigator.of(context).pop(false);
                  }, onOk: () {
                    Navigator.of(context).pop(true);
                  }));
        } else {
          shouldPop = true;
        }
        return Future.value(shouldPop);
      },
      child: Scaffold(
        appBar: AppBarWidget(
          background: Colors.transparent,
          title: '${context.loc.signUp} ${context.loc.club}',
        ),
        body: SingleChildScrollView(
          padding:
              const EdgeInsets.only(left: 30, right: 30, top: 80, bottom: 20),
          child: SizedBox(
            width: double.infinity,
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CustomCircleAvatar(
                        radius: 60,
                        images: AppAssets.loginlogo,
                        imageUrl: imageUrl,
                      ),
                      Positioned(
                        top: 80,
                        left: 85,
                        child: Container(
                          width: 35,
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                              shape: BoxShape.circle),
                          child: IconButton(
                              onPressed: () async {
                                String? downloadableLink;
                                File? imageVar =
                                    await BaseHelper.imagePickerSheet(context);

                                if (imageVar != null) {
                                  await Auth.uploadImage(
                                    imageVar,
                                    context,
                                  ).then((value) => downloadableLink = value);
                                }
                                setState(() {
                                  imageUrl = downloadableLink;
                                  updated = true;
                                });
                              },
                              icon: const Icon(
                                Icons.camera_alt,
                                color: Colors.grey,
                                size: 18,
                              )),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40, bottom: 10),
                    child: TextFields(
                      text: context.loc.firstNameLastName,
                      controller: nameController,
                      onChanged: (va) {
                        if (va.toString().isNotEmpty) {
                          updated = true;
                        } else {
                          updated = false;
                        }
                      },
                      validator: (p0) => Validators.validateField(p0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: TextFields(
                      text: context.loc.email,
                      controller: emailController,
                      onChanged: (va) {
                        if (va.toString().isNotEmpty) {
                          updated = true;
                        } else {
                          updated = false;
                        }
                      },
                      validator: (p0) => Validators.validateEmail(p0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: TextFields(
                      text: context.loc.password,
                      controller: passwordController,
                      obsecureText: obsecureVar,
                      onChanged: (va) {
                        if (va.toString().isNotEmpty) {
                          updated = true;
                        } else {
                          updated = false;
                        }
                      },
                      validator: (p0) => Validators.validatePassword(p0),
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
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: customPhoneField(
                        context,
                        onChanged: (phoneNumber) {
                          Auth.phoneNumberController.text =
                              phoneNumber.completeNumber;
                        },
                        validator: (value) =>
                            Validators.validatePhoneNumber(value),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: TextFields(
                      text: context.loc.address,
                      controller: cityController,
                      readOnly: true,
                      onTap: () async {
                        await GooglePlaces.googlePlaccesLoc(context)
                            .then((value) {
                          if (value != "null") {
                            cityController.text = value.toString();
                            updated = true;
                            return;
                          }
                          updated = false;
                        });
                      },
                      validator: (p0) => Validators.validateField(p0),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Theme(
                          data: Theme.of(context)
                              .copyWith(dividerColor: Colors.transparent),
                          child: Container(
                            color: AppColor.textfield_color,
                            child: ExpansionTile(
                              title: seviziList.isNotEmpty
                                  ? Wrap(
                                      children: seviziList.map((e) {
                                        return Text(
                                          "${e.toString()}, ",
                                          style: subTitle16BlackStyle,
                                        );
                                      }).toList(),
                                    )
                                  : Text(
                                      "Sevizi",
                                      style: hint_text,
                                    ),
                              children: [
                                Container(
                                  height: 15,
                                  color: Colors.white,
                                ),
                                checkListTile(
                                  checkValue: barCheck,
                                  titleText: 'Bar',
                                  onChanged: (p0) {
                                    barCheck = p0!;
                                    if (barCheck == true) {
                                      updated = true;
                                      seviziList.add('Bar');
                                    } else {
                                      seviziList.remove('Bar');
                                    }
                                    setState(() {});
                                  },
                                ),
                                checkListTile(
                                  checkValue: spogliatoiCheck,
                                  titleText: 'Spogliatoi',
                                  onChanged: (p0) {
                                    spogliatoiCheck = p0!;
                                    if (spogliatoiCheck == true) {
                                      updated = true;
                                      seviziList.add('Spogliatoi');
                                    } else {
                                      seviziList.remove('Spogliatoi');
                                    }
                                    setState(() {});
                                  },
                                ),
                                checkListTile(
                                  checkValue: venditaPallineCheck,
                                  titleText: 'Vendita Palline',
                                  onChanged: (p0) {
                                    venditaPallineCheck = p0!;
                                    if (venditaPallineCheck == true) {
                                      updated = true;
                                      seviziList.add('Vendita Palline');
                                    } else {
                                      seviziList.remove('Vendita Palline');
                                    }
                                    setState(() {});
                                  },
                                ),
                                checkListTile(
                                  checkValue: negozioInternoCheck,
                                  titleText: 'Negozio Interno',
                                  onChanged: (p0) {
                                    negozioInternoCheck = p0!;
                                    if (negozioInternoCheck == true) {
                                      updated = true;
                                      seviziList.add('Negozio Interno');
                                    } else {
                                      seviziList.remove('Negozio Interno');
                                    }
                                    setState(() {});
                                  },
                                ),
                                checkListTile(
                                  checkValue: servizioIncordaturaCheck,
                                  titleText: 'Servizio Incordatura',
                                  onChanged: (p0) {
                                    servizioIncordaturaCheck = p0!;
                                    if (servizioIncordaturaCheck == true) {
                                      updated = true;
                                      seviziList.add('Servizio Incordatura');
                                    } else {
                                      seviziList.remove('Servizio Incordatura');
                                    }
                                    setState(() {});
                                  },
                                ),
                                checkListTile(
                                  checkValue: ristoranteCheck,
                                  titleText: 'Ristorante',
                                  onChanged: (p0) {
                                    ristoranteCheck = p0!;
                                    if (ristoranteCheck == true) {
                                      seviziList.add('Ristorante');
                                      updated = true;
                                    } else {
                                      seviziList.remove('Ristorante');
                                    }
                                    setState(() {});
                                  },
                                )
                              ],
                            ),
                          ))),
                  Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Theme(
                          data: Theme.of(context)
                              .copyWith(dividerColor: Colors.transparent),
                          child: Container(
                            color: AppColor.textfield_color,
                            child: ExpansionTile(
                              title: campi.isNotEmpty
                                  ? Wrap(
                                      children: campi.map((e) {
                                        return Text(
                                          "${e.toString()}, ",
                                          style: subTitle16BlackStyle,
                                        );
                                      }).toList(),
                                    )
                                  : Text(
                                      "Campi",
                                      style: hint_text,
                                    ),
                              children: [
                                Container(
                                  height: 15,
                                  color: Colors.white,
                                ),
                                checkListTile(
                                  checkValue: playIt,
                                  titleText: 'Play it',
                                  onChanged: (p0) {
                                    playIt = p0!;
                                    if (playIt == true) {
                                      updated = true;
                                      campi.add('Play it');
                                    } else {
                                      campi.remove('Play it');
                                    }
                                    setState(() {});
                                  },
                                ),
                                checkListTile(
                                  checkValue: cemento,
                                  titleText: 'Cemento',
                                  onChanged: (p0) {
                                    cemento = p0!;
                                    if (cemento == true) {
                                      updated = true;
                                      campi.add('Cemento');
                                    } else {
                                      campi.remove('Cemento');
                                    }
                                    setState(() {});
                                  },
                                ),
                                checkListTile(
                                  checkValue: terra,
                                  titleText: 'Terra',
                                  onChanged: (p0) {
                                    terra = p0!;
                                    if (terra == true) {
                                      updated = true;
                                      campi.add('Terra');
                                    } else {
                                      campi.remove('Terra');
                                    }
                                    setState(() {});
                                  },
                                ),
                                checkListTile(
                                  checkValue: erba,
                                  titleText: 'Erba',
                                  onChanged: (p0) {
                                    erba = p0!;
                                    if (erba == true) {
                                      updated = true;
                                      campi.add('Erba');
                                    } else {
                                      campi.remove('Erba');
                                    }
                                    setState(() {});
                                  },
                                ),
                                checkListTile(
                                  checkValue: luci,
                                  titleText: 'Luci',
                                  onChanged: (p0) {
                                    luci = p0!;
                                    if (luci == true) {
                                      updated = true;
                                      campi.add('Luci');
                                    } else {
                                      campi.remove('Luci');
                                    }
                                    setState(() {});
                                  },
                                ),
                                checkListTile(
                                  checkValue: riscldamento,
                                  titleText: 'Riscldamento',
                                  onChanged: (p0) {
                                    riscldamento = p0!;
                                    if (riscldamento == true) {
                                      updated = true;
                                      campi.add('Riscldamento');
                                    } else {
                                      campi.remove('Riscldamento');
                                    }
                                    setState(() {});
                                  },
                                ),
                                checkListTile(
                                  checkValue: coperto,
                                  titleText: 'Coperto',
                                  onChanged: (p0) {
                                    coperto = p0!;
                                    if (coperto == true) {
                                      updated = true;
                                      campi.add('Coperto');
                                    } else {
                                      campi.remove('Coperto');
                                    }
                                    setState(() {});
                                  },
                                ),
                                checkListTile(
                                  checkValue: scoperto,
                                  titleText: 'Scoperto',
                                  onChanged: (p0) {
                                    scoperto = p0!;
                                    if (scoperto == true) {
                                      updated = true;
                                      campi.add('Scoperto');
                                    } else {
                                      campi.remove('Scoperto');
                                    }
                                    setState(() {});
                                  },
                                )
                              ],
                            ),
                          ))),
                  const SizedBox(
                    height: 53,
                  ),
                  CustomButton(
                      color: AppColor.divivdercolor,
                      height: height * 0.06,
                      width: width * 0.8,
                      text: 'Register',
                      style: subTitle16DarkGreyStyle.copyWith(fontSize: 22),
                      onpressed: () {
                        if (formKey.currentState!.validate()) {
                          Auth.signUpCircolo(context,
                              city: cityController.text,
                              servizList: seviziList,
                              campiList: campi,
                              email: emailController.text.toLowerCase().trim(),
                              imageUrl: imageUrl.toString(),
                              name: nameController.text,
                              password: passwordController.text.trim(),
                              phoneNumber: Auth.phoneNumberController.text);
                        } else {
                          return;
                        }
                      }),
                  const SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget phoneField(context) {
  //   return customPhoneField(
  //     context,
  //     controller: phoneNumberController,
  //     onChanged: (phoneNumber) {
  //       setState(() {
  //         phoneNumberController?.text = phoneNumber.number;
  //       });
  //     },
  //     validator: (value) {
  //       if (value == null || value.isEmpty) {
  //         return 'Please enter Phone Number';
  //       }

  //       return null;
  //     },
  //   );
  // }
  Widget customPhoneField(
    context, {
    Function? onPressed,
    var labelText,
    final FormFieldSetter<String>? onSaved,
    final String? hintText,
    final bool obscureText = false,
    final FormFieldValidator<String>? validator,
    final keyboardType,
    var textInputAction = TextInputAction.next,
    final border,
    final minLines,
    final controller,
    final maxLines,
    final bool enabled = true,
    final onChanged,
    final onSave,
    final onSubmit,
    var prefix,
    var prefixText,
    var maxLength,
    final focusNode,
  }) {
    return IntlPhoneField(
      controller: controller,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
      ],
      decoration: InputDecoration(
        hintText: "Phone number",
        hintStyle: hint_text,
        filled: true,
        fillColor: AppColor.textfield_color,
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            )),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.done,
      initialCountryCode: 'PK',
      showCountryFlag: true,
      disableLengthCheck: false,
      invalidNumberMessage: 'invalid_mobile_number',

      showDropdownIcon: true,
      dropdownIconPosition: IconPosition.leading,
      autofocus: false,
      obscureText: obscureText,

      // maxLines: maxLines,

      dropdownIcon: const Icon(Icons.keyboard_arrow_down,
          color: AppColor.textfield_color),
      onChanged: onChanged,
      onSaved: onSave,
      onSubmitted: onSubmit,
    );
  }
}
