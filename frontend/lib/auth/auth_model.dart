class AuthModel {
  final String id;
  final String username;
  final String password;
  final String status;
  final String roles;
  String _loginStatus = 'loggedOut';

  AuthModel(
      {this.id = "",
      required this.username,
      required this.password,
      this.roles = 'user',
      this.status = 'unblocked',
      String loginStatus = 'loggedOut'})
      : _loginStatus = loginStatus;

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      id: json['_id'],
      username: json['username'],
      password: json['password'],
      roles: json['roles'][0],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'password': password,
        'roles': [roles],
        'status': status,
      };

  String get loginStatus => _loginStatus;
  set loginStatus(String newLoginStatus) {
    _loginStatus = newLoginStatus;
  }
}
