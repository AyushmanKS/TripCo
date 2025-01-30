import 'package:get/get.dart';

class TripCompanionController extends GetxController {
  var selectedIndex = (-1).obs;
  var companions = <Member>[].obs;

  void toggleSelection(int index) {
    selectedIndex.value = index;
    companions.clear();

    if (index == 0) {
      // Solo - 1 person
      companions.add(Member(name: '', email: ''));
    } else if (index == 1) {
      // Couple - 2 persons
      companions.addAll([Member(name: '', email: ''), Member(name: '', email: '')]);
    } else if (index == 2) {
      // 2+ members - 3 persons mandatory
      companions.addAll([
        Member(name: '', email: ''),
        Member(name: '', email: ''),
        Member(name: '', email: '')
      ]);
    }
  }

  void addMember() {
    companions.add(Member(name: '', email: ''));
  }

  void removeMember(int index) {
    if (companions.length > 3) {
      companions.removeAt(index);
    }
  }

  void verifyMember(int index) {
    companions[index] = Member(
      name: companions[index].name,
      email: companions[index].email,
      isVerified: !companions[index].isVerified,
    );
  }

}

class Member {
  String name;
  String email;
  bool isVerified;

  Member({required this.name, required this.email, this.isVerified = false});
}
