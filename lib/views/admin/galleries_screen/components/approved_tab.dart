import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class approved_tab extends StatefulWidget {
  const approved_tab({Key? key}) : super(key: key);

  @override
  State<approved_tab> createState() => _approved_tabState();
}

class _approved_tabState extends State<approved_tab> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Restaurants')
            .where('status', isEqualTo: 'Approved')
            .snapshots(),
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
                  surfaceTintColor: Colors.transparent,
                  color: const Color.fromRGBO(232, 30, 99, 1),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(205, 27, 87, 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        height: 55.h,
                        width: 35.w,
                        child: const Icon(
                          Icons.block,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 7.w,
                      ),
                      Column(
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
                    ],
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            int approvedGalleryTotal = snapshot.data?.docs.length ?? 0;
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
                            Icons.check,
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
                              "Approved",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 5.sp),
                            ),
                            Text(
                              "$approvedGalleryTotal",
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
