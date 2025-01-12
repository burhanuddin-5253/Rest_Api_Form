class User {
  String firstName;
  String lastName;
  String? surName;
  String dateOfBirth;
  String gender;
  String email;
  String phoneNo;
  String? streetAddress;
  String? city;
  String? region;
  String? zipCode;
  String? country;
  String? profession;

  User({
    required this.firstName,
    required this.lastName,
    this.surName,
    required this.dateOfBirth,
    required this.gender,
    required this.email,
    required this.phoneNo,
    this.streetAddress,
    this.city,
    this.region,
    this.zipCode,
    this.country,
    this.profession,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      surName: json['surName'],
      dateOfBirth: json['dateOfBirth'] ?? '',
      gender: json['gender'] ?? '',
      email: json['email'] ?? '',
      phoneNo: json['phoneNo'] ?? '',
      streetAddress: json['streetAddress'],
      city: json['city'],
      region: json['region'],
      zipCode: json['zipCode'],
      country: json['country'],
      profession: json['profession'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'surName': surName,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'email': email,
      'phoneNo': phoneNo,
      'streetAddress': streetAddress,
      'city': city,
      'region': region,
      'zipCode': zipCode,
      'country': country,
      'profession': profession,
    };
  }
}
