class ConstantApi{
  static late final String nameDomain;
  static late final String endPoint;

  static init({required String nameDomain, required String endPoint}) {
    ConstantApi.nameDomain = nameDomain;
    ConstantApi.endPoint = endPoint;
  }
}