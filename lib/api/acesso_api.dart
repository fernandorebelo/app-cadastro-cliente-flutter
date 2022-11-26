import 'dart:convert';

import 'package:http/http.dart';
import 'package:web_api_cadastro/model/cidade.dart';
import 'package:web_api_cadastro/model/cliente.dart';

//MÉTODOS PARA CIDADES
class AcessoApi {
  Future<List<Cidade>> listaCidades() async {
    String url = 'http://localhost:8080/cidade';
    Response resposta = await get(Uri.parse(url));
    String jsonFormatadoUtf8 = (utf8.decode(resposta.bodyBytes));
    Iterable lista = json.decode(jsonFormatadoUtf8);
    List<Cidade> cidades =
        List<Cidade>.from(lista.map((c) => Cidade.fromJson(c)));
    return cidades;
  }

  Future<void> insereCidade(Map<String, dynamic> cidade) async {
    String url = 'http://localhost:8080/cidade';
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    await post(
      Uri.parse(url),
      headers: headers,
      body: json.encode(cidade),
    );
  }

  Future<void> alteraCidade(Map<String, dynamic> cidade) async {
    String url = 'http://localhost:8080/cidade';
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    await put(
      Uri.parse(url),
      headers: headers,
      body: json.encode(cidade),
    );
  }

  Future<void> deletaCidade(int id) async {
    String url = 'http://localhost:8080/cidade/excluir/$id';
    await delete(Uri.parse(url));
  }

  Future<List<Cidade>> pesquisarCidadePorUf(String uf) async {
    String url = 'http://localhost:8080/cidade/$uf';
    Response resposta = await get(Uri.parse(url));
    String jsonFormatadoUtf8 = (utf8.decode(resposta.bodyBytes));
    Iterable lista = json.decode(jsonFormatadoUtf8);
    List<Cidade> clientes =
        List<Cidade>.from(lista.map((e) => Cidade.fromJson(e)));
    return clientes;
  }

//MÉTODOS PARA CLIENTES
  Future<List<Cliente>> listaClientes() async {
    String url = 'http://localhost:8080/cliente';
    Response resposta = await get(Uri.parse(url));
    String jsonFormatadoUtf8 = (utf8.decode(resposta.bodyBytes));
    Iterable lista = json.decode(jsonFormatadoUtf8);
    List<Cliente> clientes =
        List<Cliente>.from(lista.map((c) => Cliente.fromJson(c)));
    return clientes;
  }

  Future<void> insereCliente(Map<String, dynamic> cliente) async {
    String url = 'http://localhost:8080/cliente';

    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    await post(
      Uri.parse(url),
      headers: headers,
      body: json.encode(cliente),
    );
  }

  Future<void> alteraCliente(Map<String, dynamic> cliente) async {
    String url = 'http://localhost:8080/cliente';
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    await put(
      Uri.parse(url),
      headers: headers,
      body: json.encode(cliente),
    );
  }

  Future<void> deletaCliente(int id) async {
    String url = 'http://localhost:8080/cliente/excluir/$id';
    await delete(Uri.parse(url));
  }

  Future<List<Cliente>> pesquisarClientePorCidade(String cidade) async {
    String url = 'http://localhost:8080/cliente/$cidade';
    Response resposta = await get(Uri.parse(url));
    String jsonFormatadoUtf8 = (utf8.decode(resposta.bodyBytes));
    Iterable lista = json.decode(jsonFormatadoUtf8);
    List<Cliente> clientes =
        List<Cliente>.from(lista.map((e) => Cliente.fromJson(e)));
    return clientes;
  }
}
