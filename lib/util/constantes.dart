import 'package:web_api_cadastro/model/cidade.dart';
import 'package:web_api_cadastro/model/cliente.dart';

class Constantes {
  Cliente c = Cliente(0, '', '', 0, Cidade(0, '', ''));

  Cliente getCliente() {
    return c;
  }

  setCliente(Cliente cliente) {
    c = cliente;
  }
}
