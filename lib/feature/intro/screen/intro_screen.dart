import 'package:desa_wisata_nusantara/feature/intro/bloc/image_intro/bloc.dart';
import 'package:desa_wisata_nusantara/feature/intro/domain/repo/image_intro_repo.dart';
import 'package:desa_wisata_nusantara/feature/intro/model/image_intro_model.dart';
import 'package:desa_wisata_nusantara/resources/color_swatch.dart';
import 'package:desa_wisata_nusantara/resources/route_string.dart';
import 'package:desa_wisata_nusantara/util/shared_preff.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  ImageIntroBloc imageIntroBloc =
      ImageIntroBloc(imageIntroRepo: ImageIntroRepo());

  @override
  void dispose() {
    imageIntroBloc.close();

    super.dispose();
  }

  @override
  void initState() {
    imageIntroBloc.add(GetImageIntro());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ImageIntroBloc, ImageIntroState>(
      cubit: imageIntroBloc,
      listener: (_, ImageIntroState state) {
        if (state is ImageIntroLoaded) {}
        if (state is ImageIntroError) {}
      },
      child: BlocBuilder<ImageIntroBloc, ImageIntroState>(
          cubit: imageIntroBloc,
          builder: (_, ImageIntroState state) {
            if (state is ImageIntroInitial) {
              return Container();
            }
            if (state is ImageIntroLoading) {
              return Container();
            }
            if (state is ImageIntroLoaded) {
              return mainContent(state.imageIntroModel);
            }
            if (state is ImageIntroError) {
              return Container();
            }
            return Container();
          }),
    );
  }

  Widget mainContent(ImageIntroModel imageIntroModel) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: NetworkImage(imageIntroModel.data.sourceImage),
        fit: BoxFit.cover,
        colorFilter:
            ColorFilter.mode(Colors.grey.withOpacity(0.4), BlendMode.darken),
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: 16.0,
                        bottom: MediaQuery.of(context).size.height * 0.25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          width: MediaQuery.of(context).size.width * 0.30,
                          height: MediaQuery.of(context).size.width * 0.30,
                        ),
                        Image.asset(
                          'assets/images/logo_sdgs_desa.png',
                          width: MediaQuery.of(context).size.width * 0.22,
                          height: MediaQuery.of(context).size.width * 0.22,
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Text(
                      '${imageIntroModel.data.title}',
                      style: GoogleFonts.ptSans(
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Center(
                    child: Text(
                      '${imageIntroModel.data.subTitle}',
                      style: GoogleFonts.ptSans(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        primaryColor,
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ))),
                  child: Text('Jelajahi Desa Wisata',
                      style: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, onboardRoute, (route) => false);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
