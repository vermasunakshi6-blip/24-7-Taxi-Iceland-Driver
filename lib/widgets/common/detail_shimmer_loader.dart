import 'package:taxi_driver_24_7/apppackages.dart';
import 'package:shimmer/shimmer.dart';

class DetailShimmerLoader extends StatefulWidget {
  const DetailShimmerLoader({super.key});

  @override
  State<DetailShimmerLoader> createState() => _DetailShimmerLoaderState();
}

class _DetailShimmerLoaderState extends State<DetailShimmerLoader> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 3.5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  color: AppColors.blackColor,
                  height: 50,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 0,
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  color: AppColors.blackColor,
                  width: 30,
                  height: 50,
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        shimmerRow(),
        const SizedBox(
          height: 8,
        ),
        shimmerRow(),
        const SizedBox(
          height: 8,
        ),
        shimmerRow(),
        const SizedBox(
          height: 8,
        ),
        shimmerRow(),
        const SizedBox(
          height: 8,
        ),
        shimmerRow(),
        const SizedBox(
          height: 8,
        ),
        shimmerRow(),
        const SizedBox(
          height: 15,
        ),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 50,
            color: AppColors.blackColor,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 2,
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 30,
                    height: 50,
                    color: Colors.white,
                  ),
                )),
            const SizedBox(
              width: 10,
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: 30,
                height: 30,
                color: Colors.white,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 27,
        ),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 30,
            color: Colors.white,
          ),
        ),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 150,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 30,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 30,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget shimmerRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: 30,
            height: 10,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 30,
              height: 10,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
