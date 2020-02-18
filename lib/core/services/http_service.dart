
import 'dart:async';

import 'package:ui_hlb_ekyc_mobile/core/exceptions/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class HttpService {

  final String domainBaseUrl = "http://oc.com";

  final String namespace = "api/v2";

  final httpClient = http.Client();

  String _buildURL(String url) => "${this.domainBaseUrl}/${this.namespace}/$url";

  Future<String> fetch({
    @required String url
  }) async {
    final requestUrl = _buildURL(url);
    final Map<String,String> headers = {
      'Content-Type': 'application/json',
    };
    final response = await httpClient.get(requestUrl, headers: headers);
    
    if (response.statusCode == 200) {
      return response.body;
    }
    if(response.statusCode == 400) {
      throw BadRequestException();
    }
    if(response.statusCode == 401) {
      throw UnAuthorizedException();
    }
    throw ServiceException(
      errorCode: response.statusCode,
      message: response.body.toString(),
    );
  }

  /*
   * 
   * @params { url } - request api/ resource url
   * @params { data } - request body data as Json <key, value> pair
   */
  Future<String> post({
    @required String url,
    @required Map<String, dynamic> data
  }) async {
    try {
      final requestUrl = _buildURL(url);
      final Map<String,String> headers = {
        'Content-Type': 'application/json',
      };
      final response = await httpClient.post(requestUrl, body: data?.toString(), headers: headers);
      
      if (response.statusCode == 200) {
        return response.body;
      }
      if(response.statusCode == 400) {
        throw BadRequestException();
      }
      if(response.statusCode == 401) {
        throw UnAuthorizedException();
      }
      throw ServiceException(
        errorCode: response.statusCode,
        message: response.body.toString(),
      );
    } catch(err) {
      print(err);
      throw err;
    }
  }
}