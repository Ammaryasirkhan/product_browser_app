import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_browser_app/domain/repositories/product_repository.dart';
import 'package:product_browser_app/presentation/blocs/product_detail/product_detail_cubit.dart';
import 'package:product_browser_app/presentation/blocs/product_list/product_list_bloc.dart';
import 'package:product_browser_app/presentation/screens/product_list_screen.dart';

class MyApp extends StatelessWidget {
  final ProductRepository repo;
  const MyApp({super.key, required this.repo});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [RepositoryProvider<ProductRepository>.value(value: repo)],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ProductListBloc(repo)),
          BlocProvider(create: (_) => ProductDetailCubit(repo)),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(useMaterial3: true),
          home: const ProductListScreen(),
        ),
      ),
    );
  }
}
