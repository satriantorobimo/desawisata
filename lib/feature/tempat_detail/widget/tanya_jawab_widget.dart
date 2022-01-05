import 'package:desa_wisata_nusantara/feature/tempat_detail/bloc/pertanyaan/bloc.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/bloc/submit_question/bloc.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/domain/repo/tempat_detail_repo.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/model/pertanyaan_model.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/model/tempat_detail_model.dart';
import 'package:desa_wisata_nusantara/resources/color_swatch.dart';
import 'package:desa_wisata_nusantara/resources/route_string.dart';
import 'package:desa_wisata_nusantara/util/shared_preff.dart';
import 'package:desa_wisata_nusantara/widget/custom_dialog_login.dart';
import 'package:desa_wisata_nusantara/widget/custom_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'loading_skeleton_review.dart';

class TanyaJawabWidget extends StatefulWidget {
  final TempatDetailModel tempatDetailModel;
  TanyaJawabWidget(this.tempatDetailModel);
  @override
  _TanyaJawabWidgetState createState() => _TanyaJawabWidgetState();
}

class _TanyaJawabWidgetState extends State<TanyaJawabWidget> {
  PertanyaanBloc pertanyaanBloc =
      PertanyaanBloc(tempatDetailRepo: TempatDetailRepo());
  SubmitQuestionBloc submitQuestionBloc =
      SubmitQuestionBloc(tempatDetailRepo: TempatDetailRepo());

  List<Items> pertanyaanModel;

  bool isLoading = false;

  TextEditingController _pertanyaanCtrl = TextEditingController();
  int _lengthText = 0;

  int _page = 1;

  @override
  void dispose() {
    pertanyaanBloc.close();
    submitQuestionBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    pertanyaanBloc.add(
        GetPertanyaan(widget.tempatDetailModel.data.id.toString(), 10, _page));

    super.initState();
  }

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        isScrollControlled: true,
        builder: (builder) {
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: ListView(shrinkWrap: true, children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'Berikan Pertanyaan',
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 16),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'Dapatkan jawaban cepat dari staf ${widget.tempatDetailModel.data.title} dan tamu yang pernah berkunjung.',
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.black),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(3.0),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                child: TextField(
                  maxLines: 6,
                  controller: _pertanyaanCtrl,
                  onChanged: (value) {
                    setState(() {
                      _lengthText = value.length;
                    });
                  },
                  decoration: InputDecoration.collapsed(
                      hintText:
                          'Hai, informasi apa yang ingin Anda ketahui tentang akomodasi ini?',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey,
                      )),
                ),
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.40,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.white,
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ))),
                      child: Text('Cancel',
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.40,
                    child: ElevatedButton(
                      onPressed: () {
                        submitQuestionBloc.add(GetSubmitQuestion(
                            widget.tempatDetailModel.data.id.toString(),
                            _pertanyaanCtrl.text));
                      },
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            primaryColor,
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ))),
                      child: Text('Submit',
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
            ]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocListener<SubmitQuestionBloc, SubmitQuestionState>(
              cubit: submitQuestionBloc,
              listener: (_, SubmitQuestionState state) {
                if (state is SubmitQuestionLoading) {
                  showLoadingIndicator('Mengirimkan Ulasan Anda', context);
                }
                if (state is SubmitQuestionLoaded) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, successPertanyaanRoute, (route) => false);
                }
                if (state is SubmitQuestionError) {
                  Navigator.pop(context);
                }
              },
              child: BlocBuilder<SubmitQuestionBloc, SubmitQuestionState>(
                  cubit: submitQuestionBloc,
                  builder: (_, SubmitQuestionState state) {
                    if (state is SubmitQuestionInitial) {
                      return btnTanyaMethod();
                    }
                    if (state is SubmitQuestionLoading) {
                      return btnTanyaMethod();
                    }
                    if (state is SubmitQuestionLoaded) {
                      return btnTanyaMethod();
                    }
                    if (state is SubmitQuestionError) {
                      return btnTanyaMethod();
                    }
                    return Container();
                  })),
          BlocListener<PertanyaanBloc, PertanyaanState>(
              cubit: pertanyaanBloc,
              listener: (_, PertanyaanState state) {
                if (state is PertanyaanLoading) {
                  setState(() {
                    isLoading = true;
                  });
                }
                if (state is PertanyaanLoaded) {
                  setState(() {
                    isLoading = false;
                    pertanyaanModel = state.items;
                  });
                }
                if (state is PertanyaanError) {
                  setState(() {
                    isLoading = false;
                  });
                }
              },
              child: BlocBuilder<PertanyaanBloc, PertanyaanState>(
                  cubit: pertanyaanBloc,
                  builder: (_, PertanyaanState state) {
                    if (state is PertanyaanInitial) {
                      if (pertanyaanModel == null) {
                        return LoadingSkeletonReview();
                      } else {
                        return mainContent(pertanyaanModel, false);
                      }
                    }
                    if (state is PertanyaanLoading) {
                      if (pertanyaanModel == null) {
                        return LoadingSkeletonReview();
                      } else {
                        return mainContent(pertanyaanModel, false);
                      }
                    }
                    if (state is PertanyaanLoaded) {
                      return mainContent(state.items, state.hasReachedMax);
                    }
                    if (state is PertanyaanError) {
                      if (pertanyaanModel == null) {
                        return Container();
                      } else {
                        return mainContent(pertanyaanModel, false);
                      }
                    }
                    return Container();
                  })),
        ],
      ),
    );
  }

  Container btnTanyaMethod() {
    return Container(
      width: double.infinity,
      height: 50,
      child: OutlinedButton(
        onPressed: () {
          SharedPreff().getSharedString('token').then((value) {
            if (value != null) {
              _modalBottomSheetMenu();
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
                            'Untuk mengakses konten ini, harap Masuk terlebih dahulu.',
                      ));
            }
          });
        },
        style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
            side: BorderSide(width: 1, color: primaryColor)),
        child: Text('Berikan pertanyaan',
            style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor)),
      ),
    );
  }

  Widget mainContent(List<Items> pertanyaanModel, bool hasReachedMax) {
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
            itemCount: pertanyaanModel.length,
            reverse: false,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.network(pertanyaanModel[index].creator.sourceAvatar,
                          width: 35),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${pertanyaanModel[index].creator.name}',
                            style: GoogleFonts.poppins(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Ditulis pada ${pertanyaanModel[index].createdAt.createdAt}',
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    '${pertanyaanModel[index].question}',
                    style:
                        GoogleFonts.poppins(fontSize: 12, color: Colors.black),
                  ),
                  SizedBox(height: 8),
                  pertanyaanModel[index].replied != null
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
                                        '${pertanyaanModel[index].replied.creator.sourceAvatar}',
                                        width: 35),
                                    SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${pertanyaanModel[index].replied.creator.name}',
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          'Ditulis pada ${pertanyaanModel[index].replied.repliedAt.repliedAt}',
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
                                  '${pertanyaanModel[index].replied.answerText}',
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
                  pertanyaanBloc.add(GetPertanyaan(
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
