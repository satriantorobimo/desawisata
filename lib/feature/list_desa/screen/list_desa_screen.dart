import 'dart:developer';

import 'package:desa_wisata_nusantara/feature/home/model/per_kab_model.dart';
import 'package:desa_wisata_nusantara/feature/list_desa/bloc/list_desa/bloc.dart';
import 'package:desa_wisata_nusantara/feature/list_desa/domain/repo/list_desa_repo.dart';
import 'package:desa_wisata_nusantara/feature/list_desa/model/list_desa_model.dart';
import 'package:desa_wisata_nusantara/feature/list_desa/widget/loading_skeleton_widget.dart';
import 'package:desa_wisata_nusantara/resources/color_swatch.dart';
import 'package:desa_wisata_nusantara/resources/route_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ListDesaScreen extends StatefulWidget {
  final Data perKabModel;

  ListDesaScreen(this.perKabModel);

  @override
  _ListDesaScreenState createState() => _ListDesaScreenState();
}

class _ListDesaScreenState extends State<ListDesaScreen> {
  ListDesaBloc listDesaBloc = ListDesaBloc(listDesaRepo: ListDesaRepo());

  bool isLoading = false;

  List<Items> dataDetail;

  int _page = 1;

  @override
  void initState() {
    listDesaBloc.add(GetListDesa(widget.perKabModel.id.toString(), 10, _page));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150.0),
        child: AppBar(
          flexibleSpace: Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.11,
                left: 16,
                right: 16),
            child: Text('Daftar desa wisata pada ${widget.perKabModel.namaKab}',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Icon(
                      CupertinoIcons.arrow_left,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocListener<ListDesaBloc, ListDesaState>(
                  cubit: listDesaBloc,
                  listener: (_, ListDesaState state) {
                    if (state is ListDesaLoading) {
                      setState(() {
                        isLoading = true;
                      });
                    }
                    if (state is ListDesaLoaded) {
                      setState(() {
                        isLoading = false;
                        dataDetail = state.items;
                      });
                    }
                    if (state is ListDesaError) {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  child: BlocBuilder<ListDesaBloc, ListDesaState>(
                      cubit: listDesaBloc,
                      builder: (_, ListDesaState state) {
                        if (state is ListDesaInitial) {
                          if (dataDetail == null) {
                            return LoadingSkeletonListDesa();
                          } else {
                            return popularMethod(dataDetail, false);
                          }
                        }
                        if (state is ListDesaLoading) {
                          if (dataDetail == null) {
                            return LoadingSkeletonListDesa();
                          } else {
                            return popularMethod(dataDetail, false);
                          }
                        }
                        if (state is ListDesaLoaded) {
                          return popularMethod(
                              state.items, state.hasReachedMax);
                        }
                        if (state is ListDesaError) {
                          if (dataDetail == null) {
                            return LoadingSkeletonListDesa();
                          } else {
                            return popularMethod(dataDetail, false);
                          }
                        }
                        return Container();
                      }))
            ],
          ),
        ),
      ),
    );
  }

  Widget popularMethod(List<Items> items, bool hasReachedMax) {
    return Column(
      children: [
        ListView.separated(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 10,
              );
            },
            itemCount: items.length,
            reverse: false,
            itemBuilder: (BuildContext context, int index) {
              log('lalala ${items[index].sourceImage.length}');
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, desaDetailRoute,
                      arguments: items[index].id.toString());
                },
                child: Container(
                  width: double.infinity,
                  height: 145.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    border: Border.all(
                      width: 1,
                      color: Colors.grey.withOpacity(0.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 8,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                bottomLeft: Radius.circular(12),
                              ),
                              image: DecorationImage(
                                  image: items[index].sourceImage == ""
                                      ? AssetImage(
                                          'assets/images/placeholder.png',
                                        )
                                      : NetworkImage(items[index].sourceImage),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Expanded(
                        flex: 14,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${items[index].villageName}',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 4),
                                  Text('${items[index].locationName}',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 9,
                                        color: Colors.black,
                                      )),
                                  SizedBox(height: 8),
                                  Text('${items[index].description}',
                                      style: GoogleFonts.poppins(
                                          fontSize: 9, color: Colors.black)),
                                  SizedBox(height: 16),
                                ],
                              ),
                              Text(
                                  'Ada ${items[index].totalWisata} destinasi wisata desa',
                                  style: GoogleFonts.poppins(
                                      fontSize: 9,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 8),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
        SizedBox(height: 16),
        if (isLoading)
          Center(
              child: Container(
                  height: 20,
                  width: 20,
                  child: Theme(
                      data: ThemeData(accentColor: primaryColor),
                      child: const CircularProgressIndicator())))
        else
          Visibility(
            visible: !hasReachedMax,
            child: Container(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    isLoading = true;
                    _page++;
                  });
                  listDesaBloc.add(
                      GetListDesa(widget.perKabModel.id.toString(), 10, _page));
                },
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    side: BorderSide(width: 1, color: primaryColor)),
                child: Text('Lihat lebih banyak',
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor)),
              ),
            ),
          ),
      ],
    );
  }
}
