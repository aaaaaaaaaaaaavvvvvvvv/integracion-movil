import 'package:http/http.dart' as http;
import 'dart:convert';
class ProductosProvider{

  obtenerCompra(int codigousuario) async {
   
    final authData = {
      'codigousuario': codigousuario,   
      'detalleCarrito': null
    };
    print(json.encode(authData));
    final resp = await http.post(
        'https://negelec-gutynatura.herokuapp.com/carrito/recupera',
        body: json.encode(authData),
        headers: {'Content-type': 'application/json'});

       
    if (resp.body == null) {
      return null;
    } else {
      List<dynamic> decodedResp = json.decode(resp.body);
      return decodedResp;
    }
  }
}