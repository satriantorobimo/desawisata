import 'package:carousel_slider/carousel_slider.dart';
import 'package:desa_wisata_nusantara/feature/onboard/bloc/onboarding/bloc.dart';
import 'package:desa_wisata_nusantara/feature/onboard/domain/repo/onboarding_repo.dart';
import 'package:desa_wisata_nusantara/feature/onboard/model/onboarding_model.dart';
import 'package:desa_wisata_nusantara/resources/color_swatch.dart';
import 'package:desa_wisata_nusantara/resources/route_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardScreen extends StatefulWidget {
  @override
  _OnboardScreenState createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  OnboardingBloc onboardingBloc =
      OnboardingBloc(onboardingRepo: OnboardingRepo());

  int _index = 0;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  void dispose() {
    onboardingBloc.close();

    super.dispose();
  }

  @override
  void initState() {
    onboardingBloc.add(GetImageOnboarding());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                bottomRoute,
                (route) => false,
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 24.0, right: 24.0),
              child: Text('Lewati',
                  style: GoogleFonts.roboto(
                      fontSize: 14,
                      color: primaryColor,
                      fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocListener<OnboardingBloc, OnboardingState>(
                cubit: onboardingBloc,
                listener: (_, OnboardingState state) {
                  if (state is OnboardingLoaded) {}
                  if (state is OnboardingError) {}
                },
                child: BlocBuilder<OnboardingBloc, OnboardingState>(
                    cubit: onboardingBloc,
                    builder: (_, OnboardingState state) {
                      if (state is OnboardingInitial) {
                        return Container();
                      }
                      if (state is OnboardingLoading) {
                        return Container();
                      }
                      if (state is OnboardingLoaded) {
                        return carouselMethod(state.onboardingModel);
                      }
                      if (state is OnboardingError) {
                        return Container();
                      }
                      return Container();
                    })),
            Column(
              children: [
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
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ))),
                    child: Text('Masuk',
                        style: GoogleFonts.poppins(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                    onPressed: () {
                      Navigator.pushNamed(context, loginRoute,
                          arguments: false);
                    },
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.white,
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ))),
                    child: Text('Daftar',
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        signupRoute,
                      );
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget carouselMethod(OnboardingModel onboardingModel) {
    return Column(
      children: [
        CarouselSlider(
          items: onboardingModel.data.map((fileImage) {
            return Image.network(fileImage.sourceImage,
                fit: BoxFit.cover, width: double.infinity);
          }).toList(),
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              setState(() {
                _index = index;
              });
            },
            height: MediaQuery.of(context).size.height * 0.37,
            autoPlay: false,
            aspectRatio: 1.0,
            viewportFraction: 1.0,
          ),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: map<Widget>(onboardingModel.data, (index, url) {
            return Container(
              width: 12.0,
              height: 12.0,
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _index == index ? primaryColor : Colors.grey.shade300,
              ),
            );
          }),
        ),
        SizedBox(height: 8),
        Text('${onboardingModel.data[_index].title}',
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text('${onboardingModel.data[_index].subTitle}',
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(fontSize: 18, color: Colors.black))
      ],
    );
  }
}
