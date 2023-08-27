import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerHome1 extends StatelessWidget {
  const ShimmerHome1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black, // Set the black background color
      child: Shimmer.fromColors(
        baseColor: Colors.grey[800]!, // Darker gray for base color
        highlightColor: Colors.grey[600]!, // Lighter gray for highlight color
        child: Container(
          width: double.infinity,
          height: 200,
          color: Colors.lightBlue,
        ),
      ),
    );
  }
}

class ShimmerHome2 extends StatelessWidget {
  const ShimmerHome2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      mainAxisSpacing: 5,
      crossAxisSpacing: 10,
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[800]!, // Darker gray for base color
          highlightColor: Colors.grey[600]!, // Lighter gray for highlight color
          child: Container(
            color: Colors.redAccent,
            height: 150,
            width: 90,
          ),
        );
      },
    );
  }
}

class ShimmerHome3 extends StatelessWidget {
  const ShimmerHome3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[800]!, // Darker gray for base color
      highlightColor: Colors.grey[600]!, // Lighter gray for highlight color
      child: Container(
        color: Colors.redAccent,
        height: 30,
        width: double.infinity,
      ),
    );
    ;
  }
}
