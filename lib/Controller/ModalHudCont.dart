<<<<<<< HEAD
import 'package:get/get.dart';

class ModalHudCont extends GetxController{
  bool isLoading = false;
  String LOGD='ModalHudController';
  changeisLoading(bool vlaue) {
    isLoading = vlaue;
    update();
    print('$LOGD : $isLoading');
  }
=======
import 'package:get/get.dart';

class ModalHudCont extends GetxController{
  bool isLoading = false;
  String LOGD='ModalHudController';
  changeisLoading(bool vlaue) {
    isLoading = vlaue;
    update();
    print('$LOGD : $isLoading');
  }
>>>>>>> 8735c7c42bfa70f00bed54310f9a2134fdd3b0df
}