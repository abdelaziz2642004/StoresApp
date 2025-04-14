
abstract class Service {
  String _fullName = '';
  String? _gender;
  String _email = '';
  int _studentID = 0;
  int? level;
  String _password = '';
  String _confirmPassword = '';
  get fullName => _fullName;

  set fullName(value) => _fullName = value;

  get gender => _gender;

  set gender(value) => _gender = value;

  get email => _email;

  set email(value) => _email = value;

  get studentID => _studentID;

  set studentID(value) => _studentID = value;

  get getLevel => level;

  set setLevel(level) => level = level;

  get password => _password;

  set password(value) => _password = value;

  get confirmPassword => _confirmPassword;

  set confirmPassword(value) => _confirmPassword = value;
}
