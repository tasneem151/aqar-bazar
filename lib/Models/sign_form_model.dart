import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class SignFormModel {
  String firstName;
  String lastName;
  String email;
  String password;
  String phone;
  String countryCode;

  SignFormModel({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.phone,
    this.countryCode = "+90",
  });
}
