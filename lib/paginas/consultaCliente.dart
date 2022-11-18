import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:web_api_cadastro/api/acesso_api.dart';
import 'package:web_api_cadastro/model/cidade.dart';
import 'package:web_api_cadastro/model/cliente.dart';
import 'package:web_api_cadastro/paginas/cadastroCliente.dart';
import 'package:web_api_cadastro/util/componentes.dart';
import 'package:web_api_cadastro/util/constantes.dart';

class Consulta extends StatefulWidget {
  const Consulta({super.key});

  @override
  State<Consulta> createState() => _ConsultaState();
}

class _ConsultaState extends State<Consulta> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Constantes constante = Constantes();

  List<Cliente> lista = [];

  listarTodas() async {
    List<Cliente> clientes = await AcessoApi().listaClientes();
    setState(() {
      lista = clientes;
    });
  }

  @override
  void initState() {
    super.initState();
    listarTodas();
  }

  removerItem(Cliente cliente, context) {
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
                await AcessoApi().deletaCliente(cliente.id);
                Navigator.of(context).pop('/consulta');
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

  editarItem(Cliente cliente, context) {
    Navigator.pushReplacementNamed(context, '/cadastro-cliente',
        arguments: cliente);
  }

  atualizaPagina() {
    setState(() {});
  }

  rotaIconButton() {
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Componentes()
            .appBar(rotaIconButton, const Text('LISTA DE CLIENTES')),
        body: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: [
                const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                Componentes()
                    .criaBotao('Atualizar lista', listarTodas, 50, _formKey),
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
                              child:
                                  Componentes().criaItemCliente(lista[index]),
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
        ));
  }
}
