import 'dart:convert';
import 'package:http/http.dart' as http;
import 'endereco.dart';

class EnderecosApi {
  static Future<List<Endereco>> consultarEndereco(
      String estado, String cidade, String logradouro) async {
    List<Endereco> enderecos = [];
    final resposta = await http
        .get("https://viacep.com.br/ws/$estado/$cidade/$logradouro/json/");
    List<dynamic> lista = jsonDecode(resposta.body);
    lista.forEach((element) {
      enderecos.add(Endereco.fromJson(element));
    });

    return enderecos;
  }
}
