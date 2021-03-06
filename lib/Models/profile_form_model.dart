class ProfileFormModel {
  String name;
  String email;
  String phoneNumber;
  String password;

  ProfileFormModel(
      {this.name = 'username',
      this.email = 'username@email.com',
      this.phoneNumber = '+99999999',
      this.password = '******'});
}
