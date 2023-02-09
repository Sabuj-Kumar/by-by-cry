
import 'package:bye_bye_cry_new/compoment/shared/custom_svg.dart';
import 'package:bye_bye_cry_new/compoment/shared/custom_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../compoment/shared/custom_image.dart';
import '../compoment/shared/outline_button.dart';
import '../compoment/shared/screen_size.dart';
import '../compoment/utils/color_utils.dart';
import '../compoment/utils/image_link.dart';

class HomePageAgain extends ConsumerStatefulWidget {

  const HomePageAgain({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePageAgain> createState() => _HomePageAgainPageState();
}

class _HomePageAgainPageState extends ConsumerState<HomePageAgain> {
  CarouselController buttonCarouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    final width = ScreenSize(context).width;
    final height = ScreenSize(context).height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * .02,
              ),
              Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: (){},
                      child: Container(
                        color: primaryWhiteColor,
                        child: CustomImage(
                          boxFit: BoxFit.fill,
                          imageUrl: logo,
                          height: height * .15,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(width: width,color: primaryPinkColor,height: 2,),
                  ],
                ),
              ),
              SizedBox(height: width * 0.05),
              Container(
                height: width * 0.25,
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CustomText(text: "Cue the ",fontSize: 36,fontWeight: FontWeight.w600,color: secondaryBlackColor,),
                    Text("calm",style: GoogleFonts.sacramento(
                        fontWeight: FontWeight.w400,fontSize: 64,color: secondaryBlackColor
                    ))
                  ],
                ),
              ),
              Container(
                  color: Colors.transparent,
                  width: width * 0.85,
                  child: const CustomImage(imageUrl: sleep_baby)),
              SizedBox(height: width * 0.05),
              OutLineButton(
                height: height * .09,
                text: 'Start Playing'.toUpperCase(),
                textColor: secondaryBlackColor,
                textFontSize: 24,
                textFontWeight: FontWeight.w600,
                borderRadius: 40,
                onPressed: (){},
                textPaddingVerticalTop: 5,
                textPaddingHorizontal: 57,
              ),
              SizedBox(height: width * 0.05),
              Container(
                color: secondaryGreenColor,
                width: width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 21.0),
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                         Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 30),
                           child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: (){
                                    buttonCarouselController.previousPage(duration: const Duration(milliseconds: 500),curve: Curves.easeIn);
                                  },
                                  child: Container(
                                      color: Colors.transparent,
                                      child: const Padding(
                                        padding: EdgeInsets.all( 6.0),
                                        child: CustomSvg(svg: leftDirection),
                                      ))),
                              Expanded(
                                child: CarouselSlider.builder(
                                  carouselController: buttonCarouselController,
                                  itemCount: 3,
                                  itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                                      const CustomText(
                                        text: "Does baby have gas? Try This :\nLay baby on their back and bring their knees to their chest. Move baby’s leg in a bicycle motion and apply each time their knees reach their chest ",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color: secondaryBlackColor,
                                        textAlign: TextAlign.center,
                                        height: 1.4,
                                      ),
                                  options: CarouselOptions(
                                    aspectRatio: 2.6,
                                    viewportFraction: 1,
                                    enableInfiniteScroll: false,
                                    onPageChanged: (index,reasons){}
                                  ),
                                ),
                              ),
                              GestureDetector(
                                  onTap: (){
                                    buttonCarouselController.nextPage(duration: const Duration(milliseconds: 500),curve: Curves.easeIn);
                                  },
                                  child: Container(
                                      color: Colors.transparent,
                                      child: const Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: CustomSvg(svg: rightDirection),
                                      ))),
                            ],
                        ),
                         )
                      ],
                    )
                  ),
                ),
              ),
              SizedBox(height: width * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}