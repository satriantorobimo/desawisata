import 'dart:convert';
import 'dart:developer';

import 'package:desa_wisata_nusantara/feature/search/bloc/search/bloc.dart';
import 'package:desa_wisata_nusantara/feature/search/domain/repo/search_repo.dart';
import 'package:desa_wisata_nusantara/feature/search/model/search_model.dart';
import 'package:desa_wisata_nusantara/resources/color_swatch.dart';
import 'package:desa_wisata_nusantara/resources/route_string.dart';
import 'package:desa_wisata_nusantara/util/shared_preff.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchBloc searchBloc = SearchBloc(searchRepo: SearchRepo());
  String _values;
  List<String> searchValue = [];
  List<String> tempSearchValue = [];
  List<Items> items = [];
  @override
  void dispose() {
    searchBloc.close();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    String s =
        "Desa. Fajar Harapan, Kec. Kluet Utara, Kab\/Kota. Aceh Selatan, Prov. Aceh";

    int idx = s.indexOf(",");
    List parts = [s.substring(0, idx).trim(), s.substring(idx + 1).trim()];
    SharedPreff().getSharedString('search').then((value) {
      if (value != null) {
        setState(() {
          items = Items.decode(value);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24),
                    Text('Search',
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 24),
                    Theme(
                      data:
                          Theme.of(context).copyWith(primaryColor: Colors.grey),
                      child: TextField(
                        textInputAction: TextInputAction.search,
                        onChanged: (value) {
                          setState(() {
                            _values = value;
                          });
                          if (value.length >= 3) {
                            searchBloc.add(GetSearchValue(value));
                          }
                        },
                        onSubmitted: (value) {
                          setState(() {
                            _values = value;
                          });
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Cari Nama Desa / Wisata',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24.0),
                              borderSide: BorderSide.none),
                          fillColor: Color(0xffe6e6ec),
                          filled: true,
                        ),
                      ),
                    ),
                    items.length == 0 ? Container() : SizedBox(height: 24),
                    items.length == 0
                        ? Container()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Pencarian terakhir',
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    items.clear();
                                    SharedPreff().deleteSharedPref('search');
                                  });
                                },
                                child: Text('Hapus semua',
                                    style: GoogleFonts.poppins(
                                      color: Colors.red,
                                      fontSize: 12,
                                    )),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
              items.length == 0
                  ? Container()
                  : Container(
                      width: double.infinity,
                      height: 60,
                      child: ListView.separated(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              width: 10,
                            );
                          },
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          itemCount: items.length,
                          reverse: false,
                          itemBuilder: (BuildContext context, int index) {
                            int idx = items[index].subTitle.indexOf(",");
                            List parts = [
                              items[index].subTitle.substring(0, idx).trim(),
                              items[index].subTitle.substring(idx + 1).trim()
                            ];
                            return GestureDetector(
                              onTap: () {
                                if (items[index].page == 'WISATA') {
                                  Navigator.of(context, rootNavigator: false)
                                      .pushNamed(tempatDetailRoute,
                                          arguments: items[index].id);
                                } else {
                                  Navigator.of(context, rootNavigator: false)
                                      .pushNamed(desaDetailRoute,
                                          arguments: items[index].id);
                                }
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: primaryColor,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(16)),
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text(
                                          '${items[index].title}\n${parts[0]}',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ))),
                            );
                          }),
                    ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: BlocListener<SearchBloc, SearchState>(
                    cubit: searchBloc,
                    listener: (_, SearchState state) {
                      if (state is SearchLoaded) {
                        setState(() {
                          log(_values);
                          tempSearchValue.add(_values);
                        });
                      }
                      if (state is SearchError) {}
                    },
                    child: BlocBuilder<SearchBloc, SearchState>(
                        cubit: searchBloc,
                        builder: (_, SearchState state) {
                          if (state is SearchInitial) {
                            return Container();
                          }
                          if (state is SearchLoading) {
                            return Center(
                              child: Container(
                                width: 50,
                                height: 50,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        primaryColor),
                                  ),
                                ),
                              ),
                            );
                          }
                          if (state is SearchLoaded) {
                            return searchResult(state.searchModel);
                          }
                          if (state is SearchError) {
                            return Container();
                          }
                          return Container();
                        })),
              ),
            ],
          ),
        ));
  }

  Widget searchResult(SearchModel searchModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Hasil pencarian',
            style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        ListView.separated(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 10,
              );
            },
            itemCount: searchModel.items.length,
            reverse: false,
            itemBuilder: (BuildContext context, int index) {
              print(searchModel.items[index].sourceImage);
              return GestureDetector(
                onTap: () {
                  if (searchModel.items[index].page == 'WISATA') {
                    String encodedData;

                    if (items.length != 0) {
                      if (!items.any(
                          (file) => file.id != searchModel.items[index].id)) {
                        items.add(searchModel.items[index]);
                        encodedData = Items.encode(items);
                        SharedPreff().savedSharedString('search', encodedData);
                      }
                    } else {
                      encodedData = Items.encode([
                        Items(
                            id: searchModel.items[index].id,
                            page: searchModel.items[index].page,
                            sourceImage: searchModel.items[index].sourceImage,
                            subTitle: searchModel.items[index].subTitle,
                            title: searchModel.items[index].title)
                      ]);
                      SharedPreff().savedSharedString('search', encodedData);
                    }

                    SharedPreff().getSharedString('search').then((value) {
                      if (value != null) {
                        setState(() {
                          items = Items.decode(value);
                        });
                      }
                    });
                    Navigator.of(context, rootNavigator: false).pushNamed(
                        tempatDetailRoute,
                        arguments: searchModel.items[index].id);
                  } else {
                    String encodedData;

                    if (items.length != 0) {
                      if (!items.any(
                          (file) => file.id != searchModel.items[index].id)) {
                        items.add(searchModel.items[index]);
                        encodedData = Items.encode(items);
                        SharedPreff().savedSharedString('search', encodedData);
                      }
                    } else {
                      encodedData = Items.encode([
                        Items(
                            id: searchModel.items[index].id,
                            page: searchModel.items[index].page,
                            sourceImage: searchModel.items[index].sourceImage,
                            subTitle: searchModel.items[index].subTitle,
                            title: searchModel.items[index].title)
                      ]);
                    }

                    SharedPreff().savedSharedString('search', encodedData);
                    SharedPreff().getSharedString('search').then((value) {
                      if (value != null) {
                        setState(() {
                          items = Items.decode(value);
                        });
                      }
                    });
                    Navigator.of(context, rootNavigator: false).pushNamed(
                        desaDetailRoute,
                        arguments: searchModel.items[index].id);
                  }
                },
                child: ListTile(
                  leading: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        image: DecorationImage(
                            image: searchModel.items[index].sourceImage == ""
                                ? AssetImage(
                                    'assets/images/placeholder.png',
                                  )
                                : NetworkImage(
                                    '${searchModel.items[index].sourceImage}',
                                  ),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Colors.grey.withOpacity(0.4),
                                BlendMode.darken))),
                    margin: const EdgeInsets.only(right: 8.0),
                  ),
                  title: Text('${searchModel.items[index].title}',
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                  subtitle: Text('${searchModel.items[index].subTitle}',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 12,
                      )),
                ),
              );
            }),
      ],
    );
  }
}
