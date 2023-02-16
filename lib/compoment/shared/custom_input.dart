import 'package:bye_bye_cry_new/compoment/shared/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextInputField extends StatefulWidget {

  final TextEditingController textEditingController;
  final TextInputType? keyboardType;
  final bool obscure;
  final String? Function(String?)? validator;
  final int maxLine;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final String? hintText;
  final Color? cursorColor;
  final double? hintFontSize;
  final FontWeight? hintFontWeight;
  final Color? hintColor;
  final int? hintMaxLine;
  final bool readOnly;
  final Color borderColor;
  final double borderRadius;
  const CustomTextInputField({
    Key? key,
    required this.textEditingController,
    this.keyboardType,
    this.validator,
    this.maxLine = 1,
    this.textInputAction,
    this.maxLength,
    this.hintText,
    this.obscure = false,
    this.cursorColor,
    this.hintFontSize,
    this.hintFontWeight,
    this.hintColor,
    this.hintMaxLine,
    this.readOnly = false,
    this.borderColor = Colors.white,
    this.borderRadius = 5,
  }) : super(key: key);

  @override
  State<CustomTextInputField> createState() => _CustomTextInputFieldState();
}

class _CustomTextInputFieldState extends State<CustomTextInputField> {

  bool obscure = false;
  @override
  void initState() {
    obscure = widget.obscure;
    super.initState();
  }

  double borderRadius = 5;
  @override
  Widget build(BuildContext context) {
    final width = ScreenSize(context).width;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: widget.borderColor,),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 2// changes position of shadow
            ),
          ]
      ),
      child: TextFormField(
        readOnly: widget.readOnly,
        cursorColor: widget.cursorColor,
        maxLines: widget.maxLine,
        keyboardType: widget.keyboardType??TextInputType.text,
        textInputAction: widget.textInputAction??TextInputAction.next,
        controller: widget.textEditingController,
        textAlignVertical: TextAlignVertical.center,
        obscuringCharacter: '*',
        obscureText:obscure,
        inputFormatters: widget.maxLength != null?[
          LengthLimitingTextInputFormatter(widget.maxLength!)
        ]:null,
        style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black
        ),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintMaxLines: widget.hintMaxLine,
          hintStyle: TextStyle(color: widget.hintColor??Colors.black.withOpacity(0.3),fontWeight: widget.hintFontWeight??FontWeight.w400,fontSize: widget.hintFontSize??16,),
          suffixIcon: widget.obscure?obscure?IconButton(onPressed: (){
            setState(() {
              obscure = !obscure;
            });
          }, icon: const Icon(Icons.visibility_off),):IconButton(onPressed: (){
            setState(() {
              obscure = !obscure;
            });
          }, icon: const Icon(Icons.visibility),):null,
          //contentPadding: widget.obscure? EdgeInsets.only(top: widget.obscurePadding!?25:10,left: 8,):widget.prefixImageLink != null?const EdgeInsets.only(top: 35):const EdgeInsets.all(10),
          border:OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: const BorderSide(
                color: Colors.transparent,
              )
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: const BorderSide(
                color:Colors.red,
              )
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: const BorderSide(
                color: Colors.transparent,
              )
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: const BorderSide(
                color: Colors.transparent,
              )
          ),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: const BorderSide(
                  color: Colors.red
              )
          ),
        ),
        validator: widget.validator,
      ),
    );
  }
}