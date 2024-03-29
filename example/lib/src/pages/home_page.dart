import 'package:flutter/material.dart';
import 'package:example_flutter/src/providers/peliculas_provider.dart';
import 'package:example_flutter/src/widgets/movie_horizontal_widget.dart';
import 'package:example_flutter/src/search/search_delegate.dart';
import 'package:example_flutter/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {

  final peliculasProvider = new PeliculasProvider();

   String _idviajero='';

  @override
  Widget build(BuildContext context) {

    _idviajero= ModalRoute.of(context).settings.arguments ?? '';

    //print("ESTOY EN HOME CON: "+_id);

    peliculasProvider.getPolulares();

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        centerTitle: false,
        title: Text('Peliculas en cine'),
        backgroundColor: Colors.redAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              showSearch(context: context, delegate: DataSearch());
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _perfil(context),
              _footer(context)
            ],),
            _swiperTarjetas()
          ],
        ),
      ),
    );
  }


  Widget _swiperTarjetas(){
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      //El snapshot contiene todas las peliculas procesadas, es una lista de peliculas
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if(snapshot.hasData){
          return CardSwiper( peliculas: snapshot.data );
        }
        else{
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator()
            ),
          );
        }
      },
    );
  }

  Widget _perfil(BuildContext context){
    return Container(
        child: FlatButton.icon(
          color: Colors.red,
          icon: Icon(Icons.portrait), //`Icon` to display
          label: Text('Ver Perfil'), //`Text` to display
          onPressed: () {
           Navigator.pushNamed(context, 'perfil',arguments: _idviajero);
          },
        ),
    );
  }

  Widget _footer(BuildContext context){
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text('Populares', style: Theme.of(context).textTheme.subhead)
          ),
          SizedBox(height: 5.0),
          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if(snapshot.hasData){
                return MovieHorizontal(
                  peliculas: snapshot.data, 
                  siguientePagina: peliculasProvider.getPolulares
                );
              }
              else{
                return Center(
                  child: CircularProgressIndicator()
                );
              }
            },
          ),

        ],
      ),
    );
  }
}