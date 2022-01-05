import 'package:desa_wisata_nusantara/feature/tempat_detail/bloc/review/bloc.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/domain/repo/tempat_detail_repo.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/model/review_model.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/model/tempat_detail_model.dart';
import 'package:desa_wisata_nusantara/feature/ulasan/model/argument_ulasan_model.dart';
import 'package:desa_wisata_nusantara/resources/color_swatch.dart';
import 'package:desa_wisata_nusantara/resources/route_string.dart';
import 'package:desa_wisata_nusantara/util/shared_preff.dart';
import 'package:desa_wisata_nusantara/widget/custom_dialog_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import 'loading_skeleton_review.dart';

class UlasanWidget extends StatefulWidget {
  final TempatDetailModel tempatDetailModel;
  UlasanWidget(this.tempatDetailModel);
  @override
  _UlasanWidgetState createState() => _UlasanWidgetState();
}

class _UlasanWidgetState extends State<UlasanWidget> {
  ReviewBloc reviewBloc = ReviewBloc(tempatDetailRepo: TempatDetailRepo());
  bool isLoading = false;
  List<Items> reviewModel;

  int _page = 1;

  @override
  void dispose() {
    reviewBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    reviewBloc
        .add(GetReview(widget.tempatDetailModel.data.id.toString(), 10, _page));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row(
          //   children: [
          //     Text(
          //       '${widget.tempatDetailModel.data.ratings.summaries.point}',
          //       style: GoogleFonts.poppins(
          //           fontSize: 30,
          //           fontWeight: FontWeight.bold,
          //           color: Colors.black),
          //     ),
          //     SizedBox(width: 12),
          //     Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text(
          //           'Rangkuman ulasan',
          //           style: GoogleFonts.poppins(
          //             fontSize: 12,
          //           ),
          //         ),
          //         Row(
          //           children: [
          //             RatingBar.builder(
          //               initialRating: double.parse(widget
          //                   .tempatDetailModel.data.ratings.summaries.point),
          //               minRating: 1,
          //               direction: Axis.horizontal,
          //               allowHalfRating: true,
          //               unratedColor: primaryColor.withAlpha(50),
          //               itemCount: 5,
          //               itemSize: 14.0,
          //               itemBuilder: (context, _) => Icon(
          //                 Icons.star,
          //                 color: primaryColor,
          //               ),
          //               onRatingUpdate: (rating) {},
          //               updateOnDrag: false,
          //               glowColor: Colors.white,
          //             ),
          //             SizedBox(width: 4),
          //             Text(
          //                 '${widget.tempatDetailModel.data.ratings.summaries.total} ulasan',
          //                 style: GoogleFonts.poppins(
          //                     fontSize: 12, color: Colors.black)),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ],
          // ),
          // SizedBox(height: 8),
          // ListView.builder(
          //     shrinkWrap: true,
          //     physics: const NeverScrollableScrollPhysics(),
          //     scrollDirection: Axis.vertical,
          //     padding: EdgeInsets.zero,
          //     itemCount: widget.tempatDetailModel.data.ratings.details.length,
          //     reverse: false,
          //     itemBuilder: (BuildContext context, int index) {
          //       return Row(
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: [
          //           Container(
          //             width: MediaQuery.of(context).size.width * 0.25,
          //             child: Text(
          //               '${widget.tempatDetailModel.data.ratings.details[index].name}',
          //               style: GoogleFonts.poppins(
          //                 fontSize: 12,
          //               ),
          //             ),
          //           ),
          //           Container(
          //               width: MediaQuery.of(context).size.width *
          //                   (widget.tempatDetailModel.data.ratings
          //                           .details[index].total /
          //                       3000),
          //               height: 7,
          //               decoration: BoxDecoration(color: primaryColor)),
          //           SizedBox(width: 8),
          //           Text(
          //             '${widget.tempatDetailModel.data.ratings.details[index].total}',
          //             style: GoogleFonts.poppins(
          //               fontSize: 10,
          //             ),
          //           ),
          //         ],
          //       );
          //     }),
          // SizedBox(height: 16),
          Container(
            width: double.infinity,
            height: 50,
            child: OutlinedButton(
              onPressed: () {
                SharedPreff().getSharedString('token').then((value) {
                  if (value != null) {
                    Navigator.pushNamed(context, ulasanRoute,
                        arguments: ArgumentUlasanModel(
                            id: widget.tempatDetailModel.data.id.toString(),
                            title: widget.tempatDetailModel.data.title,
                            villageName: widget
                                .tempatDetailModel.data.locations.villageName,
                            address: widget
                                .tempatDetailModel.data.locations.locationName,
                            images:
                                widget.tempatDetailModel.data.photos.length == 0
                                    ? ''
                                    : widget.tempatDetailModel.data.photos[0]
                                        .sourceImage));
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => CustomDialogLogin(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.pushNamed(context, loginRoute,
                                    arguments: false);
                              },
                              value:
                                  'Untuk mengakses halaman ini, harap Masuk terlebih dahulu.',
                            ));
                  }
                });
              },
              style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  side: BorderSide(width: 1, color: primaryColor)),
              child: Text('Tulis Ulasan',
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor)),
            ),
          ),
          // SizedBox(height: 16),
          BlocListener<ReviewBloc, ReviewState>(
              cubit: reviewBloc,
              listener: (_, ReviewState state) {
                if (state is ReviewLoading) {
                  setState(() {
                    isLoading = true;
                  });
                }
                if (state is ReviewLoaded) {
                  setState(() {
                    isLoading = false;
                    reviewModel = state.items;
                  });
                }
                if (state is ReviewError) {
                  setState(() {
                    isLoading = false;
                  });
                }
              },
              child: BlocBuilder<ReviewBloc, ReviewState>(
                  cubit: reviewBloc,
                  builder: (_, ReviewState state) {
                    if (state is ReviewInitial) {
                      if (reviewModel == null) {
                        return LoadingSkeletonReview();
                      } else {
                        return reviewMethod(reviewModel, false);
                      }
                    }
                    if (state is ReviewLoading) {
                      if (reviewModel == null) {
                        return LoadingSkeletonReview();
                      } else {
                        return reviewMethod(reviewModel, false);
                      }
                    }
                    if (state is ReviewLoaded) {
                      return reviewMethod(state.items, state.hasReachedMax);
                    }
                    if (state is ReviewError) {
                      if (reviewModel == null) {
                        return Container();
                      } else {
                        return reviewMethod(reviewModel, false);
                      }
                    }
                    return Container();
                  })),
        ],
      ),
    );
  }

  Column reviewMethod(List<Items> reviewModel, bool hasReachedMax) {
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
            itemCount: reviewModel.length,
            reverse: false,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.network(reviewModel[index].creator.sourceAvatar,
                              width: 35),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${reviewModel[index].creator.name}',
                                style: GoogleFonts.poppins(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Ditulis pada ${reviewModel[index].createdAt.createdAt}',
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    '${reviewModel[index].title}',
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${reviewModel[index].review}',
                    style:
                        GoogleFonts.poppins(fontSize: 12, color: Colors.black),
                  ),
                  SizedBox(height: 8),
                  reviewModel[index].sourceImages.length != 0
                      ? Container(
                          width: double.infinity,
                          height: 60,
                          child: ListView.separated(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(
                                  width: 10,
                                );
                              },
                              padding: EdgeInsets.zero,
                              itemCount: reviewModel[index].sourceImages.length,
                              reverse: false,
                              itemBuilder: (BuildContext context, int i) {
                                return Image.network(
                                  '${reviewModel[index].sourceImages[i]}',
                                );
                              }),
                        )
                      : Container(),
                  SizedBox(height: 12),
                  reviewModel[index].replied != null
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
                                        '${reviewModel[index].replied.creator.data.sourceAvatar}',
                                        width: 35),
                                    SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${reviewModel[index].replied.creator.data.name}',
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          'Ditulis pada ${reviewModel[index].replied.repliedAt.repliedAt}',
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
                                  '${reviewModel[index].replied.review}',
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
                  reviewBloc.add(GetReview(
                      widget.tempatDetailModel.data.id.toString(), 10, _page));
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
