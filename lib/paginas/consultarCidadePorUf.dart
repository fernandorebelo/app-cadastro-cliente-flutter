import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:web_api_cadastro/api/acesso_api.dart';
import 'package:web_api_cadastro/model/cidade.dart';
import 'package:web_api_cadastro/util/componentes.dart';
import 'package:web_api_cadastro/util/dropdown_estados.dart';

class ConsultaCidadePorUf extends StatefulWidget {
  const ConsultaCidadePorUf({super.key});

  @override
  State<ConsultaCidadePorUf> createState() => _ConsultaCidadePorUfState();
}

class _ConsultaCidadePorUfState extends State<ConsultaCidadePorUf> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController ufController = TextEditingController();

  List<Cidade> lista = [];

  listarCidadePorUf() async {
    List<Cidade> cidades =
        await AcessoApi().pesquisarCidadePorUf(ufController.text);
    setState(() {
      lista = cidades;
    });
  }

  rotaIconButton() {
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Componentes()
          .appBar(rotaIconButton, const Text('CONSULTAR CIDADE POR UF')),
      body: Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Column(
              children: [
                Componentes().criaTexto('Selecione uma UF:'),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: DropdownEstados(controller: ufController),
                ),
                Componentes()
                    .criaBotao('Pesquisar', listarCidadePorUf, 50, _formKey),
                Componentes().criaTexto(
                    'Cidades encontradas: ${lista.length.toString()}'),
                Expanded(
                  child: ListView.builder(
                    itemCount: lista.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 6,
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Componentes().criaItemCidade(lista[index]),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
