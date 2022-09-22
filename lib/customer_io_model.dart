class CustomerIOModel {
  String? apiKey;
  String? siteId;

  CustomerIOModel({this.apiKey, this.siteId});

  CustomerIOModel.fromJson(Map<String, dynamic> json) {
    apiKey = json['apiKey'];
    siteId = json['siteId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['apiKey'] = apiKey;
    data['siteId'] = siteId;
    return data;
  }
}