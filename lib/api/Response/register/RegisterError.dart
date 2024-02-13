/// value : "011254785089"
/// msg : "accept only egypt phone numbers"
/// param : "phone"
/// location : "body"

class RegisterError {
  RegisterError({
    this.message,
    this.value,
      this.msg, 
      this.param, 
      this.location,});

  RegisterError.fromJson(dynamic json) {
    message = json['message'];
    value = json['value'];
    msg = json['msg'];
    param = json['param'];
    location = json['location'];
  }
  String? message;
  String? value;
  String? msg;
  String? param;
  String? location;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['value'] = value;
    map['msg'] = msg;
    map['param'] = param;
    map['location'] = location;
    return map;
  }

}