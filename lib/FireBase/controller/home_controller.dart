import 'package:email_firebase/FireBase/Model/home_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxMap userDetail = {}.obs;
  List<HomeModel> DataList = [];
  HomeModel updateData = HomeModel();
}
