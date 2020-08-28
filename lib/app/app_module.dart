import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_bloc.dart';
import 'app_widget.dart';
import 'modules/home/home_module.dart';
import 'shared/services/hive_service.dart';
import 'shared/services/interfaces/local_storage_service_interface.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind<ILocalStorageService>((i) => HiveService()),
        Bind((i) => AppBloc()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, module: HomeModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
