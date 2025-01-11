import 'package:flutter/material.dart';
import 'package:new2/Widgets/divider.dart';
import 'package:new2/data/Background.dart';
import 'package:new2/Widgets/Text.dart';
import 'package:intl/intl.dart';
import 'package:new2/Widgets/InputButton.dart';
import 'package:new2/data/TextSize.dart';
import 'package:new2/Widgets/SwitchTextSize.dart';
import 'package:new2/Widgets/Switchbutton.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({
    super.key,
    required this.selectedDay,
    required this.onSubmit,
  });

  final DateTime selectedDay;
  final Function(DateTime, Map<String, dynamic>) onSubmit;

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  late ScrollController _bloodflowScrollController;
  late ScrollController _feelingScrollController;
  late ScrollController _spottingScrollController;

  String _selectedBloodflow = '';
  String _selectedSpotting = '';
  String _selectedFeeling = '';

  @override
  void initState() {
    super.initState();
    _bloodflowScrollController = ScrollController();
    _feelingScrollController = ScrollController();
    _spottingScrollController = ScrollController();
  }

  @override
  void dispose() {
    _bloodflowScrollController.dispose();
    _feelingScrollController.dispose();
    _spottingScrollController.dispose();
    super.dispose();
  }

  void _updateSelectedBloodflow(String value) {
    setState(() {
      _selectedBloodflow = value;
    });
  }

  void _updateSelectedSpotting(String value) {
    setState(() {
      _selectedSpotting = value;
    });
  }

  void _updateSelectedFeeling(String value) {
    setState(() {
      _selectedFeeling = value;
    });
  }

  void _scrollLeft(ScrollController controller) {
    controller.animateTo(
      controller.offset - 150,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollRight(ScrollController controller) {
    controller.animateTo(
      controller.offset + 150,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final colors = modes[currentMode]!;
    final size = sizes[currentSize]!;
    final formattedDate = DateFormat('d MMMM yyyy').format(widget.selectedDay);

    return Scaffold(
        backgroundColor: colors.primarycolor,
        appBar: AppBar(
          title: AppTitle(apptitletext: 'Your Cycle', textsize: size),
          centerTitle: true,
          backgroundColor: colors.secondarycolor,
        ),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: ListView(children: [
                Center(
                  child: SubHeading(
                    subheadingtext: formattedDate,
                    textsize: size,
                  ),
                ),
                const Space(),
                SubHeading(subheadingtext: 'Bloodflow', textsize: size),
                Container(
                  width: screenWidth,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: colors.tertiarycolor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 30,
                        child: IconButton(
                          icon: Icon(Icons.chevron_left,
                              color: colors.contrastingcolor, size: 20),
                          onPressed: () =>
                              _scrollLeft(_bloodflowScrollController),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: SizedBox(
                          height: 100,
                          child: ListView(
                            controller: _bloodflowScrollController,
                            scrollDirection: Axis.horizontal,
                            children: [
                              InputButton(
                                label: 'Light',
                                iconsize: 15,
                                iconcolor: const Color.fromARGB(255, 136, 8, 8),
                                icon: Icons.water_drop,
                                selected: _selectedBloodflow == 'Light',
                                onTap: () => _updateSelectedBloodflow('Light'),
                              ),
                              const SizedBox(width: 10),
                              InputButton(
                                label: 'Medium',
                                iconsize: 20,
                                iconcolor: const Color.fromARGB(255, 136, 8, 8),
                                icon: Icons.water_drop,
                                selected: _selectedBloodflow == 'Medium',
                                onTap: () => _updateSelectedBloodflow('Medium'),
                              ),
                              const SizedBox(width: 10),
                              InputButton(
                                label: 'Heavy',
                                iconsize: 25,
                                iconcolor: const Color.fromARGB(255, 136, 8, 8),
                                icon: Icons.water_drop,
                                selected: _selectedBloodflow == 'Heavy',
                                onTap: () => _updateSelectedBloodflow('Heavy'),
                              ),
                              const SizedBox(width: 10),
                              InputButton(
                                label: 'Super\nHeavy',
                                iconsize: 30,
                                iconcolor: const Color.fromARGB(255, 136, 8, 8),
                                icon: Icons.water_drop,
                                selected: _selectedBloodflow == 'Super Heavy',
                                onTap: () =>
                                    _updateSelectedBloodflow('Super Heavy'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 30,
                        child: IconButton(
                          icon: Icon(Icons.chevron_right,
                              color: colors.contrastingcolor, size: 20),
                          onPressed: () =>
                              _scrollRight(_bloodflowScrollController),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ),
                    ],
                  ),
                ),
                const Space(),
                SubHeading(subheadingtext: 'Spotting', textsize: size),
                Container(
                  width: screenWidth,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: colors.tertiarycolor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 30,
                        child: IconButton(
                          icon: Icon(Icons.chevron_left,
                              color: colors.contrastingcolor, size: 20),
                          onPressed: () =>
                              _scrollLeft(_spottingScrollController),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                          child: SizedBox(
                        height: 100,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            InputButton(
                              label: 'Red',
                              iconsize: 40,
                              iconcolor: const Color.fromARGB(255, 136, 8, 8),
                              icon: Icons.grain,
                              selected: _selectedSpotting == 'Red',
                              onTap: () => _updateSelectedSpotting('Red'),
                            ),
                            const SizedBox(width: 10),
                            InputButton(
                              label: 'Brown',
                              iconsize: 40,
                              iconcolor: const Color.fromARGB(255, 139, 69, 19),
                              icon: Icons.grain,
                              selected: _selectedSpotting == 'Brown',
                              onTap: () => _updateSelectedSpotting('Brown'),
                            ),
                          ],
                        ),
                      )),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 30,
                        child: IconButton(
                          icon: Icon(Icons.chevron_right,
                              color: colors.contrastingcolor, size: 20),
                          onPressed: () =>
                              _scrollRight(_spottingScrollController),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ),
                    ],
                  ),
                ),
                const Space(),
                SubHeading(subheadingtext: 'Feeling', textsize: size),
                Container(
                  width: screenWidth,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: colors.tertiarycolor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 30,
                        child: IconButton(
                          icon: Icon(Icons.chevron_left,
                              color: colors.contrastingcolor, size: 20),
                          onPressed: () =>
                              _scrollLeft(_feelingScrollController),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: SizedBox(
                          height: 100,
                          child: ListView(
                            controller: _feelingScrollController,
                            scrollDirection: Axis.horizontal,
                            children: [
                              InputButton(
                                label: 'Happy',
                                iconsize: 40,
                                iconcolor: colors.contrastingcolor,
                                icon: Icons.sunny,
                                selected: _selectedFeeling == 'Happy',
                                onTap: () => _updateSelectedFeeling('Happy'),
                              ),
                              const SizedBox(width: 10),
                              InputButton(
                                label: 'Sad',
                                iconsize: 40,
                                iconcolor: colors.contrastingcolor,
                                icon: Icons.cloudy_snowing,
                                selected: _selectedFeeling == 'Sad',
                                onTap: () => _updateSelectedFeeling('Sad'),
                              ),
                              const SizedBox(width: 10),
                              InputButton(
                                label: 'Angry',
                                iconsize: 40,
                                iconcolor: colors.contrastingcolor,
                                icon: Icons.local_fire_department,
                                selected: _selectedFeeling == 'Angry',
                                onTap: () => _updateSelectedFeeling('Angry'),
                              ),
                              const SizedBox(width: 10),
                              InputButton(
                                label: 'Mood\nSwings',
                                iconsize: 40,
                                iconcolor: colors.contrastingcolor,
                                icon: Icons.theater_comedy,
                                selected: _selectedFeeling == 'Mood Swings',
                                onTap: () =>
                                    _updateSelectedFeeling('Mood Swings'),
                              ),
                              const SizedBox(width: 10),
                              InputButton(
                                label: 'Irritable',
                                iconsize: 40,
                                iconcolor: colors.contrastingcolor,
                                icon: Icons.thunderstorm,
                                selected: _selectedFeeling == 'Irritable',
                                onTap: () =>
                                    _updateSelectedFeeling('Irritable'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 30,
                        child: IconButton(
                          icon: Icon(Icons.chevron_right,
                              color: colors.contrastingcolor, size: 20),
                          onPressed: () =>
                              _scrollRight(_feelingScrollController),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ),
                    ],
                  ),
                ),
                const Space(),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .center, // Centers the buttons horizontally
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              final selectedData = {
                                'Bloodflow': _selectedBloodflow,
                                'Spotting': _selectedSpotting,
                                'Feeling': _selectedFeeling,
                              };
                              widget.onSubmit(widget.selectedDay, selectedData);
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colors.tertiarycolor,
                            ),
                            child: SmallBodyText(
                                smallbodytext: 'Save', textsize: size),
                          ),
                          const SizedBox(
                              width: 16), // Space between the buttons
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colors.tertiarycolor,
                            ),
                            child: SmallBodyText(
                                smallbodytext: 'Back', textsize: size),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
            )));
  }
}
