import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:taskdemoproject/utils/enum/user_type_enum.dart';

import '../model/user_data_model.dart';

class UserDataController extends GetxController{

  TextEditingController nameController=TextEditingController();
  TextEditingController ageController=TextEditingController();
  TextEditingController mobileNoController=TextEditingController();
  TextEditingController addressController=TextEditingController();
  TextEditingController searchController=TextEditingController();

  RxList<UserDataModel> userDetailList=<UserDataModel>[].obs;
  RxList<UserDataModel> searchedUserDetailList=<UserDataModel>[].obs;
  RxBool isEdit=false.obs;
  RxBool isSearch=false.obs;
  var searchQuery = ''.obs;

  Rx<UserType> selectedUser = UserType.student.obs;

  void updateUserType(UserType userType) {
    selectedUser.value = userType;
  }

  void clearData(){
    nameController.clear();
    ageController.clear();
    mobileNoController.clear();
    addressController.clear();
  }

  void addDataIntoSearchList() {
     searchedUserDetailList.clear();
     searchedUserDetailList.addAll(userDetailList);
     searchedUserDetailList.refresh();
  }

}