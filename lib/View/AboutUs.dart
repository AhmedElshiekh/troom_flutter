import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:troom/Controller/AboutUs/AboutUsCont.dart';
import 'package:troom/Controller/ModalHudCont.dart';
import 'package:troom/CustomViews/AppBarText.dart';
import 'package:troom/CustomViews/AutoTextSize.dart';
import 'package:troom/CustomViews/CustomNetworkImage.dart';
import 'package:troom/CustomViews/CustomText.dart';
import 'package:troom/CustomViews/LogoContainer.dart';
import 'package:troom/Util/ConstStyles.dart';
import 'package:troom/Util/EndPoints.dart';
import 'package:troom/View/MainDrawer.dart';

class AboutUs extends GetView<AboutUsCont> {
  static const Id = 'AboutUsScreen';
  final AboutUsCont _aboutUsCont = Get.put(AboutUsCont());

  @override
  Widget build(BuildContext context) {
    var appBarH = AppBar().preferredSize.height;
    return Scaffold(
      appBar: AppBar( title: Image.asset('assets/images/logo.png',fit: BoxFit.contain,height: appBarH,),
        backgroundColor: ConstStyles.WhiteColor,
        iconTheme: IconThemeData(color: ConstStyles.DarkColor),
      ),
      drawer: MainDrawer(),
      body: SafeArea(
        child: GetBuilder<ModalHudCont>(
          builder: (_){
            return ModalProgressHUD(
              inAsyncCall: _aboutUsCont.modalHudController.isLoading,
              child: Container(
                child: LayoutBuilder(builder: (context,cons){
                  var localW = cons.maxWidth;
                  var localH = cons.maxHeight;
                  return GetBuilder<AboutUsCont>(builder: (_){
                    return ListView(
                      children: [
                        SizedBox(
                          height: localH * 0.01,
                        ),

                        //TODO About Us Title
                        SizedBox(
                          width: localW,
                          height: localH * 0.08,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                txt: 'AboutUs'.tr,
                                fontSize: localW * 0.09,
                                txtColor: ConstStyles.DarkColor,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              right: localW * 0.25, left: localW * 0.25),
                          child: Divider(
                            thickness: 5,
                            color: ConstStyles.OrangeColor,
                          ),
                        ),

                        //TODO About Us Data
                        SizedBox(
                          width: localW,
                          height: localH * 0.4,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              //TODO Image
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: GetBuilder<AboutUsCont>(
                                    builder: (_){
                                      if(_aboutUsCont.aboutUsResData.image != null){
                                        return SizedBox(
                                            width:localW,
                                            height: localH * 0.4,
                                            child:
                                            Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  colorFilter: ColorFilter.mode(
                                                      Colors.black.withOpacity(1), BlendMode.dstATop),
                                                  image: NetworkImage(
                                                      "${EndPoints.ImageUrl}${_aboutUsCont.aboutUsResData.image.toString()}"),
                                                ),
                                              ),
                                              width: localW,
                                              // height: localH * 0.4,
                                            )
                                        );
                                      }else{
                                        return LogoContainer();
                                      }
                                    },
                                  ),
                                ),
                              ),

                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    color: Colors.black38,
                                    child: ListView(
                                      children: [
                                        //TODO Name
                                        SizedBox (
                                          height: localH * 0.08,
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                left: localW * 0.04,top: localH * 0.02,right: localW * 0.04),
                                            child: CustomText(txt:'${'WhoWeAre'.tr}  ',txtColor: ConstStyles.OrangeColor,fontSize: localW * 0.1,fontWeight: FontWeight.w900,),
                                          ),
                                        ),

                                        //TODO Short Desc
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: localW * 0.15,
                                              right: localW * 0.02),
                                          child: SizedBox(
                                            height: localH * 0.18,
                                            child: SingleChildScrollView(
                                              child: AutoTextSize(
                                                text:
                                                _aboutUsCont.aboutUsResData.shDesc == null ?
                                                'Short Description':_aboutUsCont.aboutUsResData.shDesc,
                                                fontWeight: FontWeight.w900,
                                                size: localW * 0.035,
                                                textColor: ConstStyles.WhiteColor,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //TODO Full Desc
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: localW * 0.15,
                                              top: localH * 0.015,
                                              right: localW * 0.02,
                                          bottom: localH * 0.015),
                                          child: SizedBox(
                                            height: localH * 0.2,
                                            child: SingleChildScrollView(
                                              child: Html(
                                                style: {
                                                  "body":Style(
                                                    fontSize: FontSize(localW * 0.035),
                                                    fontWeight: FontWeight.w900,
                                                    color: ConstStyles.WhiteColor,
                                                  )
                                                },
                                                data:
                                                _aboutUsCont.aboutUsResData.fullDesc == null ? 'Full Description':_aboutUsCont.aboutUsResData.fullDesc,
                                              ),
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                              )

                            ],
                          ),
                        ),

                        SizedBox(
                          height: localH * 0.08,
                          width: localW * 0.05,
                          child: Container(
                            margin: EdgeInsets.only(
                                left: localW * 0.04),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  "assets/images/logo.png",),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),

                        //TODO Footer
                        Container(
                          height: localH * 0.52,
                          width: localW * 0.8,
                          margin: EdgeInsets.only(
                              top: localH * 0.01, bottom: localH * 0.01),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: ConstStyles.DarkColor,
                                    ),
                                    width: localW,
                                    height: localH * 0.52,
                                  ),
                                ),
                              ),

                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: localW * 0.24,
                                        right: localW * 0.02,),
                                    color: ConstStyles.DarkColor,
                                    child: ListView(
                                      children: [
                                        //TODO Phone
                                        Container(
                                          margin: EdgeInsets.only(top: localH * 0.04,),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                txt: "${'OurNumbers'.tr} : ",
                                              ),
                                              Expanded(
                                                  child: CustomText(
                                                    txt:
                                                    '',
                                                  )),
                                            ],
                                          ),
                                        ),
                                        //TODO Email
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: localH * 0.04,
                                          ),
                                          child: Row(
                                            children: [
                                              CustomText(
                                                txt: "${'OurEmails'.tr} : ",
                                              ),
                                              Expanded(
                                                  child: CustomText(
                                                    txt:
                                                    '',
                                                  )),
                                            ],
                                          ),
                                        ),
                                        //TODO Address
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: localH * 0.04,
                                          ),
                                          child: Row(
                                            children: [
                                              CustomText(
                                                txt: "${'Address'.tr} : ",
                                              ),
                                              Expanded(
                                                  child: CustomText(
                                                    txt:
                                                    '',
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: localH * 0.04,),
                                          child: Row(
                                            children: [
                                              CustomText(
                                                txt: "${'Whatsapp'.tr} : ",
                                              ),
                                              Expanded(
                                                  child: CustomText(
                                                    txt:
                                                    '',
                                                  )),
                                            ],
                                          ),
                                        ),
                                        //TODO Facebook
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: localH * 0.04,
                                          ),
                                          child: Row(
                                            children: [
                                              CustomText(
                                                txt: "${'Facebook'.tr} : ",
                                              ),
                                              Expanded(
                                                  child: CustomText(
                                                    txt:
                                                    '',
                                                  )),
                                            ],
                                          ),
                                        ),
                                        //TODO Twitter
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: localH * 0.04,),
                                          child: Row(
                                            children: [
                                              CustomText(
                                                txt: "${'Twitter'.tr} : ",
                                              ),
                                              Expanded(
                                                  child: CustomText(
                                                    txt:
                                                    '',
                                                  )),
                                            ],
                                          ),
                                        ),
                                        //TODO LinkedIn
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: localH * 0.04,
                                          ),
                                          child: Row(
                                            children: [
                                              CustomText(
                                                txt: "${'LinkedIn'.tr} : ",
                                              ),
                                              Expanded(
                                                  child: CustomText(
                                                    txt:
                                                    '',
                                                  )),
                                            ],
                                          ),
                                        ),
                                        //TODO Instagram
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: localH * 0.04,
                                              ),
                                          child: Row(
                                            children: [
                                              CustomText(
                                                txt: "${'Instagram'.tr} : ",
                                              ),
                                              Expanded(
                                                  child: CustomText(
                                                    txt:
                                                    '',
                                                  )),
                                            ],
                                          ),
                                        ),
                                        //TODO YouTube
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: localH * 0.04,
                                              bottom: localH * 0.05),
                                          child: Row(
                                            children: [
                                              CustomText(
                                                txt: "${'YouTube'.tr} : ",
                                              ),
                                              Expanded(
                                                  child: CustomText(
                                                    txt:
                                                    '',
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )

                            ],
                          ),
                        ),

                      ],
                    );
                  });
                },),
              ),
            );
          },
        ),
      ),
    );
  }

}
