import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:web_api_cadastro/model/cliente.dart';

enum Sexo { masculino, feminino }

class RadioSexo extends StatefulWidget {
  TextEditingController? controller;
  RadioSexo({super.key, this.controller});

  @override
  State<RadioSexo> createState() => _RadioSexoState();
}

class _RadioSexoState extends State<RadioSexo> {
  Sexo? _character = Sexo.masculino;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Cliente;
    if (args.id != 0) {
      _character = args.sexo == 'M' ? Sexo.masculino : Sexo.feminino;
    }
    return Row(
      children: [
        Expanded(
          child: ListTile(
            title: const Text('Masculino'),
            leading: Radio<Sexo>(
              value: Sexo.masculino,
              groupValue: _character,
              onChanged: (Sexo? value) {
                setState(() {
                  _character = value;
                  widget.controller?.text = 'M';
                });
              },
            ),
          ),
        ),
        Expanded(
          child: ListTile(
            title: const Text('Feminino'),
            leading: Radio<Sexo>(
              value: Sexo.feminino,
              groupValue: _character,
              onChanged: (Sexo? value) {
                setState(() {
                  _character = value;
                  widget.controller?.text = 'F';
                });
              },
            ),
          ),
        )
      ],
    );
  }
}
