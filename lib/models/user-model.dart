// ignore_for_file: public_member_api_docs, sort_constructors_first

class User {
  final String name;
  final String familyName; // Optional family name
  final String email;
  final String type;

  User({
    required this.name,
    required this.email,
    required this.familyName,
    required this.type,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json['name'] as String,
        email: json['email'] as String,
        familyName: json['familyName'] as String,
        type: json['type'] as String,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'familyName': familyName,
        'userType': type,
      };
}

class Organizer extends User {
  final String orgName;
  final String profilePic;
  Organizer(
      {required super.name,
      required super.email,
      required super.familyName,
      super.type = 'organizer',
      required this.orgName,
      required this.profilePic});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'familyName': familyName,
      'type': type,
      'orgName': orgName,
      'profilePic': profilePic,
    };
  }

  factory Organizer.fromMap(Map<String, dynamic> map) {
    return Organizer(
        name: map['name'] as String,
        email: map['email'] as String,
        familyName: map['familyName'] as String,
        type: map['type'] as String,
        orgName: map['orgName'] as String,
        profilePic: map['profilePic'] as String);
  }
}

class Agent extends User {
  final String orgId;
  Agent(
      {required super.name,
      required super.email,
      required super.familyName,
      super.type = 'agent',
      required this.orgId});
}

// factory User.fromFirestore(DocumentSnapshot doc) {
//   Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//   String userType = data['userType'] as String;

//   switch (userType) {
//     case 'organizer':
//       return Organizer.fromJson(data); 
//     case 'agent':
//       return Agent.fromJson(data); 
//     case 'admin':
//       return Admin.fromJson(data); 
//     default:
//       return User.fromJson(data); 
//   }
// }
