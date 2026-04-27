

import '../../apppackages.dart';

class ListTileCommon extends StatelessWidget {
  final String text;
  final String assetImage;
  final VoidCallback onPressed;

  const ListTileCommon({
    super.key,
    required this.text,
    required this.assetImage,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image(
          width: 30,
          
          image: AssetImage(assetImage)),
      title: Text(
        text,
        style: blackTitle,
      ),
      trailing: const Image(
          width: 12, 
          image: AssetImage('assets/images/arrowforward.png')),
      onTap: onPressed,
    );
  }
}
