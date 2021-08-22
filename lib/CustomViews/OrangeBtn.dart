<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:troom/CustomViews/CustomText.dart';
import 'package:troom/Util/ConstStyles.dart';

class OrangeBtn extends StatelessWidget {
   final String text;
   final Function onClick;
   final Color btnColor;
   final Color txtColor;
   final double fontSize;
   final double radius;


  OrangeBtn({ this.text, this.onClick,this.btnColor,this.txtColor,this.radius,this.fontSize});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius == null ? 10.0 : radius),
      ),
      color: btnColor == null ? ConstStyles.OrangeColor : btnColor,
/*
      child: Text(
        text,
        style: TextStyle(
            color:txtColor == null ? ConstStyles.WhiteColor : txtColor,
             fontWeight: FontWeight.bold, fontSize: 14),
      ),
*/
    child: CustomText(txt: text,
      txtColor: txtColor == null ? ConstStyles.WhiteColor : txtColor,
      fontSize: fontSize == null ? 16 : fontSize,),
      onPressed: (){
        return onClick();
      },
    );
  }

}
=======
import 'package:flutter/material.dart';
import 'package:troom/CustomViews/CustomText.dart';
import 'package:troom/Util/ConstStyles.dart';

class OrangeBtn extends StatelessWidget {
   final String text;
   final Function onClick;
   final Color btnColor;
   final Color txtColor;
   final double fontSize;
   final double radius;


  OrangeBtn({ this.text, this.onClick,this.btnColor,this.txtColor,this.radius,this.fontSize});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius == null ? 10.0 : radius),
      ),
      color: btnColor == null ? ConstStyles.OrangeColor : btnColor,
/*
      child: Text(
        text,
        style: TextStyle(
            color:txtColor == null ? ConstStyles.WhiteColor : txtColor,
             fontWeight: FontWeight.bold, fontSize: 14),
      ),
*/
    child: CustomText(txt: text,
      txtColor: txtColor == null ? ConstStyles.WhiteColor : txtColor,
      fontSize: fontSize == null ? 16 : fontSize,),
      onPressed: (){
        return onClick();
      },
    );
  }

}
>>>>>>> 8735c7c42bfa70f00bed54310f9a2134fdd3b0df
