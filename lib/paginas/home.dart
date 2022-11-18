import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:web_api_cadastro/model/cidade.dart';
import 'package:web_api_cadastro/model/cliente.dart';
import 'package:web_api_cadastro/util/componentes.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();

  rotaIconButton() {
    Navigator.of(context).pushReplacementNamed('/home');
  }

  consultarClienteButton() {
    Navigator.of(context).pushReplacementNamed('/consulta');
  }

  consultarCidadeButton() {
    Navigator.of(context).pushReplacementNamed('/consulta-cidade');
  }

  cadastrarClienteButton() {
    Navigator.of(context).pushReplacementNamed('/cadastro-cliente',
        arguments: Cliente(0, '', 'M', 0, Cidade(0, '', '')));
  }

  cadastrarCidadeButton() {
    Navigator.of(context)
        .pushReplacementNamed('/cadastro-cidade', arguments: Cidade(0, '', ''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Componentes()
            .appBar(rotaIconButton, const Text('SISTEMA DE CLIENTES - API')),
        body: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: SizedBox(
                    width: 400,
                    child: Column(
                      children: [
                        Componentes().criaTexto('Consultas'),
                        Componentes().criaBotao('Consultar Clientes',
                            consultarClienteButton, 50, _formKey),
                        Componentes().criaBotao('Consultar Cidades',
                            consultarCidadeButton, 50, _formKey),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: SizedBox(
                    width: 400,
                    child: Column(
                      children: [
                        Componentes().criaTexto('Cadastros'),
                        Componentes().criaBotao('Cadastrar Cliente',
                            cadastrarClienteButton, 50, _formKey),
                        Componentes().criaBotao('Cadastrar Cidade',
                            cadastrarCidadeButton, 50, _formKey),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
