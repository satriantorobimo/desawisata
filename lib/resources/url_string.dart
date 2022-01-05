class UrlString {
  final String baseUrlGw = 'https://desawisata.kemendesa.go.id:8443/';

  static Map<String, String> headerTypeWithToken(String _token) => {
        'Authorization': 'Bearer $_token',
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      };

  static Map<String, String> headerTypeBasic() =>
      {'Content-Type': 'application/json', 'Accept': 'application/json'};

  static Map<String, String> headerTypeBasicForm() => {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json'
      };

  static Map<String, String> headerTypeBasicFormWithToken(String _token) => {
        'Authorization': 'Bearer $_token',
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json'
      };

  Map<String, String> getHeaderTypeBasic() {
    return headerTypeBasic();
  }

  Map<String, String> getHeaderTypeBasicForm() {
    return headerTypeBasicForm();
  }

  Map<String, String> getHeaderTypeWithToken(String _token) {
    return headerTypeWithToken(_token);
  }

  Map<String, String> getHeaderTypeBasicFormWithToken(String _token) {
    return headerTypeBasicFormWithToken(_token);
  }

  //URL Get Image Intro
  static String urlGetIntro() => 'intro';

  String getUrlImageIntro() {
    final String urlGetIntro2 = urlGetIntro();
    return baseUrlGw + urlGetIntro2;
  }

  //URL Get Image Onboarding
  static String urlGetOnboarding() => 'onboarding';

  String getUrlGetOnboarding() {
    final String urlGetOnboarding2 = urlGetOnboarding();
    return baseUrlGw + urlGetOnboarding2;
  }

  //URL Get Register
  static String urlGetRegister() => 'register';

  String getUrlRegister() {
    final String urlGetRegister2 = urlGetRegister();
    return baseUrlGw + urlGetRegister2;
  }

  //URL Get Register Google
  static String urlGetRegisterGoogle(String token) =>
      'auth/google/callback/$token';

  String getUrlRegisterGoogle(String token) {
    final String urlGetRegisterGoogle2 = urlGetRegisterGoogle(token);
    return baseUrlGw + urlGetRegisterGoogle2;
  }

  //URL Get Register Facebook
  static String urlGetRegisterFb(String token) =>
      'auth/facebook/callback/$token';

  String getUrlRegisterFb(String token) {
    final String urlGetRegisterFb2 = urlGetRegisterFb(token);
    return baseUrlGw + urlGetRegisterFb2;
  }

  //URL Get Login
  static String urlGetLogin() => 'auth/login';

  String getUrlLogin() {
    final String urlGetLogin2 = urlGetLogin();
    return baseUrlGw + urlGetLogin2;
  }

  //URL Get Higlight
  static String urlGetHighlight() => 'highlight';

  String getUrlHighlight() {
    final String urlGetHighlight2 = urlGetHighlight();
    return baseUrlGw + urlGetHighlight2;
  }

  //URL Get Higlight
  static String urlGetCategoryHome() => 'categories';

  String getUrlCategoryHome() {
    final String urlGetCategoryHome2 = urlGetCategoryHome();
    return baseUrlGw + urlGetCategoryHome2;
  }

  //URL Get Popular
  static String urlGetPopular() => 'popular';

  String getUrlPopular() {
    final String urlGetPopular2 = urlGetPopular();
    return baseUrlGw + urlGetPopular2;
  }

  //URL Get Total Per Kab
  static String urlGetTotalPerKab() => 'total/per-kab';

  String getUrlTotalPerKab() {
    final String urlGetTotalPerKab2 = urlGetTotalPerKab();
    return baseUrlGw + urlGetTotalPerKab2;
  }

  //URL Get Tempat Detail
  static String urlGetTempatDetail(String id, String time, String day) =>
      'wisata/detail/$id?time=$time&day=$day';

  String getUrlTempatDetail(String id, String time, String day) {
    final String urlGetTempatDetail2 = urlGetTempatDetail(id, time, day);
    return baseUrlGw + urlGetTempatDetail2;
  }

  //URL Get Desa Detail
  static String urlGetDesaDetail(String id) => 'wisata/desa/detail/$id';

  String getUrlDesaDetail(String id) {
    final String urlGetDesaDetail2 = urlGetDesaDetail(id);
    return baseUrlGw + urlGetDesaDetail2;
  }

  //URL Get Review
  static String urlGetReview(String id, int limit, int page) =>
      'wisata/review/list?wisata_id=$id&limit=$limit&page=$page';

  String getUrlReview(String id, int limit, int page) {
    final String urlGetReview2 = urlGetReview(id, limit, page);
    return baseUrlGw + urlGetReview2;
  }

  //URL Get Review
  static String urlGetLikes(String id, String imei) =>
      'wisata/like/me?wisata_id=$id&imei=$imei';

  String getUrlGetLikes(String id, String imei) {
    final String urlGetLikes2 = urlGetLikes(id, imei);
    return baseUrlGw + urlGetLikes2;
  }

  //URL Get Review
  static String urlSubmitLikes() => 'wisata/like/store';

  String getUrlSubmitLikes() {
    final String urlSubmitLikes2 = urlSubmitLikes();
    return baseUrlGw + urlSubmitLikes2;
  }

  //URL Get Question
  static String getPertanyaan(String id, int limit, int page) =>
      'wisata/question/list?wisata_id=$id&limit=$limit&page=$page';

  String urlGetPertanyaan(String id, int limit, int page) {
    final String getPertanyaan2 = getPertanyaan(id, limit, page);
    return baseUrlGw + getPertanyaan2;
  }

  //URL Get Review
  static String urlGetListDesa(String id, int limit, int page) =>
      'wisata/list?kab_id=$id&limit=$limit&page=$page';

  String getUrlGetListDesa(String id, int limit, int page) {
    final String urlGetListDesa2 = urlGetListDesa(id, limit, page);
    return baseUrlGw + urlGetListDesa2;
  }

  //URL Get List Category
  static String urlGetListCategory(String id, int limit, int page) =>
      'wisata/list/category?category_id=$id&limit=$limit&page=$page';

  String getUrlGetListCategory(String id, int limit, int page) {
    final String urlGetListCategory2 = urlGetListCategory(id, limit, page);
    return baseUrlGw + urlGetListCategory2;
  }

  //URL Get Search
  static String urlGetSearch(String value) => 'wisata/search?q=$value&limit=20';

  String getUrlSearch(String value) {
    final String urlGetSearch2 = urlGetSearch(value);
    return baseUrlGw + urlGetSearch2;
  }

  //URL Submit Review
  static String urlSubmitReview() => 'wisata/review/store';

  String getUrlSubmitReview() {
    final String urlSubmitReview2 = urlSubmitReview();
    return baseUrlGw + urlSubmitReview2;
  }

  //URL Get Reff Kunjugan
  static String urlGetReffKunjungan() => 'reff/kunjungan';

  String getUrlReffKunjungan() {
    final String urlGetReffKunjungan2 = urlGetReffKunjungan();
    return baseUrlGw + urlGetReffKunjungan2;
  }

  //URL Get Akun
  static String urlGetAkun() => 'auth/me';

  String getUrlGetAkun() {
    final String urlGetAkun2 = urlGetAkun();
    return baseUrlGw + urlGetAkun2;
  }

//URL  Logout
  static String urlLogOut() => 'auth/logout';

  String getUrlLogOut() {
    final String urlLogOut2 = urlLogOut();
    return baseUrlGw + urlLogOut2;
  }

  //URL Get My Question
  static String urlMyQuestion(int limit, int page) =>
      'wisata/question/me?limit=$limit&page=$page';

  String getUrlMyQuestion(int limit, int page) {
    final String urlMyQuestion2 = urlMyQuestion(limit, page);
    return baseUrlGw + urlMyQuestion2;
  }

  //URL Get My Review
  static String urlMyReview(int limit, int page) =>
      'wisata/review/me?limit=$limit&page=$page';

  String getUrlMyReview(int limit, int page) {
    final String urlMyReview2 = urlMyReview(limit, page);
    return baseUrlGw + urlMyReview2;
  }

  //URL Get Refresh
  static String urlRefresh() => 'auth/refresh';

  String getUrlRefresh() {
    final String urlRefresh2 = urlRefresh();
    return baseUrlGw + urlRefresh2;
  }

  //URL Get Refresh
  static String urlSubmitQuestion() => 'wisata/question/store';

  String getUrlSubmitQuestion() {
    final String urlSubmitQuestion2 = urlSubmitQuestion();
    return baseUrlGw + urlSubmitQuestion2;
  }
}
