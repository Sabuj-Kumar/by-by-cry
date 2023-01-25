import 'package:bye_bye_cry_new/start_page.dart';
import 'package:flutter/material.dart';

import '../../../compoment/shared/custom_input.dart';
import '../../../compoment/shared/custom_text.dart';
import '../../../compoment/shared/outline_button.dart';
import '../../../compoment/shared/screen_size.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String _errMsg = '';
  @override
  Widget build(BuildContext context) {
      final width = ScreenSize(context).width;
      final height = ScreenSize(context).height;
      return Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              height: height,
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: [
                          SizedBox(height: width * .2,),
                          Container(
                              alignment: Alignment.center,
                              child: Text(
                                'Sign Up with your email',
                                style: TextStyle(fontSize: 30,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black.withOpacity(0.7)),
                              )),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: CustomText(text: "Your Email",
                                fontWeight: FontWeight.w600,
                                color: Colors.black.withOpacity(0.7)),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: CustomTextInputField(
                              textEditingController: emailController,
                              hintText: "email",
                              borderRadius: 10,),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: CustomText(text: "Your Password",
                                fontWeight: FontWeight.w600,
                                color: Colors.black.withOpacity(0.7)),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: CustomTextInputField(
                              textEditingController: passwordController,
                              hintText: "password",
                              borderRadius: 10,),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: CustomText(text: "Confirm Password",
                                fontWeight: FontWeight.w600,
                                color: Colors.black.withOpacity(0.7)),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: CustomTextInputField(
                              textEditingController: confirmPasswordController,
                              hintText: "password",
                              borderRadius: 10,),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: OutLineButton(text: 'Sign Up',
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const StartPage()));
                              },
                              height: 50,
                              width: double.infinity,
                              textFontWeight: FontWeight.w700,
                              textFontSize: 20,),
                          ),
                          const SizedBox(height: 20,),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
      );
    }
  }

