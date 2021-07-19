class LoginOTD {
  final String name;
  final String phone;
  final String id;
  LoginOTD({this.name, this.phone, this.id});

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'phone': phone};
}
