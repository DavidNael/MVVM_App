import 'package:mvvmapp/app/constants.dart';
import 'package:mvvmapp/app/extensions.dart';
import 'package:mvvmapp/domain/models/models.dart';

import '../response/responses.dart';

extension CustomerResponseMapper on CustomerResponse? {
  CustomerModel toDomain() {
    return CustomerModel(
      this?.id.nonNullable ?? Constants.zero,
      this?.name.nonNullable ?? Constants.emptyString,
      this?.numOfNotifications.nonNullable ?? Constants.zero,
    );
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  ContactsModel toDomain() {
    return ContactsModel(
      this?.phone.nonNullable ?? Constants.zero,
      this?.email.nonNullable ?? Constants.emptyString,
      this?.link.nonNullable ?? Constants.zero,
    );
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  AuthenticationModel toDomain() {
    return AuthenticationModel(
      this?.customer.toDomain(),
      this?.contacts.toDomain(),
    );
  }
}
