import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/bloc/get_likes/bloc.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/bloc/submit_likes/bloc.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/bloc/tempat_detail/bloc.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/domain/repo/tempat_detail_repo.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/model/tempat_detail_model.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/widget/gallery_widget.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/widget/loading_skeleton_tempat_detail.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/widget/photo_view_widget.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/widget/tanya_jawab_widget.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/widget/ulasan_widget.dart';
import 'package:desa_wisata_nusantara/resources/color_swatch.dart';
import 'package:desa_wisata_nusantara/resources/route_string.dart';
import 'package:desa_wisata_nusantara/util/dynamic_link_service.dart';
import 'package:desa_wisata_nusantara/util/general_util.dart';
import 'package:desa_wisata_nusantara/util/shared_preff.dart';
import 'package:desa_wisata_nusantara/widget/custom_dialog_login.dart';
import 'package:device_information/device_information.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:like_button/like_button.dart';

class TempatDetailScreen extends StatefulWidget {
  final String id;

  const TempatDetailScreen(this.id);
  @override
  _TempatDetailScreenState createState() => _TempatDetailScreenState();
}

class _TempatDetailScreenState extends State<TempatDetailScreen> {
  final DynamicLinkService _dynamicLinkService = DynamicLinkService();
  TempatDetailBloc tempatDetailBloc =
      TempatDetailBloc(tempatDetailRepo: TempatDetailRepo());
  GetLikesBloc getLikesBloc =
      GetLikesBloc(tempatDetailRepo: TempatDetailRepo());
  SubmitLikesBloc submitLikesBloc =
      SubmitLikesBloc(tempatDetailRepo: TempatDetailRepo());

  TempatDetailModel tempatDetailModel = TempatDetailModel();

  int _index = 0, _indexMenuDetail = 0;
  String _today = '';
  bool bacaSelengkapnya = false,
      isLoading = true,
      isLiked = false,
      isLoadingLikes = true;

  int likeCount = 0;

  final GlobalKey<LikeButtonState> _globalKey = GlobalKey<LikeButtonState>();

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  static final List<String> menuDetail = ['Ulasan', 'Tanya Jawab'];

  @override
  void dispose() {
    tempatDetailBloc.close();
    getLikesBloc.close();
    submitLikesBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    DateTime now = DateTime.now();

    print(now.hour.toString() + ":" + now.minute.toString());
    print(DateFormat('EEEE').format(DateTime.now()));
    tempatDetailBloc.add(GetTempatDetail(widget.id));

    setState(() {
      _today = GeneralUtil().dateConvert(DateTime.now().weekday);
    });
    super.initState();
  }

  void _launchURLWeb(String url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  Future<void> _initImei(bool isLike) async {
    String _imei;
    try {
      final PermissionStatus permissionStatus = await _getPhonePermission();
      if (permissionStatus.isGranted) {
        _imei = await DeviceInformation.deviceIMEINumber;
        print('imei: $_imei');
        SharedPreff().savedSharedString('imei', _imei);
        log('${GeneralUtil().encryptAES(_imei)}');
      }
    } on PlatformException {
      _imei = 'IMEI Device not Found';
    }
    if (!mounted) return;
    //disini
    submitLikesBloc.add(AttemptSubmitLikes(widget.id.toString(),
        isLike ? false : true, GeneralUtil().encryptAES(_imei)));
  }

  Future<void> _initImei2() async {
    String _imei;
    try {
      final PermissionStatus permissionStatus = await _getPhonePermission();
      if (permissionStatus.isGranted) {
        _imei = await DeviceInformation.deviceIMEINumber;
        print('imei: $_imei');
        SharedPreff().savedSharedString('imei', _imei);
        log('${GeneralUtil().encryptAES(_imei)}');
        getLikesBloc
            .add(AttemptGetLikes(widget.id, GeneralUtil().encryptAES(_imei)));
      }
    } on PlatformException {
      _imei = 'IMEI Device not Found';
    }
    if (!mounted) return;
  }

  Future<PermissionStatus> _getPhonePermission() async {
    final PermissionStatus permission = await Permission.phone.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.phone].request();
      return permissionStatus[Permission.phone] ??
          PermissionStatus.undetermined;
    } else if (permission == PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.phone].request();
      return permissionStatus[Permission.phone] ??
          PermissionStatus.undetermined;
    } else {
      return permission;
    }
  }

  Future<bool> onLikeButtonTapped(bool isLike) async {
    SharedPreff().getSharedString('imei').then((value) {
      if (value != null) {
        /// send your request here
        // final bool success= await sendRequest();

        /// if failed, you can do nothing
        // return success? !isLiked:isLiked;

        submitLikesBloc.add(AttemptSubmitLikes(widget.id.toString(),
            isLike ? false : true, GeneralUtil().encryptAES(value)));
      } else {
        _initImei(isLike);
      }
    });
  }

  Future<void> _pullRefresh() async {
    tempatDetailBloc.add(GetTempatDetail(widget.id));

    setState(() {
      _today = GeneralUtil().dateConvert(DateTime.now().weekday);
    });
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
              BlocListener<TempatDetailBloc, TempatDetailState>(
                  cubit: tempatDetailBloc,
                  listener: (_, TempatDetailState state) {
                    if (state is TempatDetailLoaded) {
                      setState(() {
                        tempatDetailModel = state.tempatDetailModel;
                        likeCount = state.tempatDetailModel.data.likes ?? 0;
                        isLoading = false;
                      });
                      SharedPreff().getSharedString('imei').then((value) {
                        if (value != null) {
                          /// send your request here
                          // final bool success= await sendRequest();

                          /// if failed, you can do nothing
                          // return success? !isLiked:isLiked;

                          getLikesBloc.add(AttemptGetLikes(
                              widget.id, GeneralUtil().encryptAES(value)));
                        } else {
                          _initImei2();
                        }
                      });
                    }
                    if (state is TempatDetailError) {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  child: BlocBuilder<TempatDetailBloc, TempatDetailState>(
                      cubit: tempatDetailBloc,
                      builder: (_, TempatDetailState state) {
                        if (state is TempatDetailInitial) {
                          return LoadingSkeletonTempatDetail();
                        }
                        if (state is TempatDetailLoading) {
                          return LoadingSkeletonTempatDetail();
                        }
                        if (state is TempatDetailLoaded) {
                          return detailContentMethod(state.tempatDetailModel);
                        }
                        if (state is TempatDetailError) {
                          return Container();
                        }
                        return Container();
                      })),
              SizedBox(height: 24),
              Container(
                width: double.infinity,
                height: 35,
                child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        width: 24,
                      );
                    },
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: menuDetail.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _indexMenuDetail = index;
                          });
                        },
                        child: Column(
                          children: <Widget>[
                            FittedBox(
                              child: Container(
                                child: Stack(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Text(
                                        menuDetail[index],
                                        style: GoogleFonts.poppins(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ),
                                    _indexMenuDetail == index
                                        ? Positioned.fill(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: <Widget>[
                                                SizedBox(height: 5),
                                                Container(
                                                  height: 4,
                                                  color: Colors.black,
                                                ),
                                              ],
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
              SizedBox(height: 16),
              isLoading
                  ? Container()
                  : _indexMenuDetail == 0
                      ? UlasanWidget(tempatDetailModel)
                      : TanyaJawabWidget(tempatDetailModel),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget detailContentMethod(TempatDetailModel tempatDetailModel) {
    return Column(
      children: [
        Stack(
          children: [
            GestureDetector(
              onTap: tempatDetailModel.data.photos.length == 0
                  ? null
                  : () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) =>
                      //           PhotoViewWidget(tempatDetailModel.data.photos),
                      //     ));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                GalleryWidget(tempatDetailModel.data.photos),
                          ));
                    },
              child: tempatDetailModel.data.photos.length == 0
                  ? Image.asset('assets/images/placeholder.png',
                      fit: BoxFit.cover, width: double.infinity)
                  : CarouselSlider(
                      items: tempatDetailModel.data.photos.map((fileImage) {
                        return fileImage.sourceImage == ""
                            ? Image.asset('assets/images/$fileImage',
                                fit: BoxFit.cover, width: double.infinity)
                            : Image.network(fileImage.sourceImage,
                                fit: BoxFit.cover, width: double.infinity);
                      }).toList(),
                      options: CarouselOptions(
                        onPageChanged: (index, reason) {
                          setState(() {
                            _index = index;
                          });
                        },
                        height: 300,
                        autoPlay: true,
                        aspectRatio: 1.0,
                        viewportFraction: 1.0,
                      ),
                    ),
            ),
            Positioned(
              bottom: 16.0,
              right: 12.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                    map<Widget>(tempatDetailModel.data.photos, (index, url) {
                  return Container(
                    width: 12.0,
                    height: 12.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _index == index ? primaryColor : Colors.white70,
                    ),
                  );
                }),
              ),
            ),
            Positioned(
              top: 30.0,
              left: 12.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
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
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${tempatDetailModel.data.title}',
                      style: GoogleFonts.poppins(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                  BlocListener<GetLikesBloc, GetLikesState>(
                      cubit: getLikesBloc,
                      listener: (_, GetLikesState state) {
                        if (state is GetLikesLoaded) {
                          setState(() {
                            isLiked = state.getLikesModel.data.isLiked;
                            isLoadingLikes = false;
                          });
                        }
                        if (state is GetLikesError) {}
                        if (state is GetLikesException) {}
                      },
                      child: BlocBuilder<GetLikesBloc, GetLikesState>(
                          cubit: getLikesBloc,
                          builder: (_, GetLikesState state) {
                            if (state is GetLikesInitial) {
                              return blocSubmitLikes();
                            }
                            if (state is GetLikesLoading) {
                              return blocSubmitLikes();
                            }
                            if (state is GetLikesLoaded) {
                              return blocSubmitLikes();
                            }
                            if (state is GetLikesError) {
                              return blocSubmitLikes();
                            }
                            if (state is GetLikesException) {
                              return blocSubmitLikes();
                            }
                            return blocSubmitLikes();
                          })),
                ],
              ),
              Text('${tempatDetailModel.data.locations.villageName}',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: Colors.black,
                  )),
              Text('${tempatDetailModel.data.locations.locationName}',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: Colors.black,
                  )),
              SizedBox(height: 8),
              Row(
                children: [
                  // RatingBar.builder(
                  //   initialRating: double.parse(
                  //       tempatDetailModel.data.ratings.summaries.point),
                  //   minRating: 1,
                  //   ignoreGestures: true,
                  //   direction: Axis.horizontal,
                  //   allowHalfRating: true,
                  //   unratedColor: primaryColor.withAlpha(50),
                  //   itemCount: 5,
                  //   itemSize: 14.0,
                  //   itemBuilder: (context, _) => Icon(
                  //     Icons.star,
                  //     color: primaryColor,
                  //   ),
                  //   onRatingUpdate: (rating) {},
                  //   updateOnDrag: false,
                  //   glowColor: Colors.white,
                  // ),
                  Container(),
                  SizedBox(width: 4),
                  Text(
                      '${tempatDetailModel.data.ratings.summaries.total} ulasan',
                      style: GoogleFonts.poppins(
                          fontSize: 9, color: Colors.black)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      _launchURLWeb(tempatDetailModel.data.contacts.website);
                    },
                    child: Text('Situs Web',
                        style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: Colors.black,
                            textStyle: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(width: 16),
                  GestureDetector(
                    onTap: () {
                      _launchURLWeb(
                          'tel://${tempatDetailModel.data.contacts.phone}');
                    },
                    child: Text('Hubungi',
                        style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: Colors.black,
                            textStyle: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              Text('Tentang',
                  style: GoogleFonts.poppins(
                      fontSize: 19,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              !bacaSelengkapnya
                  ? Text('${tempatDetailModel.data.shortContent}',
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: Colors.black,
                      ))
                  : Html(
                      data: tempatDetailModel.data.content,
                      style: {
                        'body': Style(
                            fontSize: FontSize(11),
                            color: Colors.black,
                            textAlign: TextAlign.justify,
                            margin: EdgeInsets.zero,
                            padding: EdgeInsets.zero),
                      },
                    ),
              SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  setState(() {
                    bacaSelengkapnya = !bacaSelengkapnya;
                  });
                },
                child: Text(
                    !bacaSelengkapnya
                        ? 'Baca Selengkapnya'
                        : 'Baca Lebih Sedikit',
                    style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: Colors.black,
                        textStyle: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 8),
              tempatDetailModel.data.currentHour == null
                  ? Container()
                  : Divider(
                      color: Colors.black,
                    ),
              tempatDetailModel.data.currentHour == null
                  ? Container()
                  : InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, jamBukaRoute,
                            arguments: tempatDetailModel.data.hours);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              tempatDetailModel.data.currentHour.isOpen
                                  ? Text('Sekarang buka',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ))
                                  : Text('Sekarang tutup',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: Colors.black,
                                      )),
                              Text('${tempatDetailModel.data.currentHour.hour}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Colors.black,
                                  )),
                            ],
                          ),
                          Icon(
                            CupertinoIcons.right_chevron,
                            size: 29,
                          )
                        ],
                      ),
                    ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(
                color: Colors.black,
              ),
              Text('Fasilitas',
                  style: GoogleFonts.poppins(
                      fontSize: 19,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(tempatDetailModel.data.facility,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: Colors.black,
                  )),
              // SizedBox(height: 16),
              // Container(
              //   width: double.infinity,
              //   height: 50,
              //   child: OutlinedButton(
              //     onPressed: () {
              //       Navigator.pushNamed(context, semuaFasilitasRoute,
              //           arguments: tempatDetailModel.data.facility);
              //     },
              //     style: OutlinedButton.styleFrom(
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(24.0),
              //         ),
              //         side: BorderSide(width: 1, color: primaryColor)),
              //     child: Text('Lihat semua fasilitas',
              //         style: GoogleFonts.poppins(
              //             fontSize: 14,
              //             fontWeight: FontWeight.bold,
              //             color: primaryColor)),
              //   ),
              // ),
              SizedBox(height: 16),
              Divider(
                color: Colors.black,
              ),
              SizedBox(height: 4),
              Text('Yang perlu Kamu persiapkan',
                  style: GoogleFonts.poppins(
                      fontSize: 19,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(tempatDetailModel.data.preparation,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: Colors.black,
                  )),
              SizedBox(height: 16),
              Divider(
                color: Colors.black,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            width: double.infinity,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4),
                    Text('Lokasi',
                        style: GoogleFonts.poppins(
                            fontSize: 19,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: Text(
                          '${tempatDetailModel.data.locations.locationName}',
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: Colors.black,
                          )),
                    ),
                    SizedBox(height: 4),
                    Text('Jarak tempuh',
                        style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 2),
                    Text('${tempatDetailModel.data.locations.mileage}',
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: Colors.black,
                        )),
                    SizedBox(height: 2),
                    Text('Waktu tempuh',
                        style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 2),
                    Text('${tempatDetailModel.data.locations.travelingTime}',
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: Colors.black,
                        )),
                    SizedBox(height: 2),
                    Text('Kondisi Akses Jalan',
                        style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 2),
                    Text('${tempatDetailModel.data.locations.roadCondition}',
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: Colors.black,
                        )),
                    SizedBox(height: 2),
                    Text('Ketersediaan Transportasi',
                        style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 2),
                    Text(
                        '${tempatDetailModel.data.locations.transportationAvail}',
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: Colors.black,
                        )),
                  ],
                ),
                Positioned(
                  top: 8.0,
                  right: 0.0,
                  child: GestureDetector(
                    onTap: () {
                      final split =
                          tempatDetailModel.data.locations.latLng.split(',');
                      openMap(double.parse(split[0]), double.parse(split[1]));
                    },
                    child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(22))),
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(CupertinoIcons.arrow_up_right_square_fill,
                                    size: 21, color: Colors.white),
                                SizedBox(width: 4),
                                Text('Arahkan',
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ))),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),
        Image.network(tempatDetailModel.data.locations.sourceMap,
            fit: BoxFit.cover, width: double.infinity),
      ],
    );
  }

  Widget blocSubmitLikes() {
    return BlocListener<SubmitLikesBloc, SubmitLikesState>(
        cubit: submitLikesBloc,
        listener: (_, SubmitLikesState state) {
          if (state is SubmitLikesLoaded) {
            setState(() {
              isLiked = state.submitLikesModel.data.isLiked;
              if (isLiked) {
                likeCount++;
              } else {
                likeCount--;
              }
            });
          }
          if (state is SubmitLikesError) {}
          if (state is SubmitLikesException) {}
        },
        child: BlocBuilder<SubmitLikesBloc, SubmitLikesState>(
            cubit: submitLikesBloc,
            builder: (_, SubmitLikesState state) {
              if (state is SubmitLikesInitial) {
                return likeMethod();
              }
              if (state is SubmitLikesLoading) {
                return likeMethod();
              }
              if (state is SubmitLikesLoaded) {
                return likeMethod();
              }
              if (state is SubmitLikesError) {
                return likeMethod();
              }
              if (state is SubmitLikesException) {
                return likeMethod();
              }
              return likeMethod();
            }));
  }

  Widget likeMethod() {
    return Row(
      children: [
        Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: LikeButton(
                size: 25.0,
                likeCount: likeCount,
                isLiked: isLiked,
                key: _globalKey,
                countBuilder: (int count, bool isLiked, String text) {
                  ColorSwatch<int> color = isLiked ? Colors.red : Colors.grey;
                  Widget result;
                  if (count == 0) {
                    result = Text(
                      '',
                      style: TextStyle(color: color),
                    );
                  } else
                    result = Align(
                      alignment: Alignment.center,
                      child: Text(
                        count >= 1000
                            ? (count / 1000.0).toStringAsFixed(1) + 'k'
                            : text,
                        style: TextStyle(color: color, fontSize: 15),
                      ),
                    );
                  return result;
                },
                likeCountAnimationType: likeCount < 1000
                    ? LikeCountAnimationType.part
                    : LikeCountAnimationType.none,
                onTap: onLikeButtonTapped,
              ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     SizedBox(width: 4),
              //     Icon(Icons.favorite_border_outlined,
              //         size: 10, color: primaryColor),
              //     SizedBox(width: 4),
              //     Text(
              //         tempatDetailModel.data.likes.toString() ==
              //                 'null'
              //             ? '0'
              //             : tempatDetailModel.data.likes.toString(),
              //         style: GoogleFonts.poppins(
              //             fontSize: 10,
              //             color: primaryColor,
              //             fontWeight: FontWeight.bold)),
              //     SizedBox(width: 4),
              //   ],
              // )
            )),
        FutureBuilder<Uri>(
            future: _dynamicLinkService.createDynamicLink(widget.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Uri uri = snapshot.data;
                return GestureDetector(
                  onTap: () => Share.share(
                      'Hai, Aku mambagikan wisata dari aplikas desa wisata nusantara\n${uri.toString()}'),
                  child: Icon(Icons.share_outlined, color: Colors.black),
                );
              } else {
                return Container();
              }
            }),
      ],
    );
  }
}
