import 'package:flutter/material.dart';
import 'package:push_local/src/providers/productos_provider.dart';

class MensajePage extends StatefulWidget {
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<MensajePage> {
  ProductosProvider productosProvider = new ProductosProvider();

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context).settings.arguments;
    //Future<dynamic> compra = _obtenerProductos(context, int.parse(arg));
    //Map<String, dynamic> compraMap;

    /*compra.then((c) {
      compraMap = c;
      print(compraMap);
    });
*/
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de la Compra'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            child: Column(
              children: <Widget>[
                _llamarWidgetsNombreCliente(int.parse(arg)),
                _llamarWidgetsSaldo(int.parse(arg)),
                _llamarWidgetsNombre(int.parse(arg)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  
  Widget _crearActoresPageView( List<dynamic> list ) {

    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1
        ),
        itemCount: list[list.length - 1]['detalle'].length,
        itemBuilder: (context, i) =>_actorTarjeta(  list[list.length - 1]['detalle'][i]['producto'] ),
      ),
    );

  }


    Widget _actorTarjeta( dynamic object ) {
    return Container(
      child: Column(
        children: <Widget>[
           ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage( object['urlfoto'] ),
              placeholder: AssetImage('assets/no-image.jpg'),
              height: 150.0,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            object['nombreproducto'] + ' - ' + object['precioproducto'].toString(),
            overflow: TextOverflow.ellipsis,
          )
        ],
      )
    );
  }


  Widget _crearNombre(List<dynamic> list) {
    List<Widget> listaWidget = new List<Widget>();

    for (var i = 0; i < list[list.length - 1]['detalle'].length; i++) {
      listaWidget.add(new Text(
        list[list.length - 1]['detalle'][int.parse(i.toString())]['producto']
            ['nombreproducto'] + ' => ' +
             list[list.length - 1]['detalle'][int.parse(i.toString())]['producto']
            ['precioproducto'].toString() + ' ',
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontWeight: FontWeight.bold),
      )
      );
    }
    return new Row(children: listaWidget);
  }

  Widget _crearSaldo(List<dynamic> list) {
    var costoTotal = 0.0;

   for (var i = 0; i < list[list.length - 1]['detalle'].length; i++) {
     costoTotal = costoTotal + list[list.length - 1]['detalle'][i]['cantidad'] * list[list.length - 1]['detalle'][i]['producto']['precioproducto'];
   }
    return TextFormField(
      initialValue: costoTotal.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: 'Total de la Compra'),
    );
  }

  Widget _crearNombreCliente(List<dynamic> list) {
    return TextFormField(
      initialValue: list[list.length - 1]['usuario']['nombreusuario'],
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: 'Nombre Cliente'),
    );
  }

  Widget _llamarWidgetsNombre(int codigousuario) {
    return FutureBuilder(
      future: productosProvider.obtenerCompra(codigousuario),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return _crearActoresPageView(snapshot.data);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _llamarWidgetsNombreCliente(int codigousuario) {
    return FutureBuilder(
      future: productosProvider.obtenerCompra(codigousuario),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return _crearNombreCliente(snapshot.data);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _llamarWidgetsSaldo(int codigousuario) {
    return FutureBuilder(
      future: productosProvider.obtenerCompra(codigousuario),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return _crearSaldo(snapshot.data);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

}
