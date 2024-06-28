import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:learn_lang_app/controller/read_data_cubit/read_data_cubit.dart';
import 'package:learn_lang_app/controller/write_data_cubit/write_data_cubit.dart';
import 'package:learn_lang_app/model/word_teyp_adapter.dart';
import 'package:learn_lang_app/utils/hive_constants.dart';
import 'package:learn_lang_app/utils/my_bloc_observer.dart';
import 'package:learn_lang_app/views/screen/home_screen.dart';
import 'package:learn_lang_app/views/style/theme_manger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(WordTypeAdapter());
  await Hive.openBox(HiveConstants.wordBox);
  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WriteDataCubit(),
        ),
        BlocProvider(
          create: (context) => ReadDataCubit()..getWords(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HoneScreen(),
        theme: ThemeManger.getTheme(),
      ),
    );
  }
}
