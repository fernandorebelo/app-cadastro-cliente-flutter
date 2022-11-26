import 'package:flutter/material.dart';
import 'package:web_api_cadastro/model/cidade.dart';
import 'package:web_api_cadastro/paginas/cadastroCidade.dart';
import 'package:web_api_cadastro/paginas/cadastroCliente.dart';
import 'package:web_api_cadastro/paginas/consultaCidade.dart';
import 'package:web_api_cadastro/paginas/consultaCliente.dart';
import 'package:web_api_cadastro/paginas/consultarClientePorCidade.dart';
import 'package:web_api_cadastro/paginas/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App - Cadastro de Clientes',
      theme: ThemeData.dark(),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const Home(),
        '/cadastro-cliente': (context) => const CadastroCliente(),
        '/cadastro-cidade': (context) => const CadastroCidade(),
        '/consulta': (context) => const Consulta(),
        '/consulta-cidade': (context) => const ConsultaCidade(),
        '/consulta-cliente-cidade': (context) =>
            const ConsultaClientePorCidade(),
      },
    );
  }
}
