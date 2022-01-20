import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/pages/direcciones_page.dart';
import 'package:qr_scanner/pages/mapas_page.dart';
import 'package:qr_scanner/provider/scan_list_provider.dart';
import 'package:qr_scanner/provider/ui_provider.dart';
import 'package:qr_scanner/widgets/custom_navigatorbar.dart';
import 'package:qr_scanner/widgets/scan_buttom.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Historial'),
        actions: [
          IconButton(
            icon: const Icon( Icons.delete_forever ), 
            onPressed: (){ 

              Provider.of<ScanListProvider>(context, listen: false)
                .borrarTodos();

            }
          )
        ],
      ),
      body: _HomePageBody(),

     bottomNavigationBar: const CustomNavigationBar(),
     floatingActionButton: const ScanButton(),
     floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
   );
  }
}


class _HomePageBody extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    // Obtener el selected menu opt
    final uiProvider = Provider.of<UiProvider>(context);
    
    // Cambiar para mostrar la pagina respectiva
    final currentIndex = uiProvider.selectedMenuOpt;

    //TODO Temporal leer la base de datos
    //final tempScan = new ScanModel(valor: 'http//google.com');
    //DBProvider.db.nuevoScan(tempScan);
    //DBProvider.db.getTodosLosScans().then(print);
    //DBProvider.db.deleteAllScans().then(print);


    //Usar el ScanListProvider
    final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);
    switch( currentIndex ) {

      case 0:
        scanListProvider.cargarScanPorTipo('geo');
        return MapasPage();

      case 1: 
        scanListProvider.cargarScanPorTipo('http');
        return const DireccionesPage();

      default:
        return MapasPage();
    }


  }
}