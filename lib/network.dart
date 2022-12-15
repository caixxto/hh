import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:html/parser.dart';

class Network {
  static Dio dio = Dio();

  Network._();

  static Network _instance = Network._();

  static Network get instance => _instance;

  void create() async {
    var dio = Dio(BaseOptions(
        connectTimeout: 1000,
        receiveTimeout: 1000,
        sendTimeout: 1000,
        responseType: ResponseType.json,
        followRedirects: false,
        validateStatus: (status) {
          return true;
        }
    ));
  }

  Future<String> search(request, id) async {
    //create();
    //dio.interceptors.add(CookieManager(CookieJar()));
    var resp = await dio.get('https://hh.ru/search/vacancy?no_magic=true&L_save_area=true&text=$request&excluded_text=&salary=&currency_code=RUR&experience=doesNotMatter&order_by=relevance&search_period=0&items_on_page=20&page=0&hhtmFrom=vacancy_search_list');
    return resp.data;
  }

  Future<String> searchFromPages(request, id) async {
    var resp = await dio.get('https://hh.ru/search/vacancy?no_magic=true&L_save_area=true&text=$request&excluded_text=&salary=&currency_code=RUR&experience=doesNotMatter&order_by=relevance&search_period=0&items_on_page=20&page=$id&hhtmFrom=vacancy_search_list');
    return resp.data;
  }

}