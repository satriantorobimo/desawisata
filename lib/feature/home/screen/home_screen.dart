import 'package:carousel_slider/carousel_slider.dart';
import 'package:desa_wisata_nusantara/feature/akun/bloc/akun/bloc.dart';
import 'package:desa_wisata_nusantara/feature/akun/domain/repo/akun_repo.dart';
import 'package:desa_wisata_nusantara/feature/home/bloc/category_home/bloc.dart';
import 'package:desa_wisata_nusantara/feature/home/bloc/highlight/bloc.dart';
import 'package:desa_wisata_nusantara/feature/home/bloc/perkab/bloc.dart';
import 'package:desa_wisata_nusantara/feature/home/bloc/popular/bloc.dart';
import 'package:desa_wisata_nusantara/feature/home/domain/repo/category_home_repo.dart';
import 'package:desa_wisata_nusantara/feature/home/domain/repo/highlight_repo.dart';
import 'package:desa_wisata_nusantara/feature/home/model/category_home_model.dart';
import 'package:desa_wisata_nusantara/feature/home/model/highlight_model.dart';
import 'package:desa_wisata_nusantara/feature/home/model/menu_model.dart';
import 'package:desa_wisata_nusantara/feature/home/model/per_kab_model.dart';
import 'package:desa_wisata_nusantara/feature/home/widget/loading_skeleton.dart';
import 'package:desa_wisata_nusantara/feature/home/widget/loading_skeleton_small.dart';
import 'package:desa_wisata_nusantara/resources/color_swatch.dart';
import 'package:desa_wisata_nusantara/resources/route_string.dart';
import 'package:desa_wisata_nusantara/util/shared_preff.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:desa_wisata_nusantara/feature/home/model/category_home_model.dart'
    as category;
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HighlightBloc highlightBloc = HighlightBloc(highlightRepo: HighlightRepo());
  PopularBloc popularBloc = PopularBloc(highlightRepo: HighlightRepo());
  PerKabBloc perKabBloc = PerKabBloc(highlightRepo: HighlightRepo());
  AkunBloc akunBloc = AkunBloc(akunRepo: AkunRepo());
  CategoryHomeBloc categoryHomeBloc =
      CategoryHomeBloc(categoryHomeRepo: CategoryHomeRepo());

  static final List<String> imgSliderRencana = [
    'sumatra.jpg',
    'jawa.jpg',
    'papua.jpg',
  ];
  int _index = 0;
  bool isEligible = false, isLoading = true;
  List<Menu> menu = [];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  void dispose() {
    highlightBloc.close();
    popularBloc.close();
    perKabBloc.close();
    categoryHomeBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    setState(() {
      menu.add(
          Menu(id: '1', name: 'Edukasi', image: 'assets/images/edukasi.png'));
      menu.add(
          Menu(id: '2', name: 'Kuliner', image: 'assets/images/kuliner.png'));
      menu.add(Menu(
          id: '3', name: 'Agrowisata', image: 'assets/images/agrowisata.png'));
      menu.add(
          Menu(id: '4', name: 'Religi', image: 'assets/images/religi.png'));
      menu.add(
          Menu(id: '5', name: 'Sejarah', image: 'assets/images/sejarah.png'));
      menu.add(Menu(id: '6', name: 'Situs', image: 'assets/images/situs.png'));
      menu.add(
          Menu(id: '7', name: 'Pantai', image: 'assets/images/pantai.png'));
      menu.add(Menu(
          id: '8',
          name: 'Selanjutnya',
          image: 'assets/images/selanjutnya.png'));
      isLoading = false;
    });
    highlightBloc.add(GetHighlightContent());
    popularBloc.add(GetPopularContent());
    perKabBloc.add(GetTotalPerKab());
    categoryHomeBloc.add(GetCategoryHome());
    SharedPreff().getSharedString('token').then((value) {
      if (value != null) {
        akunBloc.add(GetAkun());
        setState(() {
          isEligible = true;
        });
      }
    });
    super.initState();
  }

  Future<void> _pullRefresh() async {
    highlightBloc.add(GetHighlightContent());
    popularBloc.add(GetPopularContent());
    perKabBloc.add(GetTotalPerKab());
    categoryHomeBloc.add(GetCategoryHome());
  }

  Future<void> _bottomSheet(List<category.Data> datas) async {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.62,
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(25.0),
            topRight: const Radius.circular(25.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Category',
                  style: GoogleFonts.poppins(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.50,
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: datas.length,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, mainAxisSpacing: 16),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, listCategoryRoute,
                            arguments: datas[index]);
                      },
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(10.0),
                              padding: EdgeInsets.all(16.0),
                              child: Image.network(datas[index].icon),
                              decoration: BoxDecoration(
                                  color: Color(0xFFF2F2F2),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      spreadRadius: 1,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                  shape: BoxShape.circle),
                            ),
                          ),
                          Text('${datas[index].name}',
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                color: Colors.black.withOpacity(0.5),
                              ))
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: _pullRefresh,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              !isEligible
                  ? Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/images/logo_home.png',
                                height: 55,
                              ),
                              SizedBox(width: 8),
                              Image.asset(
                                'assets/images/logo_home_2.png',
                                height: 45,
                              ),
                            ],
                          ),
                          CircleAvatar(
                            radius: 30.0,
                            backgroundImage:
                                AssetImage("assets/images/tuyul.png"),
                            backgroundColor: Colors.transparent,
                          )
                        ],
                      ),
                    )
                  : BlocListener<AkunBloc, AkunState>(
                      cubit: akunBloc,
                      listener: (_, AkunState state) {
                        if (state is AkunLoaded) {}
                        if (state is AkunError) {}
                      },
                      child: BlocBuilder<AkunBloc, AkunState>(
                          cubit: akunBloc,
                          builder: (_, AkunState state) {
                            if (state is AkunInitial) {
                              return Container();
                            }
                            if (state is AkunLoading) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0, right: 16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Shimmer.fromColors(
                                        baseColor: Colors.grey[300],
                                        highlightColor: Colors.grey[100],
                                        child: Container(
                                          width: 160,
                                          height: 55,
                                          color: Colors.white,
                                        )),
                                    Shimmer.fromColors(
                                        baseColor: Colors.grey[300],
                                        highlightColor: Colors.grey[100],
                                        child: Container(
                                          width: 60,
                                          height: 60,
                                          margin: EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle),
                                        )),
                                  ],
                                ),
                              );
                            }
                            if (state is AkunLoaded) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0, right: 16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          'assets/images/logo_home.png',
                                          height: 55,
                                        ),
                                        SizedBox(width: 8),
                                        Image.asset(
                                          'assets/images/logo_home_2.png',
                                          height: 45,
                                        ),
                                      ],
                                    ),
                                    CircleAvatar(
                                      radius: 25.0,
                                      backgroundImage: NetworkImage(
                                          "${state.akunModel.data.sourceImage}"),
                                      backgroundColor: Colors.transparent,
                                    )
                                  ],
                                ),
                              );
                            }
                            if (state is AkunError) {
                              return Container();
                            }
                            return Container();
                          }),
                    ),
              BlocListener<CategoryHomeBloc, CategoryHomeState>(
                  cubit: categoryHomeBloc,
                  listener: (_, CategoryHomeState state) {
                    if (state is CategoryHomeLoaded) {}
                    if (state is CategoryHomeError) {}
                  },
                  child: BlocBuilder<CategoryHomeBloc, CategoryHomeState>(
                      cubit: categoryHomeBloc,
                      builder: (_, CategoryHomeState state) {
                        if (state is CategoryHomeInitial) {
                          return loadingSkeletonMenu(context);
                        }
                        if (state is CategoryHomeLoading) {
                          return loadingSkeletonMenu(context);
                        }
                        if (state is CategoryHomeLoaded) {
                          return contentCategory(state.categoryHomeModel);
                        }
                        if (state is CategoryHomeError) {
                          return Container();
                        }
                        return Container();
                      })),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('Rencanakan liburan Anda',
                    style: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('Jelajahi desa, mari kita bangun perekonomian desa',
                    style: GoogleFonts.montserrat(
                      fontSize: 10,
                      color: Colors.black,
                    )),
              ),
              SizedBox(height: 16),
              BlocListener<PerKabBloc, PerKabState>(
                  cubit: perKabBloc,
                  listener: (_, PerKabState state) {
                    if (state is PerKabLoaded) {}
                    if (state is PerKabError) {}
                  },
                  child: BlocBuilder<PerKabBloc, PerKabState>(
                      cubit: perKabBloc,
                      builder: (_, PerKabState state) {
                        if (state is PerKabInitial) {
                          return LoadingSkeletonSmall();
                        }
                        if (state is PerKabLoading) {
                          return LoadingSkeletonSmall();
                        }
                        if (state is PerKabLoaded) {
                          return perkabMethod(state.perKabModel);
                        }
                        if (state is PerKabError) {
                          return Container();
                        }
                        return Container();
                      })),
              SizedBox(height: 32),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
              //   child: Container(
              //     width: double.infinity,
              //     height: 180.0,
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.all(Radius.circular(12)),
              //         image: DecorationImage(
              //             image: AssetImage(
              //               'assets/images/travel.jpg',
              //             ),
              //             fit: BoxFit.fill,
              //             colorFilter: ColorFilter.mode(
              //                 Colors.grey.withOpacity(0.4), BlendMode.darken))),
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //         Text('Desa Wisata yang menarik disekitarmu ',
              //             textAlign: TextAlign.center,
              //             style: GoogleFonts.poppins(
              //                 fontSize: 24,
              //                 color: Colors.white,
              //                 fontWeight: FontWeight.bold)),
              //         SizedBox(height: 16),
              //         Container(
              //           width: 160,
              //           height: 40,
              //           child: ElevatedButton(
              //             style: ButtonStyle(
              //                 foregroundColor: MaterialStateProperty.all<Color>(
              //                     Colors.transparent),
              //                 backgroundColor: MaterialStateProperty.all<Color>(
              //                   Colors.transparent,
              //                 ),
              //                 shape: MaterialStateProperty.all<
              //                         RoundedRectangleBorder>(
              //                     RoundedRectangleBorder(
              //                   side: BorderSide(color: Colors.white),
              //                   borderRadius: BorderRadius.circular(20.0),
              //                 ))),
              //             child: Text('Terus Telusuri',
              //                 style: GoogleFonts.poppins(
              //                     fontSize: 14,
              //                     fontWeight: FontWeight.bold,
              //                     color: Colors.white)),
              //             onPressed: () {},
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              // SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('Destinasi populer',
                    style: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('Tempat wisata  terpopuler berdasarkan ulasan',
                    style: GoogleFonts.montserrat(
                      fontSize: 10,
                      color: Colors.black,
                    )),
              ),
              BlocListener<PopularBloc, PopularState>(
                  cubit: popularBloc,
                  listener: (_, PopularState state) {
                    if (state is PopularLoaded) {}
                    if (state is PopularError) {}
                  },
                  child: BlocBuilder<PopularBloc, PopularState>(
                      cubit: popularBloc,
                      builder: (_, PopularState state) {
                        if (state is PopularInitial) {
                          return LoadingSkeletonHiglight();
                        }
                        if (state is PopularLoading) {
                          return LoadingSkeletonHiglight();
                        }
                        if (state is PopularLoaded) {
                          return popularMethod(state.highlightModel);
                        }
                        if (state is PopularError) {
                          return LoadingSkeletonHiglight();
                        }
                        return LoadingSkeletonHiglight();
                      })),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget contentCategory(CategoryHomeModel categoryHomeModel) {
    return SizedBox(
      height: categoryHomeModel.data.length < 8
          ? MediaQuery.of(context).size.height * 0.35
          : MediaQuery.of(context).size.height * 0.55,
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: categoryHomeModel.data.length,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, mainAxisSpacing: 16),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, listCategoryRoute,
                  arguments: categoryHomeModel.data[index]);
            },
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    padding: EdgeInsets.all(8.0),
                    child: Image.network(categoryHomeModel.data[index].icon),
                    decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        shape: BoxShape.circle),
                  ),
                ),
                Text('${categoryHomeModel.data[index].name}',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      color: Colors.black.withOpacity(0.5),
                    ))
              ],
            ),
          );
        },
      ),
    );
  }

  SizedBox loadingSkeletonMenu(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: 8,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, mainAxisSpacing: 16),
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Expanded(
                child: Shimmer.fromColors(
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.grey[100],
                    child: Container(
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                    )),
              ),
              Shimmer.fromColors(
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.grey[100],
                  child: Container(
                    width: 50,
                    height: 15,
                    color: Colors.white,
                  )),
            ],
          );
        },
      ),
    );
  }

  Widget perkabMethod(PerKabModel perKabModel) {
    return Container(
      width: double.infinity,
      height: 175,
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
          itemCount: perKabModel.data.length,
          reverse: false,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, listDesaRoute,
                    arguments: perKabModel.data[index]);
              },
              child: Container(
                width: 291.0,
                height: 180.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    image: DecorationImage(
                        image: perKabModel.data[index].sourceImage == ""
                            ? AssetImage(
                                'assets/images/placeholder.png',
                              )
                            : NetworkImage(
                                '${perKabModel.data[index].sourceImage}',
                              ),
                        colorFilter: ColorFilter.mode(
                            Colors.grey.withOpacity(0.4), BlendMode.darken),
                        fit: BoxFit.cover)),
                child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, right: 16.0, top: 8),
                    child: RichText(
                        text: TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: '${perKabModel.data[index].namaProv}\n',
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: '${perKabModel.data[index].namaKab}\n',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      TextSpan(
                        text:
                            '${perKabModel.data[index].total} tujuan desa wisata',
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ]))),
              ),
            );
          }),
    );
  }

  Widget popularMethod(HighlightModel highlightModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.separated(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 10,
            );
          },
          itemCount: highlightModel.data.length,
          reverse: false,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, tempatDetailRoute,
                    arguments: highlightModel.data[index].id.toString());
              },
              child: Container(
                width: double.infinity,
                height: 160.0,
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
                                image: highlightModel.data[index].sourceImage ==
                                        ""
                                    ? AssetImage(
                                        'assets/images/placeholder.png',
                                      )
                                    : NetworkImage(
                                        '${highlightModel.data[index].sourceImage}'),
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
                            Text('${highlightModel.data[index].title}',
                                style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 4),
                            Text(
                                '${highlightModel.data[index].villageName}, ${highlightModel.data[index].locationName}',
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
                              children: highlightModel.data[index].categories
                                  .map((item) {
                                return Container(
                                    decoration: BoxDecoration(
                                        color:
                                            Color(0xFF2E3285).withOpacity(0.6),
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
                            Text('${highlightModel.data[index].shortContent}',
                                style: GoogleFonts.poppins(
                                    fontSize: 9, color: Colors.black)),
                            SizedBox(height: 8),
                            // Row(
                            //   children: [
                            //     RatingBar.builder(
                            //       ignoreGestures: true,
                            //       initialRating: double.parse(
                            //           highlightModel.data[index].ratings.point),
                            //       minRating: 1,
                            //       direction: Axis.horizontal,
                            //       allowHalfRating: true,
                            //       unratedColor: primaryColor.withAlpha(50),
                            //       itemCount: 5,
                            //       itemSize: 14.0,
                            //       itemBuilder: (context, _) => Icon(
                            //         Icons.star,
                            //         color: primaryColor,
                            //       ),
                            //       onRatingUpdate: (rating) {},
                            //       updateOnDrag: false,
                            //       glowColor: Colors.white,
                            //     ),
                            //     SizedBox(width: 4),
                            //     Text(
                            //         '${highlightModel.data[index].ratings.total} ulasan',
                            //         style: GoogleFonts.poppins(
                            //             fontSize: 9, color: Colors.black)),
                            //   ],
                            // ),
                            // SizedBox(height: 8),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget carouselHighlightMethod(HighlightModel highlightModel) {
    return Stack(
      children: [
        CarouselSlider(
          items: highlightModel.data.map((fileImage) {
            return Stack(children: <Widget>[
              fileImage.sourceImage == ''
                  ? Image.asset('assets/images/lombok2.jpg',
                      fit: BoxFit.cover, width: double.infinity)
                  : Image.network(fileImage.sourceImage,
                      fit: BoxFit.cover, width: double.infinity),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 16,
                      runSpacing: 4,
                      direction: Axis.horizontal,
                      children: fileImage.categories.map((item) {
                        return Container(
                            decoration: BoxDecoration(
                                color: Color(0xFF2E3285).withOpacity(0.6),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${item.name}',
                                  style: GoogleFonts.poppins(
                                      fontSize: 12, color: Colors.white)),
                            ));
                      }).toList(),
                    ),
                    SizedBox(height: 8),
                    Text('${fileImage.title}',
                        style: GoogleFonts.poppins(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    Text('${fileImage.villageName}',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.white,
                        )),
                    Text('${fileImage.locationName}',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.white,
                        )),
                    SizedBox(height: 16),
                    Container(
                      width: 160,
                      height: 40,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              primaryColor,
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ))),
                        child: Text('Lebih lanjut',
                            style: GoogleFonts.poppins(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                        onPressed: () {
                          Navigator.pushNamed(context, tempatDetailRoute,
                              arguments: fileImage.id.toString());
                        },
                      ),
                    )
                  ],
                ),
              )
            ]);
          }).toList(),
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              setState(() {
                _index = index;
                print(_index);
              });
            },
            height: 425,
            autoPlay: true,
            aspectRatio: 1.0,
            viewportFraction: 1.0,
          ),
        ),
        Positioned(
          bottom: 16.0,
          right: 12.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: map<Widget>(highlightModel.data, (index, url) {
              return Container(
                width: 12.0,
                height: 12.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _index == index ? primaryColor : Colors.white70,
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
