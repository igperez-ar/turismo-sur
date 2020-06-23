import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_app/bloc/alojamiento_bloc.dart';
import 'package:turismo_app/providers/providers.dart';
import 'package:turismo_app/repositories/repository.dart';
import 'package:turismo_app/theme/style.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:turismo_app/screens/screens.dart';


class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

void main() { 
  BlocSupervisor.delegate = SimpleBlocDelegate();

  final AlojamientoRepository repository = AlojamientoRepository(
    alojamientoProvider: AlojamientoProvider(
      httpClient: 
        http.Client(),
      ),
  );

  runApp(App(
    repository: repository,
  ));
  
}

class App extends StatelessWidget {
  final AlojamientoRepository repository;

  App({Key key, @required this.repository})
    : assert(repository != null),
      super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Turismo App',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: Scaffold(
        body: BlocProvider(
          create: (context) => AlojamientoBloc(repository: repository),
          child: RootScreen(),
        )
      ),
      /* routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => RootScreen(),
      }, */
    );
  }
}
