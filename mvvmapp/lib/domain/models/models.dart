//onBoarding Models
class SliderObject {
  String title;
  String subTitle;
  String image;
  SliderObject(this.title, this.subTitle, this.image);
}

class SliderViewObject {
  SliderObject sliderObject;
  int numOfPages;
  int currentPageIndex;
  SliderViewObject(this.sliderObject, this.numOfPages, this.currentPageIndex);
}

class CustomerModel {
  String id;
  String name;
  int numOfNotifications;
  CustomerModel(this.id, this.name, this.numOfNotifications);
}

class ContactsModel {
  String phone;
  String email;
  String link;
  ContactsModel(this.phone, this.email, this.link);
}

class AuthenticationModel {
  CustomerModel? customer;
  ContactsModel? contacts;
  AuthenticationModel(this.customer, this.contacts);
}

class ForgotPasswordModel {
  String oldPassword;
  String newPassword;
  ForgotPasswordModel(this.oldPassword, this.newPassword);
}
