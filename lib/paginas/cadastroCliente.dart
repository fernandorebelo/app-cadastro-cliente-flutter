import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:web_api_cadastro/api/acesso_api.dart';
import 'package:web_api_cadastro/model/cidade.dart';
import 'package:web_api_cadastro/model/cliente.dart';
import 'package:web_api_cadastro/paginas/consultaCidade.dart';
import 'package:web_api_cadastro/paginas/consultaCliente.dart';
import 'package:web_api_cadastro/util/combo_cidade.dart';
import 'package:web_api_cadastro/util/componentes.dart';
import 'package:web_api_cadastro/util/constantes.dart';
import 'package:web_api_cadastro/util/radio_sexo.dart';

class CadastroCliente extends StatefulWidget {
  // List<Cliente>? listaClientes;
  // Function? atualizaPagina;
  const CadastroCliente({super.key});

  @override
  State<CadastroCliente> createState() => _CadastroClienteState();
}

class _CadastroClienteState extends State<CadastroCliente> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nomeController = TextEditingController();
  TextEditingController idadeController = TextEditingController();
  TextEditingController sexoController = TextEditingController(text: 'M');
  TextEditingController cidadeController = TextEditingController();

  rotaIconButton() {
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Cliente;
    nomeController.text = args.nome;
    idadeController.text = args.idade.toString();

    cadastrarButton() async {
      // Cidade cidade = Cidade(args.cidade.id, args.cidade.nome, args.cidade.uf);
      Cliente cliente = Cliente(args.id, nomeController.text,
          sexoController.text, int.parse(idadeController.text), args.cidade);
      if (cliente.id == 0) {
        await AcessoApi().insereCliente(cliente.toJson());
      } else {
        await AcessoApi().alteraCliente(cliente.toJson());
      }
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: Componentes()
          .appBar(rotaIconButton, const Text('CADASTRO DE CLIENTES')),
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            children: [
              Componentes()
                  .textFormField('Nome', nomeController, TextInputType.text),
              Componentes().textFormField(
                  'Idade', idadeController, TextInputType.number),
              RadioSexo(
                controller: sexoController,
              ),
              ComboCidade(
                controller: cidadeController,
              ),
              Componentes()
                  .criaBotao('Cadastrar', cadastrarButton, 50, _formKey)
            ],
          ),
        ),
      ),
    );
  }
}
