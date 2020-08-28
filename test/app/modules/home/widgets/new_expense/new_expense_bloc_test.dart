import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:expense_app/app/app_module.dart';
import 'package:expense_app/app/modules/home/widgets/new_expense/new_expense_bloc.dart';
import 'package:expense_app/app/modules/home/home_module.dart';

void main() {
  Modular.init(AppModule());
  Modular.bindModule(HomeModule());
  NewExpenseBloc bloc;

  // setUp(() {
  //     bloc = HomeModule.to.get<NewExpenseBloc>();
  // });

  // group('NewExpenseBloc Test', () {
  //   test("First Test", () {
  //     expect(bloc, isInstanceOf<NewExpenseBloc>());
  //   });
  // });
}
