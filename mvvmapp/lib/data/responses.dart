import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'message')
  String? message;
}
@JsonSerializable()
class CustomerResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'numOfNotifications')
  int? numOfNotifications;
  CustomerResponse({this.id, this.name, this.numOfNotifications});
}
@JsonSerializable()
class ContactsResponse {
  @JsonKey(name: 'phone')
  int? phone;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'link')
  int? link;
  ContactsResponse({this.phone, this.email, this.link});
}
@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: 'customer')
  CustomerResponse? customer;
  @JsonKey(name: 'contacts')
  ContactsResponse? contacts;
  AuthenticationResponse({this.customer, this.contacts});
}
