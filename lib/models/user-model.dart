class User {
  final String userId;
  final String name;
  final String? familyName; // Optional family name
  final String userType;
  final String? nationality; // Optional nationality
  final String? mobileNumber; // Optional mobile number
  final String? gender; // Optional gender
  final Map<String, dynamic>? privateData; // Optional private data

  User({
    required this.userId,
    required this.name,
    this.familyName,
    required this.userType,
    this.nationality,
    this.mobileNumber,
    this.gender,
    this.privateData,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json['userId'] as String,
        name: json['name'] as String,
        familyName: json['familyName'] as String?,
        userType: json['userType'] as String,
        nationality: json['nationality'] as String?,
        mobileNumber: json['mobileNumber'] as String?,
        gender: json['gender'] as String?,
        privateData: json['privateData'] as Map<String, dynamic>?,
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'name': name,
        'familyName': familyName,
        'userType': userType,
        'nationality': nationality,
        'mobileNumber': mobileNumber,
        'gender': gender,
        'privateData': privateData,
      };
}
