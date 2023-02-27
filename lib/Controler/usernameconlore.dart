import 'package:get/get.dart';
class usernameconlore extends GetxController
{
  int username=0;
@override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }


  @override
void onInit() {
  super.onInit();

}


  @override
  void onClose() {

    super.onClose();
  }
  void inchang(int x)
  {
    username=x;
  //  username++;
    update();
  }

}