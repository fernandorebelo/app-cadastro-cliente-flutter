import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:web_api_cadastro/api/acesso_api.dart';
import 'package:web_api_cadastro/model/cidade.dart';
import 'package:web_api_cadastro/model/cliente.dart';
import 'package:web_api_cadastro/util/combo_cidade.dart';
import 'package:web_api_cadastro/util/componentes.dart';
import 'package:web_api_cadastro/util/dropdown_estados.dart';

class ConsultaClientePorUf extends StatefulWidget {
  const ConsultaClientePorUf({super.key});

  @override
  State<ConsultaClientePorUf> createState() => _ConsultaClientePorUfState();
}

class _ConsultaClientePorUfState extends State<ConsultaClientePorUf> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController ufController = TextEditingController();

  List<Cliente> lista = [];
  // List<Cidade> lista = [];

  listarTodas() async {
    List<Cliente> clientes = await AcessoApi().listaClientes();
    setState(() {
      lista = clientes;
    });
  }

  // listarTodas() async {
  //   List<Cidade> cidades = await AcessoApi().listaCidades();
  //   setState(() {
  //     lista = cidades;
  //   });
  // }

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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownEstados(),
            ],
          ),
        ));
  }
}
