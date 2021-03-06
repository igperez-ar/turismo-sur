import 'dart:io';

import 'package:dashed_container/dashed_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

import 'package:turismo_app/bloc/bloc.dart';
import 'package:turismo_app/widgets/widgets.dart';
import 'package:turismo_app/models/models.dart';


class MemoriesWidget extends StatefulWidget {
  final int id;
  final Establecimiento type;

  const MemoriesWidget({
    Key key, 
    @required this.id,
    @required this.type
  }): super(key: key);

  @override
  _MemoriesWidgetState createState() => _MemoriesWidgetState();
}

class _MemoriesWidgetState extends State<MemoriesWidget> with TickerProviderStateMixin {
  var squareRotation = 0.0;
  AnimationController _controllerA;
  bool _deleting = false;
  List<String> _toDelete = [];

  FavoritosBloc _favoritoBloc;
  List<String> _images;
  final picker = ImagePicker();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _controllerA = AnimationController(
      vsync: this,
      value: 0.0,
      lowerBound: -0.05,
      upperBound: 0.05,
      duration: Duration(milliseconds: 130));
    _controllerA.addListener(() {
      setState(() {
        squareRotation = _controllerA.value;
      });
    });
    super.initState();

    _favoritoBloc = BlocProvider.of<FavoritosBloc>(context);
  }

  @override
  void dispose() {
    _controllerA.dispose();
    super.dispose();
  }

  void _changeDeleting({bool value}) {
    setState(() {
      _deleting = value ?? !_deleting;
    });

    if (_deleting) {
      _controllerA.repeat(reverse: true);
    } else {
      _controllerA.animateTo(0.0);
      setState(() {
        _toDelete.clear();
      });
    }
  }

  Future _getCameraImage(Favorito favorito) async {
    _changeDeleting(value: false);

    final pickedFile = await picker.getImage(source: ImageSource.camera);
    
    if (pickedFile != null) {
      GallerySaver.saveImage(pickedFile.path);

      setState(() {
        _images.add(pickedFile.path);
      });

      _favoritoBloc.add(UpdateRecuerdos(favorito, _images));

      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients)
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
          );
      });
    }
  }

  Future _getGalleryImage(Favorito favorito) async {
    _changeDeleting(value: false);

    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null){
      setState(() {
        _images.add(pickedFile.path);
      });

      _favoritoBloc.add(UpdateRecuerdos(favorito, _images));

      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients)
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
          );
      });
    }
  }

  Widget _getMemories(Favorito favorito) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _deleting
          ? Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('${_toDelete.length} elementos seleccionados.'),
                  FlatButton(
                    onPressed: () {
                      _images.removeWhere((element) => _toDelete.contains(element));
                      _changeDeleting(value: false);
                      _favoritoBloc.add(UpdateRecuerdos(favorito, _images));
                    }, 
                    child: Text('Confirmar'), 
                    textColor: Colors.teal[400]
                  )
                ]
              )
            )
          : Container(),
        Container(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            shrinkWrap: true,
            controller: _scrollController,
            children:
              _images.map<Widget>((path) { 
                final bool _selected = _toDelete.contains(path);

                return Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () {
                      if (_deleting) {
                        if (_selected) {
                          _toDelete.remove(path);
                        } else {
                          _toDelete.add(path);
                        }
                      } 
                    },
                    child: Transform.rotate(
                      angle: squareRotation,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration( 
                          borderRadius: BorderRadius.circular(10),
                          /* color: _selected ? Colors.red[300] : Colors.transparent, */
                          image: DecorationImage(
                            /* colorFilter: _selected 
                              ? ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.dstATop)
                              : null, */
                            image: FileImage(File(path)),
                            fit: BoxFit.cover
                          ),
                        ),
                        child: _selected
                          ? Container(
                              decoration: BoxDecoration(
                                color: Colors.red[300].withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10)
                              ),
                            )
                          : Container()
                      )
                    )
                  )
                );
              }
            ).toList()
          )
        )
      ],
    );
  }

  Widget _getEmptyMemories(context) {
    final _width = MediaQuery.of(context).size.width;
    
    return Container(
      height: _width * 0.42,
      width: _width,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: DashedContainer(
        dashColor: Colors.grey[500], 
        strokeWidth: 2,
        dashedLength: 10,
        blankLength: 10,
        borderRadius: 20,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.photo_library, size: 50, color: Colors.grey[600],),
              Padding(padding: EdgeInsets.only(top: 10)),
              Text('aún no tienes recuerdos del lugar'.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      )
    );
  }


  @override
  Widget build(BuildContext context) {

    return BlocBuilder<AutenticacionBloc,AutenticacionState>(
      builder: (context, state) {

        if (state is AutenticacionAuthenticated) {

          return BlocBuilder<FavoritosBloc, FavoritosState>(
            builder: (context, state) {

              if (state is FavoritosSuccess) {
              final Favorito _favorito = state.favoritos.firstWhere(
                (element) => (element.id == widget.id 
                          && element.tipo == widget.type),
                orElse: () => null
              );
                if (_favorito != null) {
                _images = List.from(_favorito.recuerdos);
                  return DetailSectionWidget(
                  title: 'Recuerdos',
                  actions: [
                    {'icon': Icons.camera_alt,
                    'onPressed': () => _getCameraImage(_favorito),
                    },
                    {'icon': Icons.photo_library,
                    'onPressed': () => _getGalleryImage(_favorito),
                    },
                    _images.isNotEmpty 
                      ? {'icon': _deleting ? Icons.delete_forever : Icons.delete,
                        'onPressed': () => _changeDeleting(),
                        }
                      : {}
                  ],
                  child: ( _favorito.recuerdos.isNotEmpty 
                    ? _getMemories(_favorito)
                    : _getEmptyMemories(context)
                  )
                );
                } else {
                  return Container();
                }
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          );
        }

        return Container();
      },
    );
  }
}