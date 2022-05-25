import 'package:todos/presentation/base/index.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmeItemBank extends StatelessWidget {
  const ShimmeItemBank({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var enabled = true;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        enabled: enabled,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(
                width: 1,
                //isSelected? AppColors.accent2: AppColors.neutral8,
              )),
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: Row(
            children: [
              Container(
                  width: 35,
                  height: 35,
                  color: AppColors.neutral8,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(width: 180,
                      height: 10,
                      color: Colors.white,),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(width: 150,
                      height: 10,
                      color: Colors.white,),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
