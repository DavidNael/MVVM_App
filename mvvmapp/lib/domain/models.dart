//onBoarding Models
class SliderObject {
  String title;
  String subTitle;
  String image;
  SliderObject(this.title, this.subTitle, this.image);
}
class SliderViewObject{
  SliderObject sliderObject;
  int numOfPages;
  int currentPageIndex;
  SliderViewObject(this.sliderObject, this.numOfPages, this.currentPageIndex);
}