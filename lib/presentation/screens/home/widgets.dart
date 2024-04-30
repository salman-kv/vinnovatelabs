import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinnovatelabzsalmankv/application/login_bloc/login_bloc.dart';
import 'package:vinnovatelabzsalmankv/application/login_bloc/login_event.dart';
import 'package:vinnovatelabzsalmankv/domain/api/fake_store_api.dart';
import 'package:vinnovatelabzsalmankv/domain/product_model/product_model.dart';
import 'package:vinnovatelabzsalmankv/presentation/alert/snack_bars.dart';

class HomeWidget {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debouncer;

  // search bar widget
  searchWidget({required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        height: 50,
        child: SearchBar(
          controller: _searchController,
          onChanged: (value) {
            if (value.isEmpty || value.length < 3) {
              BlocProvider.of<LoginBloc>(context).add(CancelSearchEvent());
              SnackBars().errorSnackBar(
                  'Please enter minimum 3 character for searching', context);
            } else {
              if (_debouncer?.isActive ?? false) {
                _debouncer?.cancel();
              }
              _debouncer = Timer(const Duration(milliseconds: 500), () {
                BlocProvider.of<LoginBloc>(context)
                    .add(SearchingEvent(text: value));
              });
            }
          },
          hintText: 'Search...',
          trailing: [
            IconButton(
                onPressed: () {
                  _searchController.clear();
                  BlocProvider.of<LoginBloc>(context).add(CancelSearchEvent());
                },
                icon: const Icon(Icons.cancel)),
          ],
          shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)))),
        ),
      ),
    );
  }

  // custom appbar for home page
  homeAppBar() {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
            width: 40,
            child: Image.asset('assets/images/ICON.png'),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'academy',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

// item showing container
  itemShowingContainer(
      {required BuildContext context, required ProductModel productModel}) {
    return GestureDetector(
      onTap: () {
        FakeStoreAPI().getProductDeatails();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        height: MediaQuery.of(context).size.height * .14,
        margin: const EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height * .14,
              width: MediaQuery.of(context).size.height * .14,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: NetworkImage(productModel.image),
                      fit: BoxFit.contain)),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(productModel.title,
                      maxLines: 2,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    productModel.category,
                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Row(
                            children: List.generate(
                              int.parse(productModel.rating['rate']!
                                  .round()
                                  .toString()),
                              (index) => const Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                            ),
                          ),
                          Row(
                            children: List.generate(
                                5 -
                                    int.parse(productModel.rating['rate']!
                                        .round()
                                        .toString()), (index) {
                              return const Icon(Icons.star_border,
                                  color: Colors.yellow);
                            }),
                          ),
                          Text('(${productModel.rating['count'].toString()})'),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '\$ ${productModel.price}',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
