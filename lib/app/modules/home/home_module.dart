import 'widgets/new_expense/new_expense_bloc.dart';
import 'package:expense_app/app/shared/services/interfaces/local_storage_service_interface.dart';

import 'home_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => NewExpenseBloc(Modular.get<ILocalStorageService>()),
            singleton: false),
        Bind((i) => HomeBloc(Modular.get<ILocalStorageService>())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => HomePage()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
