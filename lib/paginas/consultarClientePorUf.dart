import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:web_api_cadastro/model/cidade.dart';
import 'package:web_api_cadastro/model/cliente.dart';
import 'package:web_api_cadastro/util/combo_cidade.dart';
import 'package:web_api_cadastro/util/componentes.dart';

class ConsultaClientePorUf extends StatefulWidget {
  const ConsultaClientePorUf({super.key});

  @override
  State<ConsultaClientePorUf> createState() => _ConsultaClientePorUfState();
}

class _ConsultaClientePorUfState extends State<ConsultaClientePorUf> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController ufController = TextEditingController();

  rotaIconButton() {
    Navigator.of(context).pushReplacementNamed('/home');
  }

  pesquisarButton() {}

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Cliente;
    ufController.text = args.cidade.uf;

    return Scaffold(
      appBar: Componentes()
          .appBar(rotaIconButton, const Text('CONSULTAR CLIENTE POR UF')),
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            children: [
              ComboCidade(
                controller: ufController,
              ),
              Componentes()
                  .criaBotao('Pesquisar', pesquisarButton, 50, _formKey),
            ],
          ),
        ),
      ),
    );
  }
}
