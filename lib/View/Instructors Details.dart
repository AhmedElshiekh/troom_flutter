import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:troom/Controller/HomePage/HomeCont.dart';
import 'package:troom/CustomViews/LogoContainer.dart';
import 'package:troom/Models/OurTeachers/OurTeachersDataList.dart';
import 'package:troom/Util/EndPoints.dart';

import 'Courses/CourseDetails.dart';
import 'Courses/CourseListItem.dart';
import 'LiveClasses/LiveCourseDetails.dart';
import 'LiveClasses/LiveCourseListItem.dart';

enum status { Courses, LiveCourses }

class Instructor extends StatefulWidget {
  OurTeachersDataList t;

  Instructor({this.t});

  @override
  _InstructorState createState() => _InstructorState();
}

class _InstructorState extends State<Instructor> {
  final HomeCont _homeCont = Get.put(HomeCont());

  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;
  status st = status.Courses;

  void changStatue() {
    if (st == status.Courses) {
      setState(() {
        st = status.LiveCourses;
      });
    } else {
      setState(() {
        st = status.Courses;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leading: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                image: DecorationImage(
                  image: NetworkImage(
                      EndPoints.ImageUrl + widget.t.image.toString()),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: Colors.black,
                ),
              )
            ],
            pinned: _pinned,
            centerTitle: false,
            snap: _snap,
            floating: _floating,
            expandedHeight: 300.0,
            flexibleSpace: const FlexibleSpaceBar(
              background: Image(
                image: AssetImage('assets/images/logo.png'),
                fit: BoxFit.contain,
              ),
            ),
            title: Text(
              widget.t.name,
              style:
                  TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.white,
            elevation: 5,
          ), const SliverToBoxAdapter(
            child: SizedBox(
              height: 30,
              child: Center(
                child: Text("Courses",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              ),
            ),
          ),

          SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              if (st == status.Courses) {
                return InkWell(
                  onTap: () {
                    Get.to(
                        () => CourseDetails(_homeCont.coursesList[index].key));
                  },

                  child: CourseListItem(

                      MediaQuery.of(context).size.height- 250,
                      MediaQuery.of(context).size.width ,
                      _homeCont.coursesList[index],
                      "${'EgyptianPound'.tr}"),
                );
              } else {
                if (_homeCont.liveCoursesList.length > 0) {

                  return InkWell(
                      onTap: () {
                        Get.to(() => LiveCourseDetails(
                            _homeCont.liveCoursesList[index].key));
                      },
                      child: LiveCourseListItem(

                          MediaQuery.of(context).size.height-250,
                          MediaQuery.of(context).size.width ,
                          _homeCont.liveCoursesList[index],
                          'EgyptianPound'.tr,
                          'More'.tr));
                } else  {
                  return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height*0.5,
                      child: LogoContainer(
                          // colors: ConstStyles.DarkColor,
                          ));
                }
              }
            }, childCount:st==status.Courses? _homeCont.coursesList.length:_homeCont.liveCoursesList.length),
          ),
        ],
      ),
      bottomNavigationBar: Container(
          height: 50,
          width: 80,
          child: Center(
            child: GestureDetector(
              onTap: changStatue,
              child: st == status.Courses
                  ? Text(
                      "${'AllLiveClasses'.tr}",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold),
                    )
                  : Text("${'Courses'.tr}",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold)),
            ),
          )),
    );
  }
}
