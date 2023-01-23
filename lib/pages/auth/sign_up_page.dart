import 'package:first_online_shopping_app/base/custom_loader.dart';
import 'package:first_online_shopping_app/base/show_custom_snackbar.dart';
import 'package:first_online_shopping_app/controller/auth_controller.dart';
import 'package:first_online_shopping_app/model/signup_body_model.dart';
import 'package:first_online_shopping_app/routes/route_helper.dart';
import 'package:first_online_shopping_app/utils/colors.dart';
import 'package:first_online_shopping_app/utils/dimensions.dart';
import 'package:first_online_shopping_app/widgets/app_text_field.dart';
import 'package:first_online_shopping_app/widgets/big_text.dart';
import 'package:flutter/gestures.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImages = ["t.png", "f.png", "g.png"];
    void _registration(AuthController authController) {
      var authController = Get.find<AuthController>();
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      if (name.isEmpty) {
        showCustomSnackBar("Type in your name", title: "Name");
      } else if (phone.isEmpty) {
        showCustomSnackBar("Type in your number", title: "Phone number");
      } else if (email.isEmpty) {
        showCustomSnackBar("Type in Email address", title: "Email address");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("Type in a valid email address",
            title: "Valid email address");
      } else if (password.isEmpty) {
        showCustomSnackBar("Type in your password", title: "Password");
      } else if (password.length < 6) {
        showCustomSnackBar("Password can not be greater than six character",
            title: "Password");
      } else {
        showCustomSnackBar("All went well", title: "Perfect");
        SignUpBody signUpBody = SignUpBody(
            name: name, phone: phone, email: email, password: password);
        print(signUpBody.toString());
        authController.registration(signUpBody).then((status) {
          if (status.isSuccess) {
            print("Success Registration");
            Get.offNamed(RouteHelper.getInitial());
          } else {
            print(status.message);
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(
          builder: (_authController) {
            return !_authController.isLoading
                ? SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(
                          height: Dimensions.screenHeight * 0.05,
                        ),
                        //app logo
                        Container(
                          height: Dimensions.screenHeight * 0.2,
                          child: const Center(
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 80,
                              backgroundImage:
                                  AssetImage("assets/images/logo part 1.png"),
                            ),
                          ),
                        ),
                        // your email
                        AppTextField(
                            textController: emailController,
                            hintText: "Email",
                            icon: Icons.email),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        // your password
                        AppTextField(
                          textController: passwordController,
                          hintText: "Password",
                          icon: Icons.password_sharp,
                          isObscure: true,
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        // your name
                        AppTextField(
                            textController: nameController,
                            hintText: "Name",
                            icon: Icons.person),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        // your phone
                        AppTextField(
                            textController: phoneController,
                            hintText: "Phone",
                            icon: Icons.phone),
                        SizedBox(
                          height: Dimensions.height20 * 2,
                        ),
                        // sign up button
                        GestureDetector(
                          onTap: () {
                            _registration(_authController);
                          },
                          child: Container(
                            width: Dimensions.screenWidth / 2,
                            height: Dimensions.screenHeight / 13,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius30),
                              color: AppColors.mainColor,
                            ),
                            child: Center(
                              child: BigText(
                                text: "Sign Up",
                                size: Dimensions.font20 + Dimensions.font20 / 2,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        // tag line
                        RichText(
                          text: TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = (() => Get.back()),
                              text: "Have an account already?",
                              style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: Dimensions.font20)),
                        ),
                        SizedBox(
                          height: Dimensions.screenHeight * 0.05,
                        ),
                        // sign up options
                        RichText(
                          text: TextSpan(
                              text:
                                  "Sign up using one of the following methods ",
                              style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: Dimensions.font20)),
                        ),
                        Wrap(
                          children: List.generate(
                              3,
                              (index) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      radius: Dimensions.radius30,
                                      backgroundImage: AssetImage(
                                          "assets/images/${signUpImages[index]}"),
                                    ),
                                  )),
                        )
                      ],
                    ),
                  )
                : const CustomLoader();
          },
        ));
  }
}
