import 'package:taskdemoproject/utils/enum/user_type_enum.dart';

class UserDataModel {
  String name, age, mobileNo, address;
  UserType userType;

  UserDataModel({
    required this.name,
    required this.age,
    required this.mobileNo,
    required this.address,
    required this.userType,
  });
}
