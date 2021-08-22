import 'package:flutter/material.dart';
import 'package:troom/Util/ConstStyles.dart';

class VerificationForm extends StatelessWidget {
  final String hint;
  final IconData icon;
    Function onSave;
    Function onChange;
  final Function onValidate;
   final TextEditingController myController;
  final String data;
  final TextInputType keybord;
  final int minLin;
  final bool obscureText;
  final bool enabled;
  final Color dataColor;
  final Color hintColor;
  final TextInputAction inputAction;
  final bool focus;
  final FocusNode focusNode;

  VerificationForm({
    this.onSave,
    this.onChange,
    this.hint,
    this.enabled,
    this.myController,
    this.icon,
    this.onValidate,
    this.data,
    this.keybord,
    this.minLin,
    this.obscureText,
    this.dataColor,
    this.hintColor,
    this.inputAction,
    this.focus,
    this.focusNode,
  });

  String _errorMsg(String str) {
    switch (str) {
      case 'Enter your Title':
        return 'Title is empty !';
      case 'Enter your Email':
        return 'Email is empty !';
      case 'Enter your Password':
        return 'Password is empty !';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode == null ? null : focusNode,
      autofocus: focus == null ? false : focus,
      textInputAction: inputAction == null ? null : inputAction ,
      enabled: enabled,
      controller: myController,
      validator: (v){
        onValidate;
      },
      decoration: InputDecoration(
        fillColor: ConstStyles.WhiteColor,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ConstStyles.DarkColor),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ConstStyles.DarkColor),
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: ConstStyles.DarkColor),
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        labelText: hint,
        labelStyle: TextStyle(color:hintColor == null ? ConstStyles.TextColor : hintColor,fontWeight: FontWeight.normal,fontSize: 20),
      ),
      initialValue: data,
      onChanged: (v){
        return onChange(v);
      },
      obscureText: obscureText == null ? false : obscureText,
      onSaved: (s) {
        return onSave(s);
      },
      style: TextStyle( color:dataColor == null ? ConstStyles.BlackColor : dataColor,fontWeight: FontWeight.w500,fontSize: 20),
      keyboardType: keybord == null ? TextInputType.text : keybord,
      maxLines: minLin == null ? 1 : minLin,
    );
  }
}
