import 'package:mvvmapp/app/constants.dart';
import 'package:mvvmapp/app/extensions.dart';
import 'package:mvvmapp/domain/models/models.dart';

import '../response/responses.dart';

extension CustomerResponseMapper on CustomerResponse? {
  CustomerModel toDomain() {
    return CustomerModel(
      this?.id.nonNullable ?? Constants.emptyString,
      this?.name.nonNullable ?? Constants.emptyString,
      this?.numOfNotifications.nonNullable ?? Constants.zero,
    );
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  ContactsModel toDomain() {
    return ContactsModel(
      this?.phone.nonNullable ?? Constants.emptyString,
      this?.email.nonNullable ?? Constants.emptyString,
      this?.link.nonNullable ?? Constants.emptyString,
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

extension ForgotPasswordResponseMapper on ForgotPasswordResponse? {
  ForgotPasswordModel toDomain() {
    return ForgotPasswordModel(
      this?.oldPassword.nonNullable ?? Constants.emptyString,
      this?.newPassword.nonNullable ?? Constants.emptyString,
    );
  }
}
