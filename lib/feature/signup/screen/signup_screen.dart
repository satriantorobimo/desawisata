import 'dart:convert';

import 'package:desa_wisata_nusantara/feature/signup/bloc/signup_fb/bloc.dart';
import 'package:desa_wisata_nusantara/feature/signup/bloc/signup_google/bloc.dart';
import 'package:desa_wisata_nusantara/feature/signup/bloc/signup/bloc.dart';
import 'package:desa_wisata_nusantara/feature/signup/domain/repo/signup_repo.dart';
import 'package:desa_wisata_nusantara/feature/signup/model/signup_request_model.dart';
import 'package:desa_wisata_nusantara/resources/color_swatch.dart';
import 'package:desa_wisata_nusantara/resources/route_string.dart';
import 'package:desa_wisata_nusantara/util/shared_preff.dart';
import 'package:desa_wisata_nusantara/widget/custom_dialog_prelaunch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isObsecure = true, isLoggedIn = false;
  TextEditingController _emailCtrl = TextEditingController();
  TextEditingController _namaCtrl = TextEditingController();
  TextEditingController _pwdCtrl = TextEditingController();

  SignupBloc signupBloc = SignupBloc(signupRepo: SignupRepo());
  SignupGoogleBloc signupGoogleBloc =
      SignupGoogleBloc(signupRepo: SignupRepo());
  SignupFbBloc signupFbBloc = SignupFbBloc(signupRepo: SignupRepo());

  @override
  void dispose() {
    signupBloc.close();
    signupGoogleBloc.close();
    super.dispose();
  }

  void onLoginStatusChanged(bool isLoggedIn) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
    });
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signOut();
      final GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      print(googleSignInAuthentication.accessToken);
      print(googleSignInAccount.displayName);
      print(googleSignInAccount.email);
      print(googleSignInAccount.id);
      signupGoogleBloc
          .add(AttempRegisterGoogle(googleSignInAuthentication.accessToken));
      // showDialog(
      //     context: context,
      //     builder: (BuildContext context) => CustomDialogPrelaunch(
      //           value:
      //               'Signup Google Success\nNama : ${googleSignInAccount.displayName}\nEmail : ${googleSignInAccount.email}\nId : ${googleSignInAccount.id}',
      //           onTap: () {
      //             Navigator.pop(context);
      //           },
      //           isSuccess: true,
      //         ));
    } catch (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => CustomDialogPrelaunch(
                value: 'Opps $error',
                onTap: () {
                  Navigator.pop(context);
                },
                isSuccess: false,
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 24.0, right: 24.0),
              child: Icon(
                Icons.close,
                color: Colors.black,
                size: 20,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 24.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Daftar',
                      style: GoogleFonts.roboto(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 24),
                  BlocListener<SignupGoogleBloc, SignupGoogleState>(
                      cubit: signupGoogleBloc,
                      listener: (_, SignupGoogleState state) {
                        if (state is SignupGoogleLoaded) {
                          SharedPreff().savedSharedString(
                              'token', state.googleSignupModel.accessToken);
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            bottomRoute,
                            (route) => false,
                          );
                        }
                        if (state is SignupGoogleError) {
                          print('error ${state.error}');
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  CustomDialogPrelaunch(
                                    value: state.error,
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    isSuccess: false,
                                  ));
                        }
                      },
                      child: BlocBuilder<SignupGoogleBloc, SignupGoogleState>(
                          cubit: signupGoogleBloc,
                          builder: (_, SignupGoogleState state) {
                            if (state is SignupGoogleInitial) {
                              return googleSigninMethod(context);
                            }
                            if (state is SignupGoogleLoading) {
                              return Center(
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          primaryColor),
                                    ),
                                  ),
                                ),
                              );
                            }
                            if (state is SignupGoogleLoaded) {
                              return googleSigninMethod(context);
                            }
                            if (state is SignupGoogleError) {
                              return googleSigninMethod(context);
                            }
                            return googleSigninMethod(context);
                          })),
                  SizedBox(height: 40),
                  Center(
                    child: Text('Atau masuk menggunakan',
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          color: Colors.black,
                        )),
                  ),
                  SizedBox(height: 16),
                  Container(
                    margin: EdgeInsets.only(top: 12.5, bottom: 8),
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 32.0),
                      child: Center(
                        child: FormBuilderTextField(
                          controller: _namaCtrl,
                          keyboardType: TextInputType.emailAddress,
                          name: 'nama_form',
                          decoration: InputDecoration.collapsed(
                            hintText: "Nama Lengkap",
                            hintStyle: GoogleFonts.poppins(
                                fontSize: 14, color: Colors.black54),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          blurRadius: 5,
                          spreadRadius: 1.5,
                          offset: const Offset(
                            0.0,
                            5.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 12.5, bottom: 8),
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 32.0),
                      child: Center(
                        child: FormBuilderTextField(
                          controller: _emailCtrl,
                          keyboardType: TextInputType.emailAddress,
                          name: 'email_form',
                          decoration: InputDecoration.collapsed(
                            hintText: "Alamat email",
                            hintStyle: GoogleFonts.poppins(
                                fontSize: 14, color: Colors.black54),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          blurRadius: 5,
                          spreadRadius: 1.5,
                          offset: const Offset(
                            0.0,
                            5.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 12.5, bottom: 16.0),
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 32.0),
                            child: Center(
                              child: FormBuilderTextField(
                                controller: _pwdCtrl,
                                keyboardType: TextInputType.text,
                                obscureText: isObsecure,
                                name: 'pwd_form',
                                decoration: InputDecoration.collapsed(
                                  hintText: "Sandi",
                                  hintStyle: GoogleFonts.poppins(
                                      fontSize: 14, color: Colors.black54),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isObsecure = !isObsecure;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 24.0),
                            child: Icon(
                              isObsecure
                                  ? CupertinoIcons.eye
                                  : CupertinoIcons.eye_slash,
                              color: primaryColor,
                              size: 20,
                            ),
                          ),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          blurRadius: 5,
                          spreadRadius: 1.5,
                          offset: const Offset(
                            0.0,
                            5.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  BlocListener<SignupBloc, SignupState>(
                      cubit: signupBloc,
                      listener: (_, SignupState state) {
                        if (state is SignupLoaded) {
                          print('success');
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  CustomDialogPrelaunch(
                                    value: state.signupModel.message,
                                    onTap: () {
                                      Navigator.pushNamedAndRemoveUntil(
                                          context, loginRoute, (route) => false,
                                          arguments: true);
                                    },
                                    isSuccess: true,
                                  ));
                        }
                        if (state is SignupError) {
                          print('error ${state.error}');
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  CustomDialogPrelaunch(
                                    value: state.error,
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    isSuccess: false,
                                  ));
                        }
                      },
                      child: BlocBuilder<SignupBloc, SignupState>(
                          cubit: signupBloc,
                          builder: (_, SignupState state) {
                            if (state is SignupInitial) {
                              return daftarBtnMethod();
                            }
                            if (state is SignupLoading) {
                              return Center(
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          primaryColor),
                                    ),
                                  ),
                                ),
                              );
                            }
                            if (state is SignupLoaded) {
                              return daftarBtnMethod();
                            }
                            if (state is SignupError) {
                              return daftarBtnMethod();
                            }
                            return daftarBtnMethod();
                          })),
                ],
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Sudah mempunyai Akun ? ',
                      style: GoogleFonts.roboto(
                        fontSize: 12,
                        color: Colors.black,
                      )),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, loginRoute,
                          arguments: false);
                    },
                    child: Text('Masuk',
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget googleSigninMethod(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(
              Colors.white,
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/google.png',
              width: 33,
            ),
            SizedBox(width: 16),
            Text('Google',
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ],
        ),
        onPressed: () {
          _handleSignIn();
        },
      ),
    );
  }

  Widget fbSigninMethod(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.42,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(
              Color(0xFF3498DB),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('assets/images/fb.png', width: 33),
            Text('Facebook',
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ],
        ),
        onPressed: () {},
      ),
    );
  }

  Widget daftarBtnMethod() {
    return Container(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(
              primaryColor,
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ))),
        child: Text('Daftar',
            style:
                GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold)),
        onPressed: _pwdCtrl.text.isEmpty ||
                _emailCtrl.text.isEmpty ||
                _namaCtrl.text.isEmpty
            ? null
            : () {
                SignupRequestModel signupRequestModel = SignupRequestModel();
                signupRequestModel.email = _emailCtrl.text;
                signupRequestModel.name = _namaCtrl.text;
                signupRequestModel.password = _pwdCtrl.text;

                signupBloc.add(AttempRegister(signupRequestModel));
              },
      ),
    );
  }
}
