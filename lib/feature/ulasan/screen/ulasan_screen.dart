import 'dart:developer';
import 'dart:io';

import 'package:desa_wisata_nusantara/feature/tempat_detail/bloc/submit_review/bloc.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/domain/repo/tempat_detail_repo.dart';
import 'package:desa_wisata_nusantara/feature/ulasan/bloc/reff_kunjungan/bloc.dart';
import 'package:desa_wisata_nusantara/feature/ulasan/domain/repo/reff_kunjugan_repo.dart';
import 'package:desa_wisata_nusantara/feature/ulasan/model/argument_ulasan_model.dart';
import 'package:desa_wisata_nusantara/feature/ulasan/model/reff_kunjugan_model.dart';
import 'package:desa_wisata_nusantara/resources/color_swatch.dart';
import 'package:desa_wisata_nusantara/resources/route_string.dart';
import 'package:desa_wisata_nusantara/util/shared_preff.dart';
import 'package:desa_wisata_nusantara/widget/custom_dialog.dart';
import 'package:desa_wisata_nusantara/widget/custom_dialog_error.dart';
import 'package:desa_wisata_nusantara/widget/custom_dialog_login.dart';
import 'package:desa_wisata_nusantara/widget/custom_loading_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:month_picker_dialog/month_picker_dialog.dart';

class UlasanScreen extends StatefulWidget {
  final ArgumentUlasanModel argumentUlasanModel;

  const UlasanScreen(this.argumentUlasanModel);
  @override
  _UlasanScreenState createState() => _UlasanScreenState();
}

class _UlasanScreenState extends State<UlasanScreen> {
  DateTime selectedDate;
  List months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  double _initialRating = 2.0, _rating;
  IconData _selectedIcon;
  int _step = 1, index = 0;
  List<String> jenisKunjungan = [
    'Bisnis',
    'Dengan Teman',
    'Keluarga',
    'Pasangan',
    'Sendiri'
  ];

  String _valueUlasan = '',
      _valueJudul = '',
      _datePick = '',
      _jenisKunjunganSelect = '';
  List<Object> images = <Object>[];
  List<File> imageFileList = [];
  List<String> imagePath = [];
  bool isLoading = true, isEligible = false;

  SubmitReviewBloc submitReviewBloc =
      SubmitReviewBloc(tempatDetailRepo: TempatDetailRepo());
  ReffKunjunganBloc reffKunjunganBloc =
      ReffKunjunganBloc(reffKunjunganRepo: ReffKunjunganRepo());

  @override
  void dispose() {
    submitReviewBloc.close();
    reffKunjunganBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    selectedDate = DateTime.now();
    setState(() {
      _datePick = '${months[selectedDate.month - 1]}  ${selectedDate.year}';
      isEligible = true;
    });

    reffKunjunganBloc.add(GetReffKunjungan());
  }

  Future<bool> _requestPermission(Permission permission) async {
    var status = await permission.status;

    if (status.isDenied) {
      return false;
    } else {
      return true;
    }
  }

  _imgFromGallery() async {
    if (await _requestPermission(Permission.camera)) {
      try {
        imageCache.maximumSize = 0;
        imageCache.clear();
        final _images =
            await ImagePicker().getImage(source: ImageSource.gallery);
        if (_images != null) {
          final File image = File(_images.path);

          setState(() {
            imageFileList.add(image);
            imagePath.add(_images.path);
          });
        }
      } catch (e) {
        log('$e');
      }
    } else {
      log('gagal');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.close,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      widget.argumentUlasanModel.images == ''
                          ? Image.asset(
                              'assets/images/placeholder.jpg',
                              width: 50,
                              height: 50,
                            )
                          : Image.network(
                              '${widget.argumentUlasanModel.images}',
                              width: 50,
                              height: 50,
                            ),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${widget.argumentUlasanModel.title}',
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          Text('${widget.argumentUlasanModel.villageName}',
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: Colors.black,
                              )),
                          Text('${widget.argumentUlasanModel.address}',
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: Colors.black,
                              )),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  _step == 1
                      ? step1()
                      : _step == 2
                          ? step2()
                          : step3(),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _step == 1
                      ? Container(
                          height: 40,
                        )
                      : Container(
                          height: 40,
                          child: OutlinedButton(
                            onPressed: () {
                              setState(() {
                                _step--;
                              });
                            },
                            style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                                side:
                                    BorderSide(width: 1, color: primaryColor)),
                            child: Text('Sebelumnya',
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor)),
                          ),
                        ),
                  BlocListener<SubmitReviewBloc, SubmitReviewState>(
                      cubit: submitReviewBloc,
                      listener: (_, SubmitReviewState state) {
                        if (state is SubmitReviewLoading) {
                          showLoadingIndicator(
                              'Mengirimkan Ulasan Anda', context);
                        }
                        if (state is SubmitReviewLoaded) {
                          Navigator.pushNamedAndRemoveUntil(
                              context, successUlasanRoute, (route) => false);
                        }
                        if (state is SubmitReviewError) {
                          Navigator.pop(context);
                        }
                        if (state is SubmitReviewException) {
                          Navigator.pop(context);
                        }
                      },
                      child: BlocBuilder<SubmitReviewBloc, SubmitReviewState>(
                          cubit: submitReviewBloc,
                          builder: (_, SubmitReviewState state) {
                            if (state is SubmitReviewInitial) {
                              return btnSubmitMethod();
                            }
                            if (state is SubmitReviewLoading) {
                              return btnSubmitMethod();
                            }
                            if (state is SubmitReviewLoaded) {
                              return btnSubmitMethod();
                            }
                            if (state is SubmitReviewError) {
                              return btnSubmitMethod();
                            }
                            return btnSubmitMethod();
                          })),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget btnSubmitMethod() {
    return Container(
      height: 40,
      child: ElevatedButton(
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor: MaterialStateProperty.all<Color>(
                primaryColor,
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ))),
          child: Text(_step == 3 ? 'Submit' : 'Berikutnya',
              style: GoogleFonts.poppins(
                  fontSize: 14, fontWeight: FontWeight.bold)),
          onPressed: () {
            if (_step == 2) {
              if (_valueUlasan.length < 100 || _valueJudul.length < 20) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => CustomDialogError(
                          value: 'Harap isi ulasan dan judul ulasan Anda',
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ));
              } else {
                setState(() {
                  _step++;
                });
              }
            } else if (_step == 3) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => CustomDialog(
                        value:
                            'Saya menyatakan bahwa review ini berdasarkan pada saya sendiri, Pengalaman dan adalah pendapat asli saya, Pendiri dan bahwa saya tidak memiliki pribadi atau Hubungan bisnis dengan pendiri ini, dan belum ditawarkan insentif apapun atau pembayaran berasal dari pembentukan ke ulasan ini.',
                        onTap: () {
                          if (imageFileList.length == 0) {
                            submitReviewBloc.add(AttemptSubmitReview(
                                '',
                                '',
                                '',
                                widget.argumentUlasanModel.id,
                                _rating,
                                _datePick,
                                _valueUlasan,
                                _valueJudul,
                                _jenisKunjunganSelect));
                          } else if (imageFileList.length == 1) {
                            submitReviewBloc.add(AttemptSubmitReview(
                                imagePath[0],
                                '',
                                '',
                                widget.argumentUlasanModel.id,
                                _rating,
                                _datePick,
                                _valueUlasan,
                                _valueJudul,
                                _jenisKunjunganSelect));
                          } else if (imageFileList.length == 2) {
                            submitReviewBloc.add(AttemptSubmitReview(
                                imagePath[0],
                                imagePath[1],
                                '',
                                widget.argumentUlasanModel.id,
                                _rating,
                                _datePick,
                                _valueUlasan,
                                _valueJudul,
                                _jenisKunjunganSelect));
                          } else if (imageFileList.length == 3) {
                            submitReviewBloc.add(AttemptSubmitReview(
                                imagePath[0],
                                imagePath[1],
                                imagePath[2],
                                widget.argumentUlasanModel.id,
                                _rating,
                                _datePick,
                                _valueUlasan,
                                _valueJudul,
                                _jenisKunjunganSelect));
                          }
                        },
                      ));
            } else {
              setState(() {
                _step++;
              });
            }
          }),
    );
  }

  Widget step3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bagikan beberapa foto dari kunjungan Anda',
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            Text('Optional',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey,
                )),
          ],
        ),
        imageFileList.length == 0
            ? Container()
            : Wrap(
                alignment: WrapAlignment.start,
                direction: Axis.horizontal,
                spacing: 2,
                runSpacing: 2,
                children: imageFileList
                    .map((value) {
                      var index = imageFileList.indexOf(value);
                      return Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.5),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                  image: DecorationImage(
                                    image: FileImage(value),
                                    fit: BoxFit.fill,
                                  )),
                            ),
                          ),
                          Positioned(
                              top: 0.0,
                              right: 0.0,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    imageFileList.removeAt(index);
                                  });
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: Colors.grey),
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    child: Icon(
                                      Icons.close,
                                      size: 18,
                                    )),
                              )),
                        ],
                      );
                    })
                    .toList()
                    .cast<Widget>()),
        SizedBox(
          height: 24,
        ),
        Center(
          child: GestureDetector(
            onTap: () {
              if (imageFileList.length <= 3) {
                _imgFromGallery();
              }
            },
            child: Icon(
              CupertinoIcons.camera_circle,
              size: 40,
              color: Colors.grey,
            ),
          ),
        )
      ],
    );
  }

  Widget step2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Tulis Ulasan Anda',
            style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
        SizedBox(
          height: 8,
        ),
        GestureDetector(
          onTap: () async {
            final Object _args = await Navigator.pushNamed(
                context, tulisUlasanRoute,
                arguments: _valueUlasan);
            setState(() {
              _valueUlasan = _args;
            });
          },
          child: Text(
              _valueUlasan == ''
                  ? 'Kamu menilai pengalamanmu 5 dari 5. Ceritakan lebih lanjut'
                  : _valueUlasan,
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: _valueUlasan == '' ? Colors.grey : Colors.black)),
        ),
        SizedBox(
          height: 40,
        ),
        Text('Judul Ulasan',
            style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
        SizedBox(
          height: 8,
        ),
        GestureDetector(
          onTap: () async {
            final Object _args = await Navigator.pushNamed(
                context, tulisJudulUlasanRoute,
                arguments: _valueJudul);
            setState(() {
              _valueJudul = _args;
            });
          },
          child: Text(
              _valueJudul == ''
                  ? 'Ringkaskan kunjungan Anda dengan beberapa kata'
                  : _valueJudul,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: _valueJudul == '' ? Colors.grey : Colors.black,
              )),
        ),
      ],
    );
  }

  Widget step1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text('Bagaimana kamu menilai pengalamanmu?',
        //     style: GoogleFonts.poppins(
        //         fontSize: 14,
        //         color: Colors.black,
        //         fontWeight: FontWeight.bold)),
        // RatingBar.builder(
        //   initialRating: _initialRating,
        //   minRating: 1,
        //   direction: Axis.horizontal,
        //   allowHalfRating: true,
        //   unratedColor: primaryColor.withAlpha(50),
        //   itemCount: 5,
        //   itemSize: 50.0,
        //   itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
        //   itemBuilder: (context, _) => Icon(
        //     _selectedIcon ?? Icons.star,
        //     color: primaryColor,
        //   ),
        //   onRatingUpdate: (rating) {
        //     setState(() {
        //       _rating = rating;
        //       log('$_rating');
        //     });
        //   },
        //   updateOnDrag: true,
        //   glowColor: Colors.white,
        // ),
        // SizedBox(
        //   height: 24,
        // ),
        Text('Apa jenis kunjungan ini?',
            style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
        SizedBox(
          height: 8,
        ),
        BlocListener<ReffKunjunganBloc, ReffKunjunganState>(
            cubit: reffKunjunganBloc,
            listener: (_, ReffKunjunganState state) {
              if (state is ReffKunjunganLoaded) {}
              if (state is ReffKunjunganError) {}
            },
            child: BlocBuilder<ReffKunjunganBloc, ReffKunjunganState>(
                cubit: reffKunjunganBloc,
                builder: (_, ReffKunjunganState state) {
                  if (state is ReffKunjunganInitial) {
                    return Container();
                  }
                  if (state is ReffKunjunganLoading) {
                    return Container();
                  }
                  if (state is ReffKunjunganLoaded) {
                    return methodJenisKunjungan(state.reffKunjunganModel);
                  }
                  if (state is ReffKunjunganError) {
                    return Container();
                  }
                  return Container();
                })),
        SizedBox(
          height: 24,
        ),
        Text('Kapan Anda berkunjung?',
            style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
        SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              showMonthPicker(
                context: context,
                firstDate: DateTime(DateTime.now().year - 1, 5),
                lastDate: DateTime(DateTime.now().year + 1, 9),
                initialDate: selectedDate,
                locale: Locale('id'),
              ).then((date) {
                if (date != null) {
                  print(date.year);
                  print(DateTime.now().year);
                  print(date.month);
                  print(DateTime.now().month);
                  if (date.year <= DateTime.now().year) {
                    setState(() {
                      selectedDate = date;
                      _datePick =
                          '${months[selectedDate.month - 1]}  ${selectedDate.year}';
                    });
                  } else {
                    if (date.month <= DateTime.now().month) {
                      setState(() {
                        selectedDate = date;
                        _datePick =
                            '${months[selectedDate.month - 1]}  ${selectedDate.year}';
                      });
                    }
                  }
                }
              });
            },
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Text(
                            '$_datePick',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            CupertinoIcons.chevron_down,
                            size: 16,
                          )
                        ],
                      ))),
            ),
          ),
        )
      ],
    );
  }

  Widget methodJenisKunjungan(ReffKunjunganModel reffKunjunganModel) {
    return Wrap(
        alignment: WrapAlignment.start,
        spacing: 2,
        runSpacing: 2,
        direction: Axis.horizontal,
        children: reffKunjunganModel.data
            .map((item) {
              var _index = reffKunjunganModel.data.indexOf(item);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      index = _index;
                      _jenisKunjunganSelect = item.id;
                    });
                  },
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Container(
                        decoration: BoxDecoration(
                            color:
                                index == _index ? primaryColor : Colors.white,
                            border: Border.all(
                              color:
                                  index == _index ? primaryColor : Colors.grey,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              item.name,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: index == _index
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ))),
                  ),
                ),
              );
            })
            .toList()
            .cast<Widget>());
  }

  void showLoadingIndicator(String text, BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              backgroundColor: Colors.black,
              content: LoadingIndicator(text: text),
            ));
      },
    );
  }
}
