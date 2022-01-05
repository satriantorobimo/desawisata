import 'package:flutter/material.dart';
import 'package:desa_wisata_nusantara/feature/home/model/category_home_model.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryMenuWidget extends StatelessWidget {
  final List<Data> datas;
  CategoryMenuWidget(this.datas);

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
      body: SingleChildScrollView(
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
                    return Column(
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
}
