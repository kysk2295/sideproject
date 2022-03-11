class User{
  final String name;
  final String email;
  final String password;
  final String bankType;
  final String account;

  User({required this.name, required this.email, required this.password,
  required this.bankType, required this.account});

  factory User.fromJson(Map<String,dynamic> json){
    return User(
        name:json['name'],
        email:json['email'],
        password:json['password'],
        bankType:json['bankType'],
        account:json['account'],
    );
  }
}