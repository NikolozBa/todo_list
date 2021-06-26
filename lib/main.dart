import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/logic/cubits/item_cubit.dart';
import 'package:todo_list/logic/cubits/todo_cubit.dart';
import 'package:todo_list/presentation/router/route_generator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoCubit>(create: (context)=> TodoCubit()),
        BlocProvider<ItemCubit>(create: (context)=> ItemCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Color(0xff6cb4b1),
          primaryColorDark: Color(0xff04a3a3),
          accentColor: Color(0xff0ecc57),
          bottomSheetTheme: BottomSheetThemeData(
            backgroundColor: Color(0xff04a3a3)
          )
        ),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
