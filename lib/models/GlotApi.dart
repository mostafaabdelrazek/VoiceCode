
import 'package:http/http.dart' as http;
import 'dart:convert';


class GlotApi{
  static const _apiKey = 'b2b57cb5-7c99-4c52-a306-f6b884510cd6';
  var _data;
  var _url;
  final language;
  Map<String ,String> _head = {
    'Content-type': 'application/json',
    'Authorization' : _apiKey
  };
  GlotApi(this.language){
    _url = "https://run.glot.io/languages/$language/latest";
  }
  void filedata(String fileNameWithExtension , String fileContent ){
    _data = json.encode({
      //"language": "$language", "title": "$u.id", "public": true,
      "files": [{"name": "$fileNameWithExtension","content": "$fileContent"}]
    });
  }
  Future<String> getResponse() async{
    http.Response response = await http.post(
        Uri.parse(_url),
      body: _data,
      headers: _head
    );
    return response.body;
  }
}