import 'package:flutter/material.dart';
import 'package:web_api_cadastro/model/cidade.dart';
import 'package:web_api_cadastro/model/cliente.dart';

class Componentes {
  appBar(rota, titulo) {
    return AppBar(
      title: titulo,
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: rota,
          icon: const Icon(Icons.home),
          tooltip: 'Página inicial',
        )
      ],
    );
  }

  criaBotao(titulo, funcao, altura, controlador) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: SizedBox(
              height: altura,
              child: ElevatedButton(
                onPressed: () {
                  if (controlador.currentState!.validate()) {
                    funcao();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ThemeData.dark().backgroundColor,
                ),
                child: Text(
                  titulo,
                  style: const TextStyle(fontSize: 25),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  criaTexto(texto) {
    return Text(
      texto,
    );
  }

  criaItemCliente(Cliente cliente) {
    String sexo = cliente.sexo == 'M' ? 'Masculino' : 'Feminino';
    return ListTile(
      title: criaTexto('${cliente.id} - ${cliente.nome}'),
      subtitle: criaTexto('${cliente.idade} anos - ${sexo}'),
      trailing: criaTexto('${cliente.cidade.nome}/${cliente.cidade.uf}'),
    );
  }

  criaItemCidade(Cidade cidade) {
    return ListTile(
      title: criaTexto('${cidade.id} - ${cidade.nome}'),
      subtitle: criaTexto('Estado - ${cidade.uf}'),
    );
  }

  criaItemCidadeUf(Cidade cidade) {
    return ListTile(
      title: criaTexto('Estado - ${cidade.uf}'),
    );
  }

  textFormField(texto, controller, keyboardType) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: texto,
        ),
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Campo obrigatório';
          }
          return null;
        },
      ),
    );
  }
}
