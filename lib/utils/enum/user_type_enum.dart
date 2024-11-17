enum UserType{parent,teacher,student}

extension UserTypeExtension on UserType {
  String get toShortString {
    switch (this) {
      case UserType.parent:
        return "Parent";
      case UserType.teacher:
        return "Teacher";
      case UserType.student:
        return "Student";
      default:
        return '';
    }
  }
}




