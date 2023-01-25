
import 'package:bye_bye_cry_new/compoment/shared/custom_text.dart';
import 'package:bye_bye_cry_new/compoment/shared/screen_size.dart';
import 'package:bye_bye_cry_new/screens/authentication/sign_up/sign_up.dart';
import 'package:flutter/material.dart';
import '../../../compoment/shared/custom_input.dart';
import '../../../compoment/shared/outline_button.dart';
import '../../../compoment/utils/color_utils.dart';
import '../../../start_page.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
                              'Sign in with your email',
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
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                //forgot password screen
                              },
                              child: const Text('Forgot Password ?',),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignUp()));
                              },
                              child:const CustomText(text: 'Sign Up',color: primaryPinkColor,),
                            ),
                          ],
                        ),

                        Container(
                          padding: const EdgeInsets.all(10),
                          child: OutLineButton(text: 'Sign In',
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const StartPage()));
                            },
                            height: 50,
                            width: double.infinity,
                            textFontWeight: FontWeight.w700,
                            textFontSize: 20,),
                        ),
                        SizedBox(height: 20,),
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



/*
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }


  void _authenticate() async {
    if(_formKey.currentState!.validate()) {
      final email = emailController.text;
      final password = passwordController.text;
      try {
        final status = await AuthService.login(email, password);

      } on FirebaseAuthException catch (error) {
        setState(() {
          _errMsg = error.message!;
        });
      }
    }
  }
}
*/

