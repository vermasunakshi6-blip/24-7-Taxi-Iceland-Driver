import 'package:taxi_driver_24_7/apppackages.dart';
import 'package:taxi_driver_24_7/provider/customerprovider/support_legal_provider.dart';
import 'package:taxi_driver_24_7/widgets/common/shimmer_loader.dart';
import 'package:flutter/cupertino.dart';

class HelpCenter extends StatefulWidget {
  const HelpCenter({super.key});

  @override
  State<HelpCenter> createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
    
  }

  void getData() async {
    await Provider.of<SupportLegalProvider>(context, listen: false)
        .getFaqTitles(context);
  }

  @override
  Widget build(BuildContext context) {
    final supportProvider =
        Provider.of<SupportLegalProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: SizedBox(
        height: 50,
        child: FloatingActionButton.extended(
          onPressed: () {},
          label: Padding(
            padding: const EdgeInsets.only(
              right: 1.0,
            ),
            child: Text(
              'Chat with us',
              style: whiteTitle,
            ),
          ),
          icon: const Icon(
            CupertinoIcons.ellipses_bubble_fill,
            color: Colors.white,
            size: 20,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 0.0, right: 0.0, top: 70.0),
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
                          AppStrings.helpcenter.toUpperCase(),
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
                      'Frequently Asked Questions',
                      style:
                          blackHeading,
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
                         onChanged: (query) {
                            
                          setState(() {
                             supportProvider.searchUsers(query);
                          });
                         },
                        decoration: InputDecoration(
                          hintStyle: greyBody,
                          hintText: 'Search for your query',
                          prefixIcon: const Icon(
                            Icons.search,
                            size: 25,
                            color: AppColors.blackColor,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 3.0, horizontal: 10.0),
                              border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: AppColors.blackColor, width: 1)),
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
                    supportProvider.isLoading
                        ?  SizedBox(
                            height: 45,
                            child: ShimmerLoaderHorizontal(count: 5, height: 40,width: MediaQuery.of(context).size.width/5,),
                          )
                        : supportProvider.faqTitles.isEmpty
                            ? const SizedBox()
                            : SizedBox(
                                height: 43,
                                child: ListView.separated(
                                  padding: EdgeInsets.zero,
                                  itemCount: supportProvider.faqTitles.length,
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    width: 8,
                                  ),
                                  itemBuilder: (context, index) {
                                    final faqTitle =
                                        supportProvider.faqTitles[index];
                                    final isSelected =
                                        supportProvider.faqId == faqTitle.sId;
                                    return InkWell(
                                      onTap: () {
                                        supportProvider.selectFaqTitle(
                                            context, faqTitle.sId!);
                                      },
                                      child: Container(
                                        padding: faqTitle.title == 'All'
                                            ? const EdgeInsets.symmetric(
                                                horizontal: 30, vertical: 8)
                                            : const EdgeInsets.only(left:10,right: 10,top: 8,bottom: 8),
                                        decoration: BoxDecoration(
                                            color: isSelected
                                                ? AppColors.blackColor
                                                : Colors.white,
                                            border:  Border.all(
                                                color:  isSelected ? AppColors.blackColor:  AppColors.blackColor,
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(faqTitle.title ?? '',
                                                style: isSelected? whiteTitle: blackTitle
                                                ),
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
                    supportProvider.isLoading?
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 1.8,
                      child: ShimmerLoader(count: 8, height: MediaQuery.of(context).size.height/14),
                    ):
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 1.8,
                      child: supportProvider.faqData.isEmpty
                          ? Center(
                              child: Text(
                                'No FAQs Available!',
                                style: blackTitle,
                              ),
                            )
                          :
                          ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: supportProvider.filteredData.length,
                              itemBuilder: (context, index) {
                                final data = supportProvider.filteredData[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: ExpansionTile(
                                    iconColor: Colors.transparent,
                                    collapsedIconColor: Colors.transparent,
                                    backgroundColor:  AppColors.creamColor.withOpacity(0.15),
                                    collapsedBackgroundColor:
                                        Colors.white,
                                    expandedAlignment: Alignment.topLeft,
                                    tilePadding: const EdgeInsets.only(left: 15,right: 15,),
                                    childrenPadding: const EdgeInsets.only(left: 15,right: 15,bottom: 15),
                                    shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color: AppColors.creamColor, width: 1),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    collapsedShape: RoundedRectangleBorder(
                                        side:  BorderSide(
                                            color: AppColors.greyColor.withOpacity(0.1), width: 1),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    title: Text(data.question ?? '',
                                        style: blackTitle),
                                    children: [
                                      Text(data.answer ?? '',
                                          style: blackBodyNormal),
                                    ],
                                  ),
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
      ),
    );
  }
}

