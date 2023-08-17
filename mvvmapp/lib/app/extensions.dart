import 'package:mvvmapp/app/constants.dart';

extension NonNullableString on String? {
  String get nonNullable => this ?? Constants.emptyString;
}
extension NonNullableInt on int? {
  int get nonNullable => this ?? Constants.zero;
}