
final User currentUser = User();

class User {
   String firstName="";
   String lastName="";
   String userName="";
   String email="";
   String phoneNumber="";
   String code="";
   String jsonToken="";
  bool islogin = false;

  bool isRegister = false;

  User();

  User.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }

  setToken(String token) {
    jsonToken = token;
  }
}
