import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class gallery_tab extends StatefulWidget {
  const gallery_tab({Key? key}) : super(key: key);

  @override
  State<gallery_tab> createState() => _gallery_tabState();
}

class _gallery_tabState extends State<gallery_tab> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Restaurants').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              width: 70.w,
              height: 60.h,
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                direction: ShimmerDirection.ltr,
                child: Card(
                  color: const Color.fromRGBO(232, 30, 99, 1),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(205, 27, 87, 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        height: 60,
                        width: 40,
                        child: const Icon(
                          Icons.block,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Blocked",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "Loading...",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            int galleryTotalDocuments = snapshot.data?.docs.length ?? 0;
            return SizedBox(
                width: 70.w,
                height: 60.h,
                child: Card(
                  color: Color.fromRGBO(139, 195, 74, 4),
                  child: Row(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(122, 171, 66, 4),
                              borderRadius: BorderRadius.circular(5)),
                          height: 60.h,
                          width: 20.w,
                          child: const Icon(
                            Icons.production_quantity_limits,
                            color: Colors.white,
                          )),
                      SizedBox(
                        width: 5.w,
                      ),
                      SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Galleries",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 5.sp),
                            ),
                            Text(
                              "$galleryTotalDocuments",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ));
          }
        });
  }
}
