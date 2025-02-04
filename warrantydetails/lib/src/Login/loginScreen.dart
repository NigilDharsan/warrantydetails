import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:warrantydetails/src/Dashboard/Dashboard.dart';
import 'package:warrantydetails/src/Login/controller/login_controller.dart';
import 'package:warrantydetails/src/Login/warrantyRegistration.dart';
import 'package:warrantydetails/src/Login/widget/loginClipper.dart';
import 'package:warrantydetails/utils/Language/Language.dart';
import 'package:warrantydetails/widget/custom_snackbar.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  bool islogin = true;
  final _formKey = GlobalKey<FormState>();

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  Future<void> _changeLanguage(Language language) async {
    Locale locale = Locale(language.languageCode);
    await saveLocale(locale); // Save selected locale
    Get.updateLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red,
        resizeToAvoidBottomInset: true,
        body: GetBuilder<LoginController>(builder: (controller) {
          return MainUI(context, controller);
        }));
  }

  Widget MainUI(BuildContext context, LoginController controller) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 60),
              Row(
                children: [
                  SizedBox(width: 85),
                  Expanded(
                    child: Center(
                      // Center the welcome text
                      child: Text(
                        "welcome".tr,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 45),
                  Container(
                    width: 80,
                    height: 35,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: DropdownButton<Language>(
                        underline: const SizedBox(),
                        icon: const Icon(Icons.arrow_drop_down),
                        isExpanded: true,
                        hint: Text(
                          Language.languageList()
                              .firstWhere(
                                (test) =>
                                    test.languageCode ==
                                    (Get.locale?.languageCode ?? "en"),
                                orElse: () => Language(0, "", "", ""),
                              )
                              .name,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onChanged: (Language? language) {
                          if (language != null) {
                            _changeLanguage(language);
                          }
                        },
                        items: Language.languageList().map((lang) {
                          return DropdownMenuItem<Language>(
                            value: lang,
                            child: Text(lang.name),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.sizeOf(context).width,
                // height: 550,
                color: Colors.red,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 80),
                      Container(
                        height: 480,
                        margin: EdgeInsets.only(bottom: 20),
                        child: islogin
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  children: [
                                    ClipPath(
                                      clipper: SignupClipper(),
                                      child: Container(
                                        height: 500,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.92,
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.8)),
                                        child: Text(""),
                                      ),
                                    ),
                                    CustomPaint(
                                      painter: loginShadowPaint(),
                                      child: ClipPath(
                                        clipper: loginClipper(),
                                        child: Container(
                                          height: 500,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.92,
                                          decoration: BoxDecoration(
                                              color: Colors.white),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 45),
                                              Container(
                                                margin: EdgeInsets.all(40),
                                                child: GestureDetector(
                                                  onTap: () {},
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'message'.tr,
                                                        style:
                                                            GoogleFonts.roboto(
                                                          fontSize: 13,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      SizedBox(height: 5),
                                                      RichText(
                                                        text: TextSpan(
                                                          text:
                                                              'warranty_message'
                                                                  .tr,
                                                          style: GoogleFonts
                                                              .roboto(
                                                            fontSize: 12,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: MediaQuery.of(context).size.width *
                                          0.20,
                                      bottom: 30,
                                      child: Align(
                                        alignment: Alignment(0, 40),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 200,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(25)),
                                              ),
                                              child: MaterialButton(
                                                onPressed: () {
                                                  Get.to(() =>
                                                      const Warrantyregistration());
                                                },
                                                elevation: 2,
                                                child: Text(
                                                  'warranty'.tr,
                                                  style: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 20,
                                      right: 10,
                                      child: Align(
                                        alignment: Alignment(0, 40),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            MaterialButton(
                                              onPressed: () {
                                                if (islogin) {
                                                  setState(() {
                                                    islogin = false;
                                                  });
                                                } else {
                                                  setState(() {
                                                    islogin = true;
                                                  });
                                                }
                                              },
                                              elevation: 2,
                                              child: Text(
                                                'admin'.tr,
                                                style: GoogleFonts.roboto(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  children: [
                                    ClipPath(
                                      clipper: loginClipper(),
                                      child: Container(
                                        height: 500,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.92,
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.8)),
                                        child: Text(
                                          '',
                                        ),
                                      ),
                                    ),
                                    CustomPaint(
                                      painter: signupShadowPaint(),
                                      child: ClipPath(
                                        clipper: SignupClipper(),
                                        child: Container(
                                          height: 500,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.92,
                                          decoration: BoxDecoration(
                                              color: Colors.white),
                                          child: Form(
                                            key: _formKey,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(height: 150),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.7,
                                                  margin: const EdgeInsets.only(
                                                      left: 30),
                                                  height: 80,
                                                  child: TextFormField(
                                                    controller: controller
                                                        .signInEmailController,
                                                    decoration: InputDecoration(
                                                      icon: const Icon(
                                                          Icons.mail,
                                                          size: 24,
                                                          color: Colors.red),
                                                      labelText: 'email'.tr,
                                                      labelStyle:
                                                          GoogleFonts.lato(
                                                              fontSize: 16,
                                                              color: Colors
                                                                  .grey[500]),
                                                    ),
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'enter_email'
                                                            .tr; // Localized error
                                                      }
                                                      if (!isValidEmail(
                                                          value)) {
                                                        return 'valid_email'
                                                            .tr; // Localized error
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.7,
                                                  margin: const EdgeInsets.only(
                                                      left: 30),
                                                  height: 80,
                                                  child: TextFormField(
                                                    controller: controller
                                                        .signInPasswordController,
                                                    obscureText: true,
                                                    decoration: InputDecoration(
                                                      icon: const Icon(
                                                          Icons.lock,
                                                          size: 24,
                                                          color: Colors.red),
                                                      labelText: "password".tr,
                                                      labelStyle:
                                                          GoogleFonts.lato(
                                                              fontSize: 16,
                                                              color: Colors
                                                                  .grey[500]),
                                                    ),
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return "Enter Your Password";
                                                      }
                                                      if (value.length < 6) {
                                                        return "Password must be at least 6 characters";
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
// Login button
                                    Positioned(
                                      left: MediaQuery.of(context).size.width *
                                          0.31,
                                      bottom: 20,
                                      child: Align(
                                        alignment: Alignment(0, 40),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 150,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(25)),
                                              ),
                                              child: MaterialButton(
                                                onPressed: () async {
                                                  if (_formKey.currentState
                                                          ?.validate() ??
                                                      false) {
                                                    await controller.login();
                                                    if (controller.loginModel
                                                            ?.status ==
                                                        "200_OK") {
                                                      customSnackBar(
                                                          controller.loginModel
                                                              ?.message,
                                                          isError: true);
                                                      Get.offAll(() =>
                                                          const Dashboard());
                                                    } else {
                                                      customSnackBar(
                                                          'Invalid email or password',
                                                          isError: true);
                                                    }
                                                  } else {}
                                                },
                                                elevation: 2,
                                                child: Text(
                                                  "login".tr,
                                                  style: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 13,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 18,
                                      left: -12,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            MaterialButton(
                                              onPressed: () {
                                                if (islogin) {
                                                  setState(() {
                                                    islogin = false;
                                                  });
                                                } else {
                                                  setState(() {
                                                    islogin = true;
                                                  });
                                                }
                                              },
                                              elevation: 2,
                                              child: Text(
                                                'customer'.tr,
                                                style: GoogleFonts.roboto(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
