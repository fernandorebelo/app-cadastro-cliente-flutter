import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:web_api_cadastro/api/acesso_api.dart';
import 'package:web_api_cadastro/model/cidade.dart';
import 'package:web_api_cadastro/util/componentes.dart';

class CadastroCidade extends StatefulWidget {
  const CadastroCidade({super.key});

  @override
  State<CadastroCidade> createState() => _CadastroCidadeState();
}

class _CadastroCidadeState extends State<CadastroCidade> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController cidadeController = TextEditingController();
  TextEditingController estadoController = TextEditingController();

  rotaIconButton() {
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Cidade;
    cidadeController.text = args.nome;
    estadoController.text = args.uf;

    cadastrarButton() async {
      Cidade cidade =
          Cidade(args.id, cidadeController.text, estadoController.text);
      if (cidade.id == 0) {
        await AcessoApi().insereCidade(cidade.toJson());
      } else {
        await AcessoApi().alteraCidade(cidade.toJson());
      }
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: Componentes()
          .appBar(rotaIconButton, const Text('CADASTRO DE CIDADE')),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Componentes()
                .textFormField('Cidade', cidadeController, TextInputType.text),
            Componentes().textFormField(
                'Estado', estadoController, TextInputType.number),
            Componentes().criaBotao('Cadastrar', cadastrarButton, 50, _formKey)
          ],
        ),
      ),
    );
  }
}
