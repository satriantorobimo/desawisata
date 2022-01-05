import 'package:desa_wisata_nusantara/feature/list_category/bloc/list_category/bloc.dart';
import 'package:desa_wisata_nusantara/feature/list_category/domain/repo/list_category_repo.dart';

import 'package:desa_wisata_nusantara/feature/list_category/model/list_category_model.dart';
import 'package:desa_wisata_nusantara/feature/list_desa/widget/loading_skeleton_widget.dart';
import 'package:desa_wisata_nusantara/feature/home/model/category_home_model.dart';
import 'package:desa_wisata_nusantara/resources/color_swatch.dart';
import 'package:desa_wisata_nusantara/resources/route_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ListCategoryScreen extends StatefulWidget {
  final Data datas;

  ListCategoryScreen(this.datas);

  @override
  _ListCategoryScreenState createState() => _ListCategoryScreenState();
}

class _ListCategoryScreenState extends State<ListCategoryScreen> {
  ListCategoryBloc listCategoryBloc =
      ListCategoryBloc(listCategoryRepo: ListCategoryRepo());

  bool isLoading = false;

  List<Items> dataDetail;

  int _page = 1;

  @override
  void initState() {
    listCategoryBloc
        .add(GetListCategory(widget.datas.id.toString(), 10, _page));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('${widget.datas.name}',
            style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold)),
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
                  color: Colors.black.withOpacity(0.5), shape: BoxShape.circle),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 16.0, right: 16.0, bottom: 16.0, top: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocListener<ListCategoryBloc, ListCategoryState>(
                  cubit: listCategoryBloc,
                  listener: (_, ListCategoryState state) {
                    if (state is ListCategoryLoading) {
                      setState(() {
                        isLoading = true;
                      });
                    }
                    if (state is ListCategoryLoaded) {
                      setState(() {
                        isLoading = false;
                        dataDetail = state.items;
                      });
                    }
                    if (state is ListCategoryError) {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  child: BlocBuilder<ListCategoryBloc, ListCategoryState>(
                      cubit: listCategoryBloc,
                      builder: (_, ListCategoryState state) {
                        if (state is ListCategoryInitial) {
                          if (dataDetail == null) {
                            return LoadingSkeletonListDesa();
                          } else {
                            return popularMethod(dataDetail, false);
                          }
                        }
                        if (state is ListCategoryLoading) {
                          if (dataDetail == null) {
                            return LoadingSkeletonListDesa();
                          } else {
                            return popularMethod(dataDetail, false);
                          }
                        }
                        if (state is ListCategoryLoaded) {
                          return popularMethod(
                              state.items, state.hasReachedMax);
                        }
                        if (state is ListCategoryError) {
                          if (dataDetail == null) {
                            return errorNoData();
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

  Widget errorNoData() {
    return Column(
      children: [
        Center(child: Image.asset('assets/images/not_found.jpg', width: 280)),
        Center(
          child: Text('Wisata ${widget.datas.name} tidak ditemukan',
              style: GoogleFonts.montserrat(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
        )
      ],
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
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, tempatDetailRoute,
                      arguments: items[index].id.toString());
                },
                child: Container(
                  width: double.infinity,
                  height: 165.0,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${items[index].title}',
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
                              Wrap(
                                alignment: WrapAlignment.start,
                                spacing: 2,
                                runSpacing: 4,
                                direction: Axis.horizontal,
                                children: items[index].categories.map((item) {
                                  return Container(
                                      decoration: BoxDecoration(
                                          color: Color(0xFF2E3285)
                                              .withOpacity(0.6),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text('${item.name}',
                                            style: GoogleFonts.poppins(
                                                fontSize: 8,
                                                color: Colors.white)),
                                      ));
                                }).toList(),
                              ),
                              SizedBox(height: 8),
                              Text('${items[index].shortContent}',
                                  style: GoogleFonts.poppins(
                                      fontSize: 9, color: Colors.black)),
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
                  listCategoryBloc.add(
                      GetListCategory(widget.datas.id.toString(), 10, _page));
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
