class ContactModel {
  String firstName;
  String lastName;
  String email;
  String phone;
  bool favorite;

  ContactModel({
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.favorite,
  });

  ContactModel.fromMap(Map<String, dynamic> record) {
    firstName = record['firstname'] != null ? record['firstname'] : '';
    lastName = record['lastname'] != null ? record['lastname'] : '';
    email = record['email'] != null ? record['email'] : '';
    phone = record['phone'] != null ? record['phone'] : '';
    favorite = record['favorite'] != null ? record['favorite'] : false;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstname': firstName,
      'lastname': lastName,
      'email': email,
      'phone': phone,
      'favorite': favorite,
    };
  }
}
