import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:web_api_cadastro/api/acesso_api.dart';
import 'package:web_api_cadastro/model/cidade.dart';
import 'package:web_api_cadastro/model/cliente.dart';

class ComboCidade extends StatefulWidget {
  TextEditingController? controller;
  ComboCidade({super.key, this.controller});

  @override
  State<ComboCidade> createState() => _ComboCidadeState();
}

class _ComboCidadeState extends State<ComboCidade> {
  int? cidadeSelecionada;
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Cliente;
    if (args.cidade.id == 0) {
      cidadeSelecionada;
    } else {
      cidadeSelecionada = args.cidade.id;
    }
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 1))
          .then((value) => AcessoApi().listaCidades()),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          List<Cidade> cidades = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: DropdownButton(
              isExpanded: true,
              value: cidadeSelecionada,
              icon: const Icon(Icons.arrow_downward),
              hint: const Text('Selecione uma cidade...'),
              onChanged: (int? value) {
                setState(() {
                  cidadeSelecionada = value;
                  widget.controller?.text = '$value';
                });
              },
              items: cidades.map<DropdownMenuItem<int>>((Cidade cidade) {
                return DropdownMenuItem<int>(
                    value: cidade.id,
                    child: Text('${cidade.nome} - ${cidade.uf}'));
              }).toList(),
            ),
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
              Text('Carregando...'),
            ],
          );
        }
      },
    );
  }
}
