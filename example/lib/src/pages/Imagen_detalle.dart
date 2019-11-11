import 'package:flutter/material.dart';
import 'package:example_flutter/src/providers/imagenes_provider.dart';

/*
Librerias de Descarga de arhivos en dart
import 'package:image_downloader/image_downloader.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

*/

class Imagen_detalle extends StatefulWidget {
  final String searchText;
  Imagen_detalle(this.searchText);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<Imagen_detalle> {

  @override
  Widget build(BuildContext context) {
    print(widget.searchText);
    return Scaffold(
      appBar: AppBar(
        title: Text("Imagenes Pelicula"),
      ),
      body: FutureBuilder(
          future: getPics(widget.searchText),
          builder: (context, snapshot) {
            final Map data = snapshot.data;
            print(snapshot);
            if (snapshot.hasError) {
              return Center(
                  child: Text(
                "Error Ocurrio",
                style: TextStyle(fontSize: 16.0, color: Colors.red),
              ));
            } else if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: (data['hits'] as List).length,
                  itemBuilder: (context, index) {
                    return Container(
                        constraints: BoxConstraints.tightFor(width: 0.0, height: 400.0),
                        child: ListTile(
                          contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                          title: Image.network(
                            data['hits'][index]['largeImageURL'],
                            fit: BoxFit.fitWidth,
                          ),
                          onTap:(){
                            //_descargar('largeImageURL');
                            }
                        ));
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  /**Future<void> _descargar(String path) async {
    Pluggins de descarga de archivos aun no tiene soporte sobre desktop - flutter 2019

    Dio dio = Dio();

    final dirToSave = await getApplicationDocumentsDirectory();

    await dio.download(path, '${dirToSave.path}/myImage.jpg',
        onReceiveProgress: (rec, total) {
    });
  }
  **/


}