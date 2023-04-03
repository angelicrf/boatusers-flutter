class UserProfileModel {
  final String buName;
  final String buPassword;
  final String id;
  UserProfileModel(
      {required this.id, required this.buName, required this.buPassword});
  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
        id: json['_id'],
        buName: json['buName'],
        buPassword: json['buPassword']);
  }
}
