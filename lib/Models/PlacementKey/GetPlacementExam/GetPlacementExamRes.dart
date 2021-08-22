import 'package:troom/Models/PlacementKey/GetPlacementExam/GetPlacementExamResData.dart';

class GetPlacementExamRes {
  GetPlacementExamResData data;
  bool status;
  List<String> massage;

  GetPlacementExamRes({this.data, this.status, this.massage});

  GetPlacementExamRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new GetPlacementExamResData.fromJson(json['data']) : null;
    status = json['status'];
    massage = json['massage'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['status'] = this.status;
    data['massage'] = this.massage;
    return data;
  }
}