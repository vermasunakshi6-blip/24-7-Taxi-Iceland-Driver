import 'package:taxi_driver_24_7/apppackages.dart';

class Messages extends StatefulWidget {
  const Messages({super.key});

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  TextEditingController searchController = TextEditingController();
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0.0, right: 0.0, top: 80.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Padding(
                            padding:
                                EdgeInsets.only(right: 30, top: 0, bottom: 0),
                            child: Image(
                                height: 25,
                                image: AssetImage(
                                  AppImages.arrowback,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: Center(
                      child: Text(
                        AppStrings.messages.toUpperCase(),
                        style: greyHeading,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Chats',
                    style: blackHeading,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                      controller: searchController,
                      keyboardType: TextInputType.text,
                      onTap: () {},
                      textInputAction: TextInputAction.next,
                      style: blackTitle,
                      cursorColor: AppColors.blackColor,
                      decoration: InputDecoration(
                        hintText: 'Search for a chat or message',
                        prefixIcon: const Icon(
                          Icons.search,
                          size: 25,
                          color: AppColors.blackColor,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 3.0, horizontal: 10.0),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: AppColors.blackColor, width: 1)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: AppColors.blackColor, width: 1)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 45,
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 8,
                      ),
                      itemBuilder: (context, index) {
                        final List<String> helpList = [
                          'All',
                          'Rides',
                          'Promotional',
                          'Events',
                          'System'
                        ];
                        final isSelected = selectedIndex == index;
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: Container(
                            padding: helpList[index] == 'All'
                                ? const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 10)
                                : const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.redColor
                                    : Colors.white,
                                border: Border.all(
                                    color:  AppColors.creamColor, width: 1),
                                borderRadius: BorderRadius.circular(30)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(helpList[index],
                                    style:isSelected?whiteTitle:blackTitle ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.6,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Divider(
                          height: 1,
                          color: AppColors.creamColor,
                        ),
                      ),
                      padding: EdgeInsets.zero,
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {},
                            child: ListTile(
                              titleAlignment: ListTileTitleAlignment.top,
                              leading: const CircleAvatar(
                                radius: 24,
                                backgroundColor: AppColors.redColor,
                                child: Icon(Icons.person,color: Colors.white,),
                              ),
                              title: Text(
                                'Leggoo Promotions',
                                style: blackTitle,
                              ),
                              subtitle: Text(
                                '🎁 Surprise! Use code LEGGOO5 for 20% off your next ride. Go, go, go!',
                                maxLines: 2,
                                style: greyBodyNormal,
                              ),
                              trailing: Text(
                                '2d ago',
                                style: smallGrey,
                              ),
                            )
                            );
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
