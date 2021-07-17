import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:troom/Controller/AllCourses/CourseDetailsCont.dart';
import 'package:troom/View/Courses/CoursePlacementTest.dart';
import 'package:troom/Controller/HomePage/HomeCont.dart';
import 'package:troom/Controller/ModalHudCont.dart';
import 'package:troom/CustomViews/AutoTextSize.dart';
import 'package:troom/CustomViews/CustomText.dart';
import 'package:troom/CustomViews/LogoContainer.dart';
import 'package:troom/CustomViews/OrangeBtn.dart';
import 'package:troom/Models/CourseDetails/CourseDetailsResData.dart';
import 'package:troom/Models/LessonData/LessonDataResData.dart';
import 'package:troom/Util/ConstStyles.dart';
import 'package:troom/Util/EndPoints.dart';
import 'package:troom/Util/LocalDataStrings.dart';
import 'package:troom/View/Auth/Login.dart';
import 'package:troom/View/Auth/Register.dart';
import 'package:troom/View/MainDrawer.dart';
import 'package:troom/View/Courses/PayPalView.dart';
import 'package:troom/View/PlacementTest.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_html/flutter_html.dart';


class CourseDetails extends GetView<CourseDetailsCont> {
  static const Id = 'CourseDetailsScreen';
  var _courseKey;
   CourseDetailsCont _courseDetailsCont;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  CourseDetails(this._courseKey){

    _courseDetailsCont = Get.put(CourseDetailsCont(_courseKey.toString()));

  }

  @override
  Widget build(BuildContext context) {
    var appBarH = AppBar().preferredSize.height;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar( title: Image.asset('assets/images/logo.png',fit: BoxFit.contain,height: appBarH,),
      backgroundColor: ConstStyles.WhiteColor,
        iconTheme: IconThemeData(color: ConstStyles.DarkColor),
      ),
      drawer: MainDrawer(),
      body: SafeArea(
        child: GetBuilder<ModalHudCont>(
          builder: (_){
            return ModalProgressHUD(
              inAsyncCall: _courseDetailsCont.modalHudController.isLoading,
              child: Container(
                child: LayoutBuilder(builder: (context,cons){
                  var localH = cons.maxHeight;
                  var localW = cons.maxWidth;
                  return GetBuilder<CourseDetailsCont>(
                    builder: (_){
                      return ListView(
                        children: [

                          //TODO Image
                          SizedBox(
                              width: localW,
                              height: localH * 0.4,
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: SizedBox(
                                        width: localW,
                                        height: localH * 0.4,
                                        child: _courseDetailsCont.courseDetailsResData.image != null ?
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(0.0),
                                          child: FadeInImage.memoryNetwork(
                                            fit: BoxFit.fill,
                                            imageScale: 1.0,
                                            placeholder: kTransparentImage,
                                            image: "${EndPoints.ImageUrl}${_courseDetailsCont.courseDetailsResData.image.toString()}" ,
                                          ),
                                        ) : LogoContainer(),
                                      )
                                      ,),),

                                  Positioned.fill(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        color: Colors.black45,
                                        width: localW,
                                        height: localH * 0.4,
                                        padding: EdgeInsets.only(left: localW * 0.1),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: localW * 0.2,
                                                  height: localH * 0.06,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.rectangle,
                                                      color: ConstStyles.DarkColor
                                                  ),
                                                  child: Center(
                                                      child: GetBuilder<CourseDetailsCont>(
                                                        builder: (_){
                                                          return CustomText(
                                                            txt: _courseDetailsCont.courseDetailsResData.category == null ? ''
                                                                : _courseDetailsCont.courseDetailsResData.category,
                                                            fontSize: localW * 0.05,);
                                                        },
                                                      )),
                                                ),
                                                SizedBox(width: localW * 0.05,),
                                                Container(
                                                  width: localW * 0.2,
                                                  height: localH * 0.06,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.rectangle,
                                                      color: ConstStyles.DarkColor
                                                  ),
                                                  child: Center(child: CustomText(txt: _courseDetailsCont.courseDetailsResData.subCategory == null ? '' : _courseDetailsCont.courseDetailsResData.subCategory,fontSize: localW * 0.05,)),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: localH * 0.02,),
                                            CustomText(txt: _courseDetailsCont.courseDetailsResData.name == null ? '' : _courseDetailsCont.courseDetailsResData.name,fontSize: localW * 0.07,),
                                            SizedBox(height: localH * 0.02,),
                                            CustomText(txt:  _courseDetailsCont.courseDetailsResData.shortDescription == null ? '' : _courseDetailsCont.courseDetailsResData.shortDescription,fontSize: localW * 0.05,),
                                            SizedBox(height: localH * 0.006,),
                                          ],
                                        ),
                                      ),
                                    ),),


                                ],
                              )
                          ),

                          //TODO buy Now
                          GetBuilder<CourseDetailsCont>(builder: (_){
                            //TODO owner == null or == false
                            if(_courseDetailsCont.courseDetailsResData.owner!=null && !_courseDetailsCont.courseDetailsResData.owner)
                            {
                              print('Tesssr:: ${_courseDetailsCont.courseDetailsResData.owner}');
                              //TODO No Discount Price
                              if(_courseDetailsCont.courseDetailsResData.discountPrice == null || _courseDetailsCont.courseDetailsResData.discountPrice == 0){
                                return  Container(
                                  width: localW,
                                  margin: EdgeInsets.only(left: localW * 0.03,right: localW * 0.03,top: localH * 0.01),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      //TODO price
                                      CustomText(txt: _courseDetailsCont.courseDetailsResData.price == null ? '':
                                      _courseDetailsCont.courseDetailsResData.price.toString()
                                        ,txtColor: ConstStyles.DarkColor,),
                                      // CustomText(txt: 'EgyptianPound'.tr
                                      //   ,txtColor: ConstStyles.DarkColor,),
                                      SizedBox(width: localW * 0.02,),

                                      GetBuilder<CourseDetailsCont>(builder: (_){
                                        return OrangeBtn(text: 'BuyNow'.tr,onClick: ()async{
                                          //TODO User Not Logged In Can't buy
                                          if(_courseDetailsCont.getStorage.read(LocalDataStrings.isLogged) == null
                                              || !_courseDetailsCont.getStorage.read(LocalDataStrings.isLogged)){
                                            showDialog(
                                              barrierDismissible: false,
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                      content: Container(
                                                        height: localH * 0.3,
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                              children: [
                                                                InkWell(
                                                                    onTap: (){
                                                                      Get.back();
                                                                    },
                                                                    child: Icon(Icons.close,color: ConstStyles.DarkColor,)),
                                                              ],
                                                            ),
                                                            //TODO Dialog Text
                                                            CustomText(txt: "PleaseLoginFirst".tr,txtColor: ConstStyles.TextColor,),
                                                            SizedBox(height: localH* 0.04,),
                                                            OrangeBtn(text: 'SignIn'.tr, onClick: (){
                                                              Get.back();
                                                              Get.toNamed(Login.Id);
                                                            }),
                                                            OrangeBtn(text: 'SignUp'.tr, onClick: (){
                                                              Get.back();
                                                              Get.to(()=>Register());
                                                            }),
                                                          ],
                                                        ),
                                                      )
                                                  );
                                                });
                                          }
                                          //TODO User Already Logged In can buy
                                          else{
                                            var url = await _courseDetailsCont.getPauPalLink(_courseDetailsCont.courseDetailsResData.key, _courseDetailsCont.token);
                                            if(url!=null){
                                              Get.to(()=>PayPalView(url));
                                            }
                                          }
                                        },);
                                      }),

                                    ],
                                  ),
                                );
                              }
                              //TODO Discount price
                              else{
                                return  Container(
                                  width: localW,
                                  margin: EdgeInsets.only(left: localW * 0.03,right: localW * 0.03,top: localH * 0.01),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        width: localW * 0.2,
                                        height: localH * 0.05,
                                        child: Stack(
                                          fit: StackFit.expand,
                                          children: [

                                            Positioned.fill(
                                              child: Align(
                                                alignment: Alignment
                                                    .centerLeft,
                                                child: SizedBox(
                                                  width: localW * 0.2,
                                                  child: CustomText(
                                                    txtAlign: TextAlign.center,
                                                    txt: _courseDetailsCont.courseDetailsResData.price == null ? '':
                                                    _courseDetailsCont.courseDetailsResData.price.toString(),
                                                    txtColor: Colors
                                                        .green,
                                                    fontSize:
                                                    localW *
                                                        0.05,
                                                  ),
                                                ),),),

                                            Positioned.fill(
                                                child: Align(
                                                  alignment: Alignment
                                                      .center,
                                                  child: SizedBox(
                                                    width: localW * 0.15,
                                                    child: Divider(
                                                      thickness: 1,
                                                      color: Colors.green,
                                                    ),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),

                                      SizedBox(width: localW * 0.02,),

                                      CustomText(txt: _courseDetailsCont.courseDetailsResData.discountPrice == null ? '':
                                      _courseDetailsCont.courseDetailsResData.discountPrice.toString()
                                        ,txtColor: ConstStyles.DarkColor,),
                                      // CustomText(txt: 'EgyptianPound'.tr
                                      //   ,txtColor: ConstStyles.DarkColor,),
                                      SizedBox(width: localW * 0.02,),

                                      GetBuilder<CourseDetailsCont>(builder: (_){
                                        return OrangeBtn(text: 'BuyNow'.tr,onClick: ()async{
                                          //TODO User Not Logged In Can't buy
                                          if(_courseDetailsCont.getStorage.read(LocalDataStrings.isLogged) == null
                                              || !_courseDetailsCont.getStorage.read(LocalDataStrings.isLogged)){
                                            showDialog(
                                              barrierDismissible: false,
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                      content: Container(
                                                        width: localW,
                                                        height: localH * 0.3,
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                              children: [
                                                                InkWell(
                                                                    onTap: (){
                                                                      Get.back();
                                                                    },
                                                                    child: Icon(Icons.close,color: ConstStyles.DarkColor,)),
                                                              ],
                                                            ),
                                                            //TODO Dialog Text
                                                            CustomText(txt: "PleasLoginFirst".tr,txtColor: ConstStyles.TextColor,),
                                                            SizedBox(height: localH* 0.04,),
                                                            OrangeBtn(text: 'SignIn'.tr, onClick: (){
                                                              Get.back();
                                                              Get.toNamed(Login.Id);
                                                            }),
                                                            OrangeBtn(text: 'SignUp'.tr, onClick: (){
                                                              Get.back();
                                                              Get.to(()=>Register());
                                                            }),
                                                          ],
                                                        ),
                                                      )
                                                  );
                                                });

                                          }
                                          //TODO User Already Logged In can buy
                                          else{
                                            var url = await _courseDetailsCont.getPauPalLink(_courseDetailsCont.courseDetailsResData.key, _courseDetailsCont.token);
                                            if(url!=null){
                                              Get.to(()=>PayPalView(url));
                                            }                                          }
                                        },);
                                      }),

                                    ],
                                  ),
                                );
                              }
                            }
                            //TODO owner == true && Has Placement Test
                            else
                              if(_courseDetailsCont.courseDetailsResData.owner != null
                                && _courseDetailsCont.courseDetailsResData.owner
                                && _courseDetailsCont.courseDetailsResData.placementTest != null){
                              return Center(
                                child: OrangeBtn(
                                  text: 'Take Placement Test',
                                  onClick: ()async{
                                   await _courseDetailsCont.getPlacementExamData(_courseDetailsCont.courseDetailsResData.placementTest, _courseDetailsCont.token, _courseDetailsCont.appLang);
                                    showDialog(
                                        barrierDismissible: false,
                                        context: _scaffoldKey.currentContext,
                                        builder: (context){
                                          // return AlertDialog(
                                          //   content: CoursePlacementTest(localH: localH * 0.85,)
                                          //   // content: CoursePlacementTest(placementKey: _courseDetailsCont.courseDetailsResData.placementTest,)
                                          // );
                                          return GetBuilder<ModalHudCont>(builder: (_){
                                            return ModalProgressHUD(
                                              inAsyncCall: _courseDetailsCont.modalHudController.isLoading,
                                              child: GetBuilder<CourseDetailsCont>(builder: (_){
                                                //TODO Dialog
                                                return AlertDialog(
                                                  content: CoursePlacementTest(localH: localH * 0.85,),
                                                );
                                              },),
                                            );
                                          },);
                                        });
                                    // if(await _courseDetailsCont.getPlacementExamData(
                                    //     _courseDetailsCont.courseDetailsResData.placementTest,
                                    //     _courseDetailsCont.token, _courseDetailsCont.appLang)){
                                    //   showDialog(
                                    //       barrierDismissible: false,
                                    //       context: context,
                                    //       builder: (context){
                                    //         return AlertDialog(
                                    //           content: Center(
                                    //             child: CustomText(
                                    //               txtColor: ConstStyles.BlackColor,
                                    //               txt: 'aaaaa',
                                    //             ),
                                    //           ),
                                    //         );
                                    //         return GetBuilder<ModalHudCont>(builder: (_){
                                    //           return ModalProgressHUD(
                                    //             inAsyncCall: _courseDetailsCont.modalHudController.isLoading,
                                    //             child: GetBuilder<CourseDetailsCont>(builder: (_){
                                    //               //TODO Dialog
                                    //               return AlertDialog(
                                    //                 content: CoursePlacementTest(),
                                    //               );
                                    //             },),
                                    //           );
                                    //         },);
                                    //       });
                                    // }else{
                                    //   Get.snackbar('', '',backgroundColor: ConstStyles.DarkColor,
                                    //       colorText: ConstStyles.WhiteColor,
                                    //       titleText: CustomText(txt: 'Please Sign In first',
                                    //         txtAlign: TextAlign.center,));
                                    // }
                                },
                                  btnColor: ConstStyles.BlueColor,
                                ),
                              );
                            }else{
                              return Container();
                            }

                          }),

/*
                          GetBuilder<CourseDetailsCont>(builder: (_){
                            if(_courseDetailsCont.courseDetailsResData.owner != null
                                && _courseDetailsCont.courseDetailsResData.owner
                                && _courseDetailsCont.courseDetailsResData.placementTest != null){
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context){
                                    return GetBuilder<ModalHudCont>(builder: (_){
                                      return ModalProgressHUD(
                                        inAsyncCall: _courseDetailsCont.modalHudController.isLoading,
                                        child:
                                        GetBuilder<CourseDetailsCont>(builder: (_){
                                          //TODO Dialog
                                          return AlertDialog(
                                            content: CoursePlacementTest(localH: localH * 0.85,),
                                          );
                                        },),
                                      );
                                    },);
                                  });
                              return Container();
                            }else{
                              return Container();
                            }
                          }),
*/

                          //TODO Current Lesson Name And Video
                          GetBuilder<CourseDetailsCont>(builder: (_){
                            if(_courseDetailsCont.courseDetailsResData.currentLessonKey == null){
                              return Container();
                            }else{
                              return Container(
                                width: localW,
                                padding: EdgeInsets.only(top: localH * 0.01,bottom: localH * 0.01),
                                margin: EdgeInsets.only(left: localW * 0.03,right: localW * 0.03,top: localH * 0.03),
                                color: ConstStyles.WhiteColor,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //TODO Lesson Title from lesson data api
                                    Container(
                                        width: localW,
                                        child: CustomText(txt: _courseDetailsCont.lessonDataResData.name == null ?
                                        ' ' : _courseDetailsCont.lessonDataResData.name,fontSize: localW * 0.06,txtColor: ConstStyles.DarkColor,)),

                                    //TODO Lesson Video
                                    SizedBox(
                                      width: localW,
                                      height: localH * 0.35,
                                      child: _courseDetailsCont.chewieController == null ?
                                      Center(child: CircularProgressIndicator()) : Chewie(
                                        controller: _courseDetailsCont.chewieController,
                                      )
/*
                                      FutureBuilder(
                                        future: _courseDetailsCont.initializeVideoPlayerFuture,
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.done) {
                                            return Stack(
                                              fit: StackFit.expand,
                                              children: [

                                                Positioned.fill(
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: AspectRatio(
                                                      aspectRatio: _courseDetailsCont.controller.value.aspectRatio,
                                                      child: VideoPlayer(_courseDetailsCont.controller),
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                Positioned.fill(
                                                  child: Align(
                                                    alignment: Alignment.bottomCenter,
                                                    child: Container(
                                                      padding: EdgeInsets.all(localW * 0.015),
                                                      decoration: BoxDecoration(
                                                          color: ConstStyles.WhiteColor,
                                                          borderRadius: BorderRadius.all(Radius.circular(40))
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          GetBuilder<CourseDetailsCont>(builder: (_){
                                                            if(!_courseDetailsCont.controller.value.isPlaying){
                                                              return  InkWell(
                                                                onTap: (){
                                                                  _courseDetailsCont.playVideo();
                                                                },
                                                                child: Icon(
                                                                  Icons.play_arrow,
                                                                ),
                                                              );
                                                            }else{
                                                              return InkWell(
                                                                onTap: (){
                                                                  _courseDetailsCont.pauseVideo();
                                                                },
                                                                child: Icon(
                                                                  Icons.pause ,
                                                                ),
                                                              );
                                                            }

                                                          },),

                                                          InkWell(
                                                            onTap: (){
                                                              _courseDetailsCont.stopVideo();
                                                            },
                                                            child: Icon(
                                                              Icons.stop,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                              ],
                                            );
                                          } else {
                                            return Center(child: CircularProgressIndicator());
                                          }
                                        },
                                      ),
*/
                                    ),


                                  ],
                                ),
                              );
                            }
                          }),

                          SizedBox(height: localH * 0.03,),

                          //TODO Course Chapters
                          Container(
                            color: ConstStyles.WhiteColor,
                            // margin: EdgeInsets.only(left: localW * 0.1,right: localW * 0.1,top: localH * 0.01),
                            margin: EdgeInsets.only(top: localH * 0.01),
                            padding: EdgeInsets.only(left: localW *0.01,right: localW *0.01,top: localH * 0.02),
                            height: localH * 0.6,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                //TODO Course Chapter
                                SizedBox(
                                  height: localH * 0.05,
                                  child: CustomText(
                                    txt: '${'CourseChapters'.tr} : ',
                                    txtColor: ConstStyles.DarkColor,
                                    fontSize: localW * 0.07,
                                  ),
                                ),
                                SizedBox(height: localH * 0.02,),

                                //TODO Course
                                GetBuilder<CourseDetailsCont>(builder: (_){
                                  if(_courseDetailsCont.courseDetailsResData.chapters != null
                                      && _courseDetailsCont.courseDetailsResData.chapters.length > 0 ){
                                    return Expanded(
                                        child: ListView(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(left: localW * 0.03,right: localW * 0.03),
                                          child: ExpansionPanelList(
                                            dividerColor: ConstStyles.WhiteColor,
                                            expansionCallback: (index,isExpanded){
                                              _courseDetailsCont.changeExpandedView(index);
                                            },
                                            children: _courseDetailsCont.myExpandedItem.map((myItem item) {
                                              return ExpansionPanel(
                                                backgroundColor: ConstStyles.BlueColor,
                                                headerBuilder: (context,isExpanded){
                                                  return Container(
                                                      margin: EdgeInsets.only(left: localW * 0.02,right: localW * 0.02,top: localW*0.02),
                                                      child: CustomText(txt: item.header,txtColor: ConstStyles.WhiteColor,));
                                                },
                                                body: Container(
                                                  color: ConstStyles.WhiteColor,
                                                  height: localH * 0.25,
                                                  child: ListView.builder(
                                                      itemCount: item.body.length,
                                                      itemBuilder: (context,lessonIndex){
                                                        return SizedBox(
                                                          height: localH * 0.25,
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              //TODO Lesson Name
                                                              SizedBox(
                                                                height: localH * 0.05,
                                                                child: InkWell(
                                                                  onTap: (){
                                                                    if(_courseDetailsCont.lessonDataResData.prevTest != null){
                                                                      Get.snackbar('', '',backgroundColor: ConstStyles.DarkColor,
                                                                          colorText: ConstStyles.WhiteColor,
                                                                          titleText: CustomText(txt: 'YouShouldPassTheChapterExamFirst'.tr,
                                                                            txtAlign: TextAlign.center,));
                                                                    }else{
                                                                      _courseDetailsCont.getLessonData(item.body[lessonIndex].key, _courseDetailsCont.token);
                                                                    }
                                                                  },
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      Icon(Icons.play_arrow,color: ConstStyles.BlueColor,),
                                                                      CustomText(
                                                                        txt: 'Lesson'.tr,
                                                                        txtColor: ConstStyles.TextColor,
                                                                      ),
                                                                      CustomText(
                                                                        txt: item.body[lessonIndex].name,
                                                                        txtColor: ConstStyles.TextColor,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              //TODO Download Material
                                                              SizedBox(
                                                                height: localH * 0.05,
                                                                child: InkWell(
                                                                  onTap: ()async{
                                                                    if(await _courseDetailsCont.downloadMaterial(_courseDetailsCont.lessonDataResData.material)){
                                                                    Get.snackbar('', '',backgroundColor: ConstStyles.DarkColor,
                                                                    colorText: ConstStyles.WhiteColor,
                                                                    titleText: CustomText(txt: 'SuccessfullyDownloadedMaterial'.tr,
                                                                    txtAlign: TextAlign.center,));
                                                                    }else{
                                                                    Get.snackbar('', '',backgroundColor: ConstStyles.DarkColor,
                                                                    colorText: Colors.red,
                                                                    titleText: CustomText(txt: 'SomethingWentWrongDownloadAgain'.tr,
                                                                    txtAlign: TextAlign.center,));
                                                                    }
                                                                  },
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      Icon(Icons.download_sharp,color: ConstStyles.BlueColor,),
                                                                      CustomText(
                                                                        txt: 'DownloadMaterial'.tr,
                                                                        txtColor: ConstStyles.TextColor,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),

                                                              //TODO Next Lesson
                                                              SizedBox(
                                                                height: localH * 0.05,
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                  children: [
                                                                    GetBuilder<CourseDetailsCont>(builder: (_){
                                                                      return OrangeBtn(
                                                                        txtColor: ConstStyles.WhiteColor,
                                                                        text: 'Next'.tr,
                                                                        btnColor: ConstStyles.BlueColor,
                                                                        onClick: (){
                                                                          //TODO Show Summary
                                                                          showDialog(
                                                                            barrierDismissible: false,
                                                                              context: context,
                                                                              builder: (context){
                                                                                return GetBuilder<ModalHudCont>(builder: (_){
                                                                                  return ModalProgressHUD(
                                                                                    inAsyncCall: _courseDetailsCont.modalHudController.isLoading,
                                                                                    child: GetBuilder<CourseDetailsCont>(builder: (_){
                                                                                      //TODO Dialog
                                                                                      return AlertDialog(
                                                                                        content: Container(
                                                                                          height:localH,
                                                                                          width : localW,
                                                                                          child: Center(
                                                                                            child: ListView(
                                                                                              children: [
                                                                                                Row(
                                                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                                                  children: [
                                                                                                    InkWell(
                                                                                                        onTap: (){
                                                                                                          Get.back();
                                                                                                        },
                                                                                                        child: Icon(Icons.close,color: ConstStyles.DarkColor,)),
                                                                                                  ],
                                                                                                ),
                                                                                                CustomText(txt: 'Summary'.tr,txtColor: ConstStyles.OrangeColor,fontWeight: FontWeight.bold,fontSize: localW * 0.06,),
                                                                                                Divider(
                                                                                                  thickness: 1,
                                                                                                  color: ConstStyles.OrangeColor,
                                                                                                ),

                                                                                                Html(data: _courseDetailsCont.lessonDataResData.summary == null ? ' ' :_courseDetailsCont.lessonDataResData.summary ,),
                                                                                                GetBuilder<CourseDetailsCont>(builder: (_){
                                                                                                  print(' GetBuilder Check Lesson Closed = ${_courseDetailsCont.lessonDataResData.lessonClosed}');

                                                                                                  if(!_courseDetailsCont.lessonDataResData.endQuizLesson){
                                                                                                    return OrangeBtn(text: 'LessonExam'.tr, onClick: (){
                                                                                                      //TODO Open Lesson Exam
                                                                                                      print('LessonExam Key:: ${_courseDetailsCont.lessonDataResData.key}');
                                                                                                      Get.back();
                                                                                                      _courseDetailsCont.getCourseQuizLesson(_courseDetailsCont.lessonDataResData.key, _courseDetailsCont.token);
                                                                                                    });
                                                                                                  }else{
                                                                                                    return OrangeBtn(text: 'NextLesson'.tr, onClick: (){
                                                                                                      //TODO Open Next Lesson
                                                                                                      if(_courseDetailsCont.lessonDataResData.nextLesson != null){
                                                                                                        Get.back();
                                                                                                        _courseDetailsCont.getLessonData(_courseDetailsCont.lessonDataResData.nextLesson, _courseDetailsCont.token);
                                                                                                      }else{
                                                                                                        Get.back();
                                                                                                        Get.snackbar('', '',backgroundColor: ConstStyles.DarkColor,
                                                                                                            colorText: ConstStyles.WhiteColor,
                                                                                                            titleText: CustomText(txt: 'NoNextLessonAvailable'.tr,
                                                                                                              txtAlign: TextAlign.center,));
                                                                                                      }
                                                                                                    });
                                                                                                  }
                                                                                                }),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      );
                                                                                    },),
                                                                                  );
                                                                                },);
                                                                              });
                                                                        },
                                                                      );
                                                                    }),
                                                                  ],
                                                                ),
                                                              ),

                                                              Divider(
                                                                thickness: 1,
                                                                color: ConstStyles.DarkColor,
                                                              ),

                                                              //TODO Chapter Quiz Btn
                                                              SizedBox(
                                                                height: localH * 0.05,
                                                                child: GetBuilder<CourseDetailsCont>(builder: (_){
                                                                  if( _courseDetailsCont.courseDetailsResData.chapters[lessonIndex] != null &&
                                                                      _courseDetailsCont.courseDetailsResData.chapters[lessonIndex].quiz){
                                                                    return OrangeBtn(text: 'ChapterQuiz'.tr, onClick: (){
                                                                      _courseDetailsCont.getCourseQuizChapter(
                                                                          _courseDetailsCont.courseDetailsResData.chapters[lessonIndex].key,
                                                                          _courseDetailsCont.token,
                                                                          _courseDetailsCont.courseDetailsResData.chapters[lessonIndex].name);

                                                                    },btnColor: ConstStyles.BlueColor,);
                                                                  }else{
                                                                    return Container();
                                                                  }
                                                                }),
                                                              ),

                                                              Container(
                                                                margin: EdgeInsets.only(left: localW *0.1,right: localW * 0.1),
                                                                child: Divider(
                                                                  thickness: 2,
                                                                  color: ConstStyles.DarkColor,
                                                                ),
                                                              ),

                                                            ],
                                                          ),
                                                        );
                                                      }),
                                                ),
                                                isExpanded: item.isExpanded,
                                              );
                                            }).toList(),

                                          ),
                                        )
                                      ],
                                    ),
                                    );
                                  }
                                  else{
                                    return Container(
                                      margin: EdgeInsets.only(top: localH *0.1,bottom: localH *0.1),
                                      child: Center(child: CustomText(txt:'NoLessonsAvailable'.tr,txtColor: ConstStyles.TextColor,fontSize: localW*0.05,txtAlign: TextAlign.center,)),
                                    );
                                  }
                                }),


                              ],
                            ),
                          ),

                          //TODO Drop Down button old View
/*
                          SizedBox(
                            height: localH * 0.5,
                            child: Expanded(
                              child: ListView.builder(
                                itemBuilder: (context,index){
                                  return Container(
                                    color: ConstStyles.WhiteColor,
                                    margin: EdgeInsets.only(bottom: localH * 0.01),
                                    child: Column(
                                      children: [
                                        //TODO Drop Down
                                        Container(
                                          padding: EdgeInsets.only(left: localW * 0.02,right: localW *0.02),
                                          color:ConstStyles.BlueColor,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: localW * 0.3,
                                                child: AutoTextSize(
                                                  text: _courseDetailsCont.courseDetailsResData.chapters[index].name,
                                                  textColor: ConstStyles.WhiteColor,
                                                ),
                                              ),

                                              InkWell(
                                                onTap: (){
                                                  if(_courseDetailsCont.getLessonList(index).length <= 0 ){
                                                    Get.snackbar('', '',backgroundColor: ConstStyles.DarkColor,
                                                        colorText: ConstStyles.WhiteColor,
                                                        titleText: CustomText(txt: 'NoLessonsAvailable'.tr,
                                                          txtAlign: TextAlign.center,));
                                                  }
                                                },
                                                child: DropdownButton(
                                                  items: _courseDetailsCont.getLessonList(index)
                                                      .map((appointmentType) {
                                                    return DropdownMenuItem(
                                                      value: appointmentType.name,
                                                      child: InkWell(
                                                        onTap: (){
                                                          if(_courseDetailsCont.lessonDataResData.prevTest != null){
                                                            Get.snackbar('', '',backgroundColor: ConstStyles.DarkColor,
                                                                colorText: ConstStyles.WhiteColor,
                                                                titleText: CustomText(txt: 'YouShouldPassTheChapterExamFirst'.tr,
                                                                  txtAlign: TextAlign.center,));
                                                          }else{
                                                            _courseDetailsCont.getLessonData(appointmentType.key, _courseDetailsCont.token);
                                                          }
                                                        },
                                                        child: Container(
                                                          width: localW * 0.3,
                                                          child: GetBuilder<CourseDetailsCont>(
                                                            builder: (_){
                                                              return CustomText(
                                                                txt: appointmentType.name,
                                                                fontSize: localW * 0.03,
                                                                txtColor:
                                                                ConstStyles.WhiteColor,
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ),);
                                                  }).toList(),
                                                  onChanged: (value) {
                                                  },
                                                  dropdownColor: ConstStyles.BlueColor,
                                                  icon: Icon(Icons.arrow_drop_down_circle),
                                                  iconEnabledColor:
                                                  ConstStyles.WhiteColor,
                                                  elevation: 0,

                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        //TODO Chapter Quiz Btn
                                        GetBuilder<CourseDetailsCont>(builder: (_){
                                          if( _courseDetailsCont.courseDetailsResData.chapters[index] != null &&
                                              _courseDetailsCont.courseDetailsResData.chapters[index].quiz){
                                            return OrangeBtn(text: 'ChapterQuiz'.tr, onClick: (){
                                              _courseDetailsCont.getCourseQuizChapter(
                                                  _courseDetailsCont.courseDetailsResData.chapters[index].key,
                                                  _courseDetailsCont.token,
                                                  _courseDetailsCont.courseDetailsResData.chapters[index].name);

                                            });
                                          }else{
                                            return Container();
                                          }
                                        })
                                      ],
                                    ),
                                  );

                                },
                                itemCount: _courseDetailsCont.courseDetailsResData.chapters.length,),
                            ),
                          ),
*/

                          //TODO Lesson Objectives
                          Container(
                            child: GetBuilder<CourseDetailsCont>(builder: (_){
                              if(_courseDetailsCont.lessonDataResData.objective == null){
                                return Container();
                              }else{
                                return Container(
                                  padding: EdgeInsets.only(top: localH * 0.02),
                                  color: ConstStyles.WhiteColor,
                                  margin: EdgeInsets.only(left: localW * 0.03,right: localW * 0.03,top: localH * 0.01),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      //TODO Lesson Data Name
                                      // CustomText(txt: _courseDetailsCont.lessonDataResData.name,txtColor: ConstStyles.TextColor,fontSize: localW * 0.05,),
                                      // SizedBox(height: localH * 0.015,),


                                      //TODO Lesson Material
                                      // SizedBox(
                                      //   width: localW,
                                      //   child: Row(
                                      //     crossAxisAlignment: CrossAxisAlignment.center,
                                      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      //     children: [
                                      //       //TODO Download Material
                                      //       SizedBox(
                                      //         child: OrangeBtn(text: 'DownloadMaterial'.tr,onClick: ()async{
                                      //           if(await _courseDetailsCont.downloadMaterial(_courseDetailsCont.lessonDataResData.material)){
                                      //             Get.snackbar('', '',backgroundColor: ConstStyles.DarkColor,
                                      //                 colorText: ConstStyles.WhiteColor,
                                      //                 titleText: CustomText(txt: 'SuccessfullyDownloadedMaterial'.tr,
                                      //                   txtAlign: TextAlign.center,));
                                      //           }else{
                                      //             Get.snackbar('', '',backgroundColor: ConstStyles.DarkColor,
                                      //                 colorText: Colors.red,
                                      //                 titleText: CustomText(txt: 'SomethingWentWrongDownloadAgain'.tr,
                                      //                   txtAlign: TextAlign.center,));
                                      //           }
                                      //         },),
                                      //       ),
                                      //
                                      //       //TODO Next Lesson
                                      //       GetBuilder<CourseDetailsCont>(builder: (_){
                                      //         return SizedBox(
                                      //           child: OrangeBtn(text: 'NextLesson'.tr, onClick: (){
                                      //             //TODO Show Dialog
                                      //             showDialog(
                                      //                 context: context,
                                      //                 builder: (context){
                                      //                   return GetBuilder<ModalHudCont>(builder: (_){
                                      //                     return ModalProgressHUD(
                                      //                       inAsyncCall: _courseDetailsCont.modalHudController.isLoading,
                                      //                       child: GetBuilder<CourseDetailsCont>(builder: (_){
                                      //                         //TODO Dialog
                                      //                         return AlertDialog(
                                      //                           content: Container(
                                      //                             height:localH,
                                      //                             width : localW,
                                      //                             child: Center(
                                      //                               child: ListView(
                                      //                                 children: [
                                      //                                   CustomText(txt: 'Summary'.tr,txtColor: ConstStyles.OrangeColor,fontWeight: FontWeight.bold,fontSize: localW * 0.06,),
                                      //                                   Divider(
                                      //                                     thickness: 1,
                                      //                                     color: ConstStyles.OrangeColor,
                                      //                                   ),
                                      //
                                      //                                   Html(data: _courseDetailsCont.lessonDataResData.summary == null ? ' ' :_courseDetailsCont.lessonDataResData.summary ,),
                                      //                                   GetBuilder<CourseDetailsCont>(builder: (_){
                                      //                                     print(' GetBuilder Check Lesson Closed = ${_courseDetailsCont.lessonDataResData.lessonClosed}');
                                      //
                                      //                                     if(!_courseDetailsCont.lessonDataResData.endQuizLesson){
                                      //                                       return OrangeBtn(text: 'LessonExam'.tr, onClick: (){
                                      //                                         //TODO Open Lesson Exam
                                      //                                         print('LessonExam Key:: ${_courseDetailsCont.lessonDataResData.key}');
                                      //                                         Get.back();
                                      //                                         _courseDetailsCont.getCourseQuizLesson(_courseDetailsCont.lessonDataResData.key, _courseDetailsCont.token);
                                      //                                       });
                                      //                                     }else{
                                      //                                       return OrangeBtn(text: 'NextLesson'.tr, onClick: (){
                                      //                                         //TODO Open Next Lesson
                                      //                                         if(_courseDetailsCont.lessonDataResData.nextLesson != null){
                                      //                                           Get.back();
                                      //                                           _courseDetailsCont.getLessonData(_courseDetailsCont.lessonDataResData.nextLesson, _courseDetailsCont.token);
                                      //                                         }else{
                                      //                                           Get.back();
                                      //                                           Get.snackbar('', '',backgroundColor: ConstStyles.DarkColor,
                                      //                                               colorText: ConstStyles.WhiteColor,
                                      //                                               titleText: CustomText(txt: 'NoNextLessonAvailable'.tr,
                                      //                                                 txtAlign: TextAlign.center,));
                                      //                                         }
                                      //                                       });
                                      //                                     }
                                      //                                   }),
                                      //                                 ],
                                      //                               ),
                                      //                             ),
                                      //                           ),
                                      //                         );
                                      //                       },),
                                      //                     );
                                      //                   },);
                                      //                 });
                                      //           },),
                                      //         );
                                      //       }),
                                      //
                                      //     ],
                                      //   ),
                                      // ),
                                      SizedBox(height: localH * 0.015,),

                                      //TODO Lesson Objectives
                                      CustomText(txt: 'Objectives'.tr,txtColor: ConstStyles.BlackColor,fontSize: localW * 0.06,fontWeight: FontWeight.bold),
                                      Directionality(
                                          textDirection: TextDirection.ltr,
                                          child: Html(data: _courseDetailsCont.lessonDataResData.objective,)),
                                      SizedBox(height: localH * 0.015,),


                                    ],
                                  ),
                                );
                              }
                            }),
                          ),

                          //TODO Course OverView
                          Container(
                            // margin: EdgeInsets.only(left: localW * 0.15,right: localW * 0.15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(height: localH * 0.04,),

                                //TODO Course Overview
                                Container(
                                  color: ConstStyles.WhiteColor,
                                  padding: EdgeInsets.only(top: localH *0.03,bottom: localH *0.01,left: localW *0.01,right: localW *0.01),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      CustomText(
                                        txt: 'CourseOverView'.tr,
                                        txtColor: ConstStyles.DarkColor,
                                        fontSize: localW * 0.07,
                                      ),

                                      SizedBox(height: localH * 0.02,),
                                      Directionality(
                                        textDirection: TextDirection.ltr,
                                        child: Html(data: _courseDetailsCont.courseDetailsResData.description == null ? ''
                                            : _courseDetailsCont.courseDetailsResData.description,),
                                      )

                                    ],
                                  ),
                                ),


                                SizedBox(height: localH * 0.05,),

                                //TODO Requirements
                                Container(
                                  width: localW,
                                  color: ConstStyles.WhiteColor,
                                  padding: EdgeInsets.only(top: localH *0.03,bottom: localH *0.01,left: localW *0.01,right: localW *0.01),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      CustomText(
                                        txt: 'Requirements'.tr,
                                        txtColor: ConstStyles.DarkColor,
                                        fontSize: localW * 0.07,
                                      ),
                                      SizedBox(height: localH * 0.02,),
                                      Directionality(
                                        textDirection: TextDirection.ltr,
                                        child: Container(
                                            child: Html(
                                              data: _courseDetailsCont.courseDetailsResData.requirements == null ? ''
                                                  : _courseDetailsCont.courseDetailsResData.requirements,)
                                        ),
                                      ),
                                    ],
                                  ),
                                ),


                                SizedBox(height: localH * 0.05,),

                                //TODO What you will learn
                                Container(
                                  width: localW,
                                  color: ConstStyles.WhiteColor,
                                  padding: EdgeInsets.only(top: localH *0.03,bottom: localH *0.01,left: localW *0.01,right: localW *0.01),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      CustomText(
                                        txt: 'WhatYouWillLearn'.tr,
                                        txtColor: ConstStyles.DarkColor,
                                        fontSize: localW * 0.07,
                                        txtAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: localH * 0.02,),
                                      Directionality(
                                        textDirection: TextDirection.ltr,
                                        child: Html(data: _courseDetailsCont.courseDetailsResData.whatWillLearn == null ? ''
                                            : _courseDetailsCont.courseDetailsResData.whatWillLearn),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //TODO Instructors
                          Container(
                            color: ConstStyles.WhiteColor,
                            margin: EdgeInsets.only(left: localW * 0.15,right: localW * 0.15,top: localH * 0.015,bottom: localH * 0.02),
                            height: localH * 0.3,
                            padding: EdgeInsets.only(left: localW * 0.01,right: localW * 0.01),
                            child: GetBuilder<CourseDetailsCont>(
                              builder: (_){
                                if(_courseDetailsCont.courseDetailsResData.teachers != null &&
                                    _courseDetailsCont.courseDetailsResData.teachers.length >0){
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: localW * 0.01,top: localH * 0.005),
                                        height: localH * 0.05,
                                        child: CustomText(
                                          txt: 'Teachers'.tr,
                                          txtColor: ConstStyles.DarkColor,
                                          fontSize: localW * 0.07,
                                          txtAlign: TextAlign.center,
                                        ),
                                      ),

                                      SizedBox(
                                        height: localH * 0.24,
                                        child: ListView.builder(
                                          itemCount: _courseDetailsCont.courseDetailsResData.teachers.length,
                                          itemBuilder: (context,index){
                                            return Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [

                                                    //TODO Teacher Image
                                                    SizedBox(
                                                      height: localH * 0.1,
                                                      width: localW * 0.1,
                                                      child: GetBuilder<CourseDetailsCont>(builder: (_){
                                                        if(_courseDetailsCont.courseDetailsResData.teachers !=null &&
                                                            _courseDetailsCont.courseDetailsResData.teachers[index].image !=null){
                                                          return Container(
                                                            decoration: BoxDecoration(
                                                              image: DecorationImage(
                                                                image: NetworkImage("${EndPoints.ImageUrl}${_courseDetailsCont.courseDetailsResData.teachers[index].image}"),
                                                                fit: BoxFit.contain,
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                        else {
                                                          return    SizedBox(
                                                            width: localW * 0.25,
                                                            child: CircleAvatar(
                                                              radius: 50,
                                                              backgroundColor:
                                                              ConstStyles
                                                                  .WhiteColor,
                                                              child: LogoContainer(),
                                                            ),
                                                          );
                                                        }
                                                      }),
                                                    ),

                                                    //TODO Teacher Name
                                                    SizedBox(

                                                      child: AutoTextSize(text: _courseDetailsCont.courseDetailsResData.teachers[index].name == null
                                                          ? '' : _courseDetailsCont.courseDetailsResData.teachers[index].name,textColor: ConstStyles.BlackColor,
                                                        fontWeight: FontWeight.bold,),
                                                    ),

                                                    //TODO Teacher Qualifications
                                                    SizedBox(

                                                      child: AutoTextSize(text: _courseDetailsCont.courseDetailsResData.teachers[index].qualifications == null
                                                          ? '' : _courseDetailsCont.courseDetailsResData.teachers[index].qualifications,textColor: ConstStyles.BlackColor,
                                                        fontWeight: FontWeight.bold,),
                                                    ),

                                                  ],
                                                ),
                                                Container(
                                                  child: Divider(
                                                    thickness: 2,
                                                    color: ConstStyles.OrangeColor,
                                                  ),
                                                ),

                                              ],
                                            );
                                          },),
                                      ),
                                    ],
                                  );
                                }else{
                                  return LogoContainer();
                                }
                              },
                            ),
                          )


                        ],
                      );
                    },
                  );
                },
                ),
              ),
            );
          },
        ),
      ),
    );
  }



}

class myItem{
  bool isExpanded;
  final String header;
  final List<LessonsList> body;

  myItem({this.isExpanded : true, this.header, this.body});
}
