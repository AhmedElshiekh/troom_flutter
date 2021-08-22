import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:troom/Controller/HomePage/HomeCont.dart';
import 'package:troom/Controller/ModalHudCont.dart';
<<<<<<< HEAD
=======
import 'package:troom/CustomViews/AppBarText.dart';
>>>>>>> 8735c7c42bfa70f00bed54310f9a2134fdd3b0df
import 'package:troom/CustomViews/CustomText.dart';
import 'package:troom/CustomViews/LogoContainer.dart';
import 'package:troom/Models/OurTeachers/OurTeachersDataList.dart';
import 'package:troom/Util/ConstStyles.dart';
import 'package:troom/Util/EndPoints.dart';
<<<<<<< HEAD
import 'package:troom/View/Instructors%20Details.dart';
=======
>>>>>>> 8735c7c42bfa70f00bed54310f9a2134fdd3b0df
import 'package:troom/View/MainDrawer.dart';

class OurInstructor extends StatelessWidget {
  static const Id = 'OurInstructorView';
  final HomeCont _homeCont = Get.put(HomeCont());

  @override
  Widget build(BuildContext context) {
    var appBarH = AppBar().preferredSize.height;
    return Scaffold(
<<<<<<< HEAD
      appBar: AppBar(title: Image.asset(
        'assets/images/logo.png', fit: BoxFit.contain, height: appBarH,),
=======
      appBar: AppBar( title: Image.asset('assets/images/logo.png',fit: BoxFit.contain,height: appBarH,),
>>>>>>> 8735c7c42bfa70f00bed54310f9a2134fdd3b0df
        backgroundColor: ConstStyles.WhiteColor,
        iconTheme: IconThemeData(color: ConstStyles.DarkColor),
      ),
      drawer: MainDrawer(),
      body: SafeArea(child: GetBuilder<ModalHudCont>(
        builder: (_) {
          return ModalProgressHUD(
            inAsyncCall: false,
            child: Container(child: LayoutBuilder(
              builder: (context, cons) {
                var localW = cons.maxWidth;
                var localH = cons.maxHeight;
                return ListView(
                  children: [
                    SizedBox(
                      height: localH * 0.02,
                    ),

                    //TODO Our Instructor
                    SizedBox(
                      width: localW,
                      height: localH * 0.07,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            txt: 'Teachers'.tr,
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

                    SizedBox(
                      height: localH * 0.02,
                    ),

                    //TODO Instructors Number
                    Container(
                      width: localW,
                      height: localH * 0.08,
<<<<<<< HEAD
                      margin: EdgeInsets.only(
                          left: localW * 0.075, right: localW * 0.075),
                      child: CustomText(
                        txt: '${'WeFound'.tr} ${_homeCont.ourTeachersList
                            .length}  ${'TeachersForYou'.tr}',
=======
                      margin: EdgeInsets.only(left: localW * 0.075,right: localW * 0.075),
                      child: CustomText(
                        txt: '${'WeFound'.tr} ${_homeCont.ourTeachersList.length}  ${'TeachersForYou'.tr}',
>>>>>>> 8735c7c42bfa70f00bed54310f9a2134fdd3b0df
                        fontSize: localW * 0.06,
                        txtColor: ConstStyles.BlueColor,
                      ),
                    ),


                    //TODO Instructors List View
                    GetBuilder<HomeCont>(
                      builder: (_) {
                        return SizedBox(
                          width: localW,
                          height: localH * 0.8,
                          child: ListView.builder(
                            itemCount: _homeCont.ourTeachersList != null
                                ? _homeCont.ourTeachersList.length
                                : 0,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              if (_homeCont.ourTeachersList.length > 0) {
<<<<<<< HEAD
                                return GestureDetector(
                                  onTap: () {

                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (_) =>
                                            Instructor(t: _homeCont.ourTeachersList
                                                [index],)));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: localW * 0.05,
                                        right: localW * 0.05,
                                        bottom: localW * 0.05),
                                    decoration: BoxDecoration(
                                      color: ConstStyles.WhiteColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
=======
                                return Container(
                                  margin: EdgeInsets.only(
                                      left: localW * 0.05, right: localW * 0.05, bottom: localW * 0.05),
                                    decoration: BoxDecoration(
                                      color: ConstStyles.WhiteColor,
                                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
>>>>>>> 8735c7c42bfa70f00bed54310f9a2134fdd3b0df
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 2.0,
                                          spreadRadius: 1.0,
<<<<<<< HEAD
                                          offset: Offset(2.0,
                                              2.0), // shadow direction: bottom right
                                        )
                                      ],
                                    ),
                                    child: ourTeacherListItem(localW, localH,
                                        _homeCont.ourTeachersList[index]),
                                  ),
=======
                                          offset: Offset(2.0, 2.0), // shadow direction: bottom right
                                        )
                                      ],
                                    ),
                                  child: ourTeacherListItem(localW, localH,
                                      _homeCont.ourTeachersList[index]),
>>>>>>> 8735c7c42bfa70f00bed54310f9a2134fdd3b0df
                                );
                              } else {
                                return SizedBox(
                                    width: localW,
                                    height: localH * 0.5,
                                    child: LogoContainer(
                                    ));
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            )),
          );
        },
      )),
    );
  }

  //TODO Our Teacher List Item
<<<<<<< HEAD
  Widget ourTeacherListItem(localW, localH, OurTeachersDataList item) {
=======
  Widget ourTeacherListItem(localW,localH,OurTeachersDataList item){
>>>>>>> 8735c7c42bfa70f00bed54310f9a2134fdd3b0df
    return Column(
      mainAxisAlignment:
      MainAxisAlignment.start,
      crossAxisAlignment:
      CrossAxisAlignment.center,
      children: [
        Container(
<<<<<<< HEAD
          width: localW,
=======
          width: localW ,
>>>>>>> 8735c7c42bfa70f00bed54310f9a2134fdd3b0df
          height: localH * 0.25,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(EndPoints.ImageUrl + item.image.toString()),
              fit: BoxFit.contain,
            ),
          ),
        ),

        CustomText(
          txt: item.name,
          txtColor: ConstStyles.TextColor,
          fontSize: localW * 0.08,
        ),
      ],
    );
  }
}
