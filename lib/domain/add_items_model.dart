class AddItems {
  bool? result;
  String? message;
  var token;

  AddItems({this.result, this.message, this.token});

  AddItems.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['message'] = message;
    data['token'] = token;
    return data;
  }
}
