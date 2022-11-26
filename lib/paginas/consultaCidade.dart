import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:web_api_cadastro/api/acesso_api.dart';
import 'package:web_api_cadastro/model/cidade.dart';
import 'package:web_api_cadastro/model/cliente.dart';
import 'package:web_api_cadastro/paginas/cadastroCidade.dart';
import 'package:web_api_cadastro/paginas/consultaCliente.dart';
import 'package:web_api_cadastro/util/componentes.dart';

class ConsultaCidade extends StatefulWidget {
  const ConsultaCidade({super.key});

  @override
  State<ConsultaCidade> createState() => _ConsultaCidadeState();
}

class _ConsultaCidadeState extends State<ConsultaCidade> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController? removerController = TextEditingController();
  TextEditingController? editarController = TextEditingController();

  List<Cidade> lista = [];

  listarTodas() async {
    List<Cidade> cidades = await AcessoApi().listaCidades();
    setState(() {
      lista = cidades;
    });
  }

  @override
  void initState() {
    super.initState();
    listarTodas();
  }

  removerItem(Cidade cidade, context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Excluir cliente'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Tem certeza que deseja excluir?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Sim'),
              onPressed: () async {
                await AcessoApi().deletaCidade(cidade.id);
                Navigator.of(context).pop();
                setState(() {
                  listarTodas();
                });
              },
            ),
            TextButton(
              child: const Text('Não'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  editarItem(Cidade cidade, context) {
    Navigator.pushNamed(context, '/cadastro-cidade', arguments: cidade);
  }

  rotaIconButton() {
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          Componentes().appBar(rotaIconButton, const Text('LISTA DE CIDADES')),
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
              Componentes()
                  .criaBotao('Atualizar lista', listarTodas, 50, _formKey),
              Componentes()
                  .criaTexto('Cidades cadastrados: ${lista.length.toString()}'),
              Expanded(
                  child: Container(
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
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: IconButton(
                              tooltip: 'Editar',
                              onPressed: () {
                                editarItem(lista[index], context);
                              },
                              icon: const Icon(
                                Icons.edit,
                                size: 20,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: IconButton(
                              tooltip: 'Remover',
                              onPressed: () {
                                removerItem(lista[index], context);
                              },
                              icon: const Icon(
                                Icons.delete,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
