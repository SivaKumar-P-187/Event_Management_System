import 'package:final_event/string.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:final_event/size_config.dart';

class Location extends StatefulWidget {
  const Location({Key? key}) : super(key: key);

  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.yourLocationTitle,
          style: GoogleFonts.dmSerifDisplay(
            textStyle: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(fontSize: 3 * SizeConfig.textMultiplier!),
          ),
        ),
        SizedBox(
          height: 3 * SizeConfig.heightMultiplier!,
        ),
        Padding(
          padding: EdgeInsets.only(right: 2 * SizeConfig.widthMultiplier!),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 20 * SizeConfig.heightMultiplier!,
                  width: 25 * SizeConfig.widthMultiplier!,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(6 * SizeConfig.widthMultiplier!),
                    color: Colors.grey.shade50,
                  ),
                ),
              ),
              SizedBox(
                width: 3 * SizeConfig.widthMultiplier!,
              ),
              Expanded(
                child: Container(
                  height: 20 * SizeConfig.heightMultiplier!,
                  width: 25 * SizeConfig.widthMultiplier!,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(6 * SizeConfig.widthMultiplier!),
                    color: Colors.grey.shade50,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(2 * SizeConfig.widthMultiplier!),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Align(
                          child: FaIcon(
                            FontAwesomeIcons.cloudMoon,
                          ),
                          alignment: Alignment.topRight,
                        ),
                        SizedBox(
                          height: 3 * SizeConfig.heightMultiplier!,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 3 * SizeConfig.widthMultiplier!,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Strings.yourLocationDegree,
                                style: GoogleFonts.lato(
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              3 * SizeConfig.textMultiplier!),
                                ),
                              ),
                              Text(
                                Strings.yourLocation,
                                style: GoogleFonts.sofia(
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            2 * SizeConfig.textMultiplier!,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
