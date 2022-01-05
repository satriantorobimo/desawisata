import 'package:desa_wisata_nusantara/feature/list_ulasan/bloc/list_ulasan/bloc.dart';
import 'package:desa_wisata_nusantara/feature/list_ulasan/domain/repo/list_ulasan_repo.dart';
import 'package:desa_wisata_nusantara/feature/list_ulasan/model/my_question_model.dart';
import 'package:desa_wisata_nusantara/resources/color_swatch.dart';
import 'package:desa_wisata_nusantara/resources/route_string.dart';
import 'package:desa_wisata_nusantara/util/shared_preff.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'loading_skeleton_widget.dart';

class ListPertanyaanWidget extends StatefulWidget {
  @override
  _ListPertanyaanWidgetState createState() => _ListPertanyaanWidgetState();
}

class _ListPertanyaanWidgetState extends State<ListPertanyaanWidget> {
  ListUlasanBloc listUlasanBloc =
      ListUlasanBloc(listUlasanRepo: ListUlasanRepo());

  bool isLoading = false, isEligible = false;
  List<Items> myQuestion;

  int _page = 1;

  @override
  void dispose() {
    listUlasanBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    SharedPreff().getSharedString('token').then((value) {
      if (value != null) {
        listUlasanBloc.add(GetMyQuestion(_page, 10));
        setState(() {
          isEligible = true;
        });
      }
    });

    super.initState();
  }

  Future<void> _pullRefresh() async {
    listUlasanBloc.add(GetMyQuestion(_page, 10));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _pullRefresh,
      child: SingleChildScrollView(
        child: !isEligible
            ? contentLogin()
            : BlocListener<ListUlasanBloc, ListUlasanState>(
                cubit: listUlasanBloc,
                listener: (_, ListUlasanState state) {
                  if (state is ListUlasanLoading) {
                    setState(() {
                      isLoading = true;
                    });
                  }
                  if (state is MyQuestionLoaded) {
                    setState(() {
                      isLoading = false;
                      myQuestion = state.items;
                    });
                  }
                  if (state is ListUlasanError) {
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
                child: BlocBuilder<ListUlasanBloc, ListUlasanState>(
                    cubit: listUlasanBloc,
                    builder: (_, ListUlasanState state) {
                      if (state is ListUlasanInitial) {
                        if (myQuestion == null) {
                          return LoadingSkeletonUlasan();
                        } else {
                          return myQuestionMethod(myQuestion, false);
                        }
                      }
                      if (state is ListUlasanLoading) {
                        if (myQuestion == null) {
                          return LoadingSkeletonUlasan();
                        } else {
                          return myQuestionMethod(myQuestion, false);
                        }
                      }
                      if (state is MyQuestionLoaded) {
                        return myQuestionMethod(
                            state.items, state.hasReachedMax);
                      }
                      if (state is ListUlasanError) {
                        return contentEmpty();
                      }
                      return Container();
                    })),
      ),
    );
  }

  Widget myQuestionMethod(List<Items> myReview, bool hasReachedMax) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.separated(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            separatorBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Divider(),
              );
            },
            itemCount: myReview.length,
            reverse: false,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Text('${myReview[index].product.title}',
                      style: GoogleFonts.poppins(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                  Text('${myReview[index].product.locationName}',
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: Colors.black,
                      )),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.network(myReview[index].creator.sourceAvatar,
                              width: 35),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${myReview[index].creator.name}',
                                style: GoogleFonts.poppins(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Ditulis pada ${myReview[index].createdAt.createdAt}',
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Container()
                      // Container(
                      //         height: 20,
                      //         decoration: BoxDecoration(
                      //             color: Colors.white,
                      //             borderRadius:
                      //                 BorderRadius.all(Radius.circular(22)),
                      //             border: Border.all(color: primaryColor)),
                      //         child: Padding(
                      //             padding: const EdgeInsets.all(2.0),
                      //             child: Row(
                      //               mainAxisAlignment: MainAxisAlignment.center,
                      //               children: [
                      //                 SizedBox(width: 4),
                      //                 Icon(Icons.favorite,
                      //                     size: 10, color: primaryColor),
                      //                 SizedBox(width: 4),
                      //                 Text('${myReview[index].ra}',
                      //                     style: GoogleFonts.poppins(
                      //                         fontSize: 10,
                      //                         color: primaryColor,
                      //                         fontWeight: FontWeight.bold)),
                      //                 SizedBox(width: 4),
                      //               ],
                      //             ))),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    '${myReview[index].question}',
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  // SizedBox(height: 8),
                  // Text(
                  //   '${myReview[index].review}',
                  //   style:
                  //       GoogleFonts.poppins(fontSize: 12, color: Colors.black),
                  // ),
                  SizedBox(height: 8),
                  // Container(
                  //   width: double.infinity,
                  //   height: 60,
                  //   child: ListView.separated(
                  //       shrinkWrap: true,
                  //       physics: const BouncingScrollPhysics(),
                  //       scrollDirection: Axis.horizontal,
                  //       separatorBuilder: (BuildContext context, int index) {
                  //         return const SizedBox(
                  //           width: 10,
                  //         );
                  //       },
                  //       padding: EdgeInsets.zero,
                  //       itemCount: reviewModel[index].sourceImages.length,
                  //       reverse: false,
                  //       itemBuilder: (BuildContext context, int i) {
                  //         return Image.network(
                  //           '${reviewModel[index].sourceImages[i]}',
                  //         );
                  //       }),
                  // ),
                  SizedBox(height: 12),
                  myReview[index].replied != null
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                  width: 1.0, color: Colors.grey.shade300),
                            ),
                            color: Colors.white,
                          ),
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image.network(
                                        '${myReview[index].replied.creator.sourceAvatar}',
                                        width: 35),
                                    SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${myReview[index].replied.creator.name}',
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          'Ditulis pada ${myReview[index].replied.repliedAt.repliedAt}',
                                          style: GoogleFonts.poppins(
                                              fontSize: 11,
                                              color: Colors.black),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(height: 16),
                                Text(
                                  '${myReview[index].replied.answerText}',
                                  style: GoogleFonts.poppins(
                                      fontSize: 12, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container()
                ],
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
                  listUlasanBloc.add(GetMyQuestion(_page, 10));
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

  Widget contentEmpty() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
              'Kamu belum mempunyai tanya jawab saat ini. Ayo tulis ulasan di tempat yang sudah kamu kunjungi.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: Colors.grey,
                fontSize: 14,
              )),
        ),
      ],
    );
  }

  Widget contentLogin() {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                'Untuk mengakses halaman ini, harap Masuk terlebih dahulu.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.grey,
                  fontSize: 14,
                )),
          ),
          SizedBox(height: 24),
          Container(
            height: 40,
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(context, loginRoute, arguments: false);
              },
              style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  side: BorderSide(width: 1, color: primaryColor)),
              child: Text('Masuk',
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor)),
            ),
          )
        ],
      ),
    );
  }
}
