

//class AnnouncementProvider extends ChangeNotifier {
  // List<AnnouncementDB> announcementList = [];
  // final _businessService = BusinessService();

  // Future<void> getAllAnnouncements() async {
  //   announcementList = (await _businessService.getAllAnnouncements()).toList();
  //   print(announcementList);
  // }

  // void addAnnouncement(Map map) async {
  //   final announcement = await _businessService.createAnnouncement(
  //       to: map[toColumn],
  //       from: map[fromColumn],
  //       message: map[messageColumn],
  //       organisation_id: _businessService.orgId);
  //   announcementList.add(announcement);
  //   notifyListeners();
  // }

  // void deleteAnnouncement(AnnouncementDB announcement) {
  //   announcementList.removeWhere((element) => element.id == announcement.id);
  //   notifyListeners();
  // }

  // String? depart;

  // //  //String sender  --- applied after backend

  // void departChange(String? value) {
  //   depart = value;
  //   notifyListeners();
  // }
//}
