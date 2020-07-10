import 'dart:io';
import 'package:flutter/material.dart';

import 'package:dashed_container/dashed_container.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turismo_app/bloc/bloc.dart';
import 'package:turismo_app/components/components.dart';
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

class _MemoriesWidgetState extends State<MemoriesWidget> {
  FavoritosBloc _favoritoBloc;
  /* File _image; */
  List<String> _images;
  final picker = ImagePicker();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _favoritoBloc = BlocProvider.of<FavoritosBloc>(context);
  }

  Future _getCameraImage(Favorito favorito) async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    
    if (pickedFile != null) {
      GallerySaver.saveImage(pickedFile.path);

      setState(() {
        _images.add(pickedFile.path);
      });

      _favoritoBloc.add(UpdateRecuerdos(favorito));

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
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null){
      setState(() {
        _images.add(pickedFile.path);
      });

      _favoritoBloc.add(UpdateRecuerdos(favorito));

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

  Widget _getMemories() {

    return Container(
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        reverse: true,
        shrinkWrap: true,
        controller: _scrollController,
        children:
          _images.map<Widget>((path) => Padding(
            padding: EdgeInsets.only(right: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(
                File(path),
                fit: BoxFit.cover,
                width: 120,
                height: 120,
              ),
            )
          )
        ).toList()
      )
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
    return BlocBuilder<FavoritosBloc, FavoritosState>(
      builder: (context, state) {

        if (state is FavoritosSuccess) {
          final Favorito _favorito = state.favoritos.firstWhere(
            (element) => (element.id == widget.id 
                       && element.tipo == widget.type),
            orElse: () => null
          );

          if (_favorito != null) {
            _images = _favorito.recuerdos;

            return DetailSectionWidget(
              title: 'Recuerdos',
              actions: [
                {'icon': Icons.camera_alt,
                'onPressed': () => _getCameraImage(_favorito),
                },
                {'icon': Icons.photo_library,
                'onPressed': () => _getGalleryImage(_favorito),
                },
                {'icon': Icons.edit,
                'onPressed': () {},
                },
              ],
              child: ( _favorito.recuerdos.isNotEmpty 
                ? _getMemories()
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
}