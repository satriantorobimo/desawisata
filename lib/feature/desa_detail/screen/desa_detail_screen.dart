import 'package:desa_wisata_nusantara/feature/desa_detail/bloc/desa_detail/bloc.dart';
import 'package:desa_wisata_nusantara/feature/desa_detail/domain/repo/desa_detail_repo.dart';
import 'package:desa_wisata_nusantara/feature/desa_detail/model/desa_detail_model.dart';
import 'package:desa_wisata_nusantara/feature/list_desa/widget/loading_skeleton_widget.dart';
import 'package:desa_wisata_nusantara/resources/route_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class DesaDetailScreen extends StatefulWidget {
  final String id;

  const DesaDetailScreen(this.id);

  @override
  _DesaDetailScreenState createState() => _DesaDetailScreenState();
}

class _DesaDetailScreenState extends State<DesaDetailScreen> {
  DesaDetailBloc desaDetailBloc =
      DesaDetailBloc(desaDetailRepo: DesaDetailRepo());

  String title = '', subtitle = '';
  bool isLoading = false, bacaSelengkapnya = false;

  @override
  void initState() {
    print(widget.id);
    desaDetailBloc.add(GetDesaDetailValue(widget.id));
    super.initState();
  }

  @override
  void dispose() {
    desaDetailBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(120.0),
          child: AppBar(
            flexibleSpace: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1,
                  left: 16,
                  right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isLoading
                      ? Padding(
                          padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300],
                            highlightColor: Colors.grey[100],
                            child: Container(
                                width: 200,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                )),
                          ),
                        )
                      : Text('$title',
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold)),
                  isLoading
                      ? Shimmer.fromColors(
                          baseColor: Colors.grey[300],
                          highlightColor: Colors.grey[100],
                          child: Container(
                              width: 200,
                              height: 15,
                              decoration: BoxDecoration(
                                color: Colors.white,
                              )),
                        )
                      : Text('$subtitle',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 11,
                          )),
                ],
              ),
            ),
            elevation: 0,
            backgroundColor: Colors.white,
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                CupertinoIcons.arrow_left,
                color: Colors.black,
                size: 30,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: BlocListener<DesaDetailBloc, DesaDetailState>(
              cubit: desaDetailBloc,
              listener: (_, DesaDetailState state) {
                if (state is DesaDetailLoading) {
                  setState(() {
                    isLoading = true;
                  });
                }
                if (state is DesaDetailLoaded) {
                  setState(() {
                    title = state.desaDetailModel.data.locations.villageName;
                    subtitle =
                        state.desaDetailModel.data.locations.locationName;
                    isLoading = false;
                  });
                }
                if (state is DesaDetailError) {
                  setState(() {
                    isLoading = false;
                  });
                }
              },
              child: BlocBuilder<DesaDetailBloc, DesaDetailState>(
                  cubit: desaDetailBloc,
                  builder: (_, DesaDetailState state) {
                    if (state is DesaDetailInitial) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: LoadingSkeletonListDesa(),
                      );
                    }
                    if (state is DesaDetailLoading) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: LoadingSkeletonListDesa(),
                      );
                    }
                    if (state is DesaDetailLoaded) {
                      return mainContent(state.desaDetailModel);
                    }
                    if (state is DesaDetailError) {
                      return Container();
                    }
                    return Container();
                  })),
        ));
  }

  Widget mainContent(DesaDetailModel desaDetailModel) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text('Tentang',
          //     style: GoogleFonts.poppins(
          //         fontSize: 19,
          //         color: Colors.black,
          //         fontWeight: FontWeight.bold)),
          // SizedBox(height: 8),
          // !bacaSelengkapnya
          //     ? Text('${desaDetailModel.data.shortContent}',
          //         style: GoogleFonts.poppins(
          //           fontSize: 11,
          //           color: Colors.black,
          //         ))
          //     : Html(
          //         data: desaDetailModel.data.content,
          //         style: {
          //           'body': Style(
          //               fontSize: FontSize(11),
          //               color: Colors.black,
          //               textAlign: TextAlign.justify,
          //               margin: EdgeInsets.zero,
          //               padding: EdgeInsets.zero),
          //         },
          //       ),
          // SizedBox(height: 8),
          // desaDetailModel.data.content == null
          //     ? Container()
          //     : GestureDetector(
          //         onTap: () {
          //           setState(() {
          //             bacaSelengkapnya = !bacaSelengkapnya;
          //           });
          //         },
          //         child: Text(
          //             !bacaSelengkapnya
          //                 ? 'Baca Selengkapnya'
          //                 : 'Baca Lebih Sedikit',
          //             style: GoogleFonts.poppins(
          //                 fontSize: 11,
          //                 color: Colors.black,
          //                 textStyle: TextStyle(
          //                   decoration: TextDecoration.underline,
          //                 ),
          //                 fontWeight: FontWeight.bold)),
          //       ),

          // Divider(
          //   color: Colors.black,
          // ),
          // SizedBox(height: 8),
          Text('Aneka Wisata',
              style: GoogleFonts.poppins(
                  fontSize: 19,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.90,
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: desaDetailModel.data.products.length,
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 16, crossAxisSpacing: 16),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, tempatDetailRoute,
                        arguments:
                            desaDetailModel.data.products[index].id.toString());
                  },
                  child: Container(
                    width: 150,
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          blurRadius: 2,
                          spreadRadius: 1.5,
                          offset: const Offset(
                            0.0,
                            5.5,
                          ),
                        )
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                      border: Border.all(
                        width: 1,
                        color: Colors.grey.withOpacity(0.2),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 9,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(14),
                                  topRight: Radius.circular(14),
                                ),
                                image: DecorationImage(
                                    image: desaDetailModel.data.products[index]
                                                .sourceImage ==
                                            ""
                                        ? AssetImage(
                                            'assets/images/placeholder.png')
                                        : NetworkImage(desaDetailModel
                                            .data.products[index].sourceImage),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        Expanded(
                          flex: 6,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    '${desaDetailModel.data.products[index].title}',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 4.0),
                                Text(
                                    '${desaDetailModel.data.products[index].categories[0].name}',
                                    style: GoogleFonts.roboto(
                                      fontSize: 11,
                                      color: Colors.black,
                                    )),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Container(
          //   width: double.infinity,
          //   height: 200,
          //   child: ListView.separated(
          //       shrinkWrap: true,
          //       physics: const BouncingScrollPhysics(),
          //       scrollDirection: Axis.horizontal,
          //       separatorBuilder: (BuildContext context, int index) {
          //         return const SizedBox(
          //           width: 16,
          //         );
          //       },
          //       itemCount: desaDetailModel.data.products.length,
          //       reverse: false,
          //       itemBuilder: (BuildContext context, int index) {
          //         return GestureDetector(
          //           onTap: () {
          //             Navigator.pushNamed(context, tempatDetailRoute,
          //                 arguments: desaDetailModel.data.products[index].id
          //                     .toString());
          //           },
          //           child: Container(
          //             width: 150,
          //             decoration: BoxDecoration(
          //               boxShadow: <BoxShadow>[
          //                 BoxShadow(
          //                   color: Colors.grey.withOpacity(0.4),
          //                   blurRadius: 5,
          //                   spreadRadius: 1.5,
          //                   offset: const Offset(
          //                     0.0,
          //                     5.5,
          //                   ),
          //                 )
          //               ],
          //               color: Colors.white,
          //               borderRadius: BorderRadius.all(Radius.circular(14)),
          //               border: Border.all(
          //                 width: 1,
          //                 color: Colors.grey.withOpacity(0.2),
          //               ),
          //             ),
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Expanded(
          //                   flex: 14,
          //                   child: Container(
          //                     decoration: BoxDecoration(
          //                         borderRadius: BorderRadius.only(
          //                           topLeft: Radius.circular(14),
          //                           topRight: Radius.circular(14),
          //                         ),
          //                         image: DecorationImage(
          //                             image: desaDetailModel
          //                                         .data
          //                                         .products[index]
          //                                         .sourceImage ==
          //                                     ''
          //                                 ? AssetImage(
          //                                     'assets/images/placeholder.png')
          //                                 : NetworkImage(desaDetailModel.data
          //                                     .products[index].sourceImage),
          //                             fit: BoxFit.cover)),
          //                   ),
          //                 ),
          //                 Spacer(
          //                   flex: 1,
          //                 ),
          //                 Expanded(
          //                   flex: 6,
          //                   child: Padding(
          //                     padding: const EdgeInsets.only(
          //                         left: 8.0, right: 8.0, top: 2.0),
          //                     child: Column(
          //                       crossAxisAlignment: CrossAxisAlignment.start,
          //                       children: [
          //                         Text(
          //                             '${desaDetailModel.data.products[index].title}',
          //                             style: GoogleFonts.montserrat(
          //                                 fontSize: 14,
          //                                 color: Colors.black,
          //                                 fontWeight: FontWeight.bold)),
          //                         SizedBox(height: 4.0),
          //                         Text(
          //                             '${desaDetailModel.data.products[index].categories[0].name}',
          //                             style: GoogleFonts.roboto(
          //                               fontSize: 11,
          //                               color: Colors.black,
          //                             )),
          //                       ],
          //                     ),
          //                   ),
          //                 )
          //               ],
          //             ),
          //           ),
          //         );
          //       }),
          // ),
        ],
      ),
    );
  }
}
