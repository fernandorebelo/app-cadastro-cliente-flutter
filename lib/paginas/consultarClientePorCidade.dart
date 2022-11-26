import 'package:flutter/material.dart';
import 'package:web_api_cadastro/api/acesso_api.dart';
import 'package:web_api_cadastro/model/cliente.dart';
import 'package:web_api_cadastro/util/componentes.dart';

class ConsultaClientePorCidade extends StatefulWidget {
  const ConsultaClientePorCidade({super.key});

  @override
  State<ConsultaClientePorCidade> createState() =>
      _ConsultaClientePorCidadeState();
}

class _ConsultaClientePorCidadeState extends State<ConsultaClientePorCidade> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController cidadeController = TextEditingController();

  List<Cliente> lista = [];

  listarTodasPorCidade() async {
    List<Cliente> clientes =
        await AcessoApi().pesquisarClientePorCidade(cidadeController.text);
    setState(() {
      lista = clientes;
    });
  }

  rotaIconButton() {
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Componentes()
          .appBar(rotaIconButton, const Text('CONSULTAR CLIENTE POR CIDADE')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Column(
            children: [
              Componentes().criaTexto('Digite a cidade desejada:'),
              Componentes().textFormField(
                  'Cidade', cidadeController, TextInputType.text),
              Componentes()
                  .criaBotao('Pesquisar', listarTodasPorCidade, 50, _formKey),
              Componentes()
                  .criaTexto('Cliente encontrados: ${lista.length.toString()}'),
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
                            child: Componentes().criaItemCliente(lista[index]),
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
    );
  }
}
