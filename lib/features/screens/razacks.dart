import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RazacksHomeopathyScreen extends StatefulWidget {
  const RazacksHomeopathyScreen({super.key});

  @override
  State<RazacksHomeopathyScreen> createState() =>
      _RazacksHomeopathyScreenState();
}

class _RazacksHomeopathyScreenState extends State<RazacksHomeopathyScreen> {
  static const Color _background = Color(0xFF1D1D1D);
  static const Color _foreground = Color(0xFFF5F5F5);
  static const Color _muted = Color(0xFFBDBDBD);

  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_RazacksPreview> _previews = const [
    _RazacksPreview(
      image: 'assets/razack1.png',
      heading: 'A FIRST IMPRESSION',
      description:
          'A clean and welcoming homepage introduces DR. RAZACK’S HOMEOPATHY, highlights the clinic’s approach to care and helps visitors quickly understand the doctor.',
      highlight: 'A PROFESSIONAL ONLINE PRESENCE',
    ),
    _RazacksPreview(
      image: 'assets/razack2.png',
      heading: 'TREATMENTS AND SERVICES',
      description:
          'Dedicated service sections help visitors explore the clinic’s treatment areas, including piles, fissure and fistula care, migraine treatment, chronic disease management and asthma treatment.',
      highlight: 'CLEAR SERVICE INFORMATION',
    ),
    _RazacksPreview(
      image: 'assets/razack3.png',
      heading: 'ONLINE BOOKING',
      description:
          'A dedicated section introduces the location and wherabouts to clients and how to get ahold of the doctor for an online booking with a single tap on the screen.',
      highlight: 'PERSONAL AND TRUSTWORTHY',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final isMobile = width < 600;
            final horizontalPadding = width < 380
                ? 20.0
                : width < 900
                ? 36.0
                : 64.0;

            return SingleChildScrollView(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      horizontalPadding,
                      isMobile ? 36 : 54,
                      horizontalPadding,
                      isMobile ? 36 : 54,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                if (Navigator.canPop(context)) {
                                  Navigator.pop(context);
                                }
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Welcome to Razack’s Homeopathy',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  color: _muted,
                                  fontSize: isMobile ? 16 : 27,
                                ),
                              ),
                            ),
                            const SizedBox(width: 48),
                          ],
                        ),
                        SizedBox(height: isMobile ? 42 : 68),
                        _projectInfo('TYPE :', 'BUSINESS WEBSITE', isMobile),
                        SizedBox(height: isMobile ? 26 : 34),
                        _projectInfo(
                          'MY PART :',
                          'DESIGNING AND CODING',
                          isMobile,
                        ),
                        SizedBox(height: isMobile ? 26 : 34),
                        _projectInfo('CLIENT :', 'DR. MAHSOOM', isMobile),
                        SizedBox(height: isMobile ? 38 : 60),
                        Text(
                          "DR. RAZACK’S HOMEOPATHY is a homeopathy clinic that focuses on natural, non-invasive treatments. Known for their personalized care (treatment based on each person), it has been around for years and is considered a local, well-known clinic.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            color: _muted,
                            fontSize: isMobile ? 13.5 : 18,
                            height: 1.6,
                          ),
                        ),
                        SizedBox(height: isMobile ? 58 : 76),
                        const _ProjectExpansionTile(
                          title: "WHAT'S THE PURPOSE?",
                          content:
                              'The purpose of this website is to give DR. RAZACK’S HOMEOPATHY a clear and professional online presence. It helps visitors understand the clinic, learn about its approach and treatments, meet the doctor, find the clinic, and get in touch to book an appointment.',
                        ),
                        SizedBox(height: isMobile ? 24 : 36),
                        const _ProjectExpansionTile(
                          title: 'FEATURES IMPLEMENTED',
                          content:
                              'Responsive layout for desktop and mobile, welcoming hero section, clinic introduction, “Why Choose Us” highlights, founder and doctor profiles, treatment and service cards, appointment booking section, Google Maps location link, and smooth in-page navigation.',
                        ),
                        SizedBox(height: isMobile ? 48 : 64),

                        // SNEEK PEAK title with outlined border, matching Grela and FoodiaQ.
                        Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: isMobile ? 22 : 28,
                              vertical: isMobile ? 10 : 13,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: _foreground, width: 2),
                            ),
                            child: Text(
                              'S N E E K   P E A K',
                              style: GoogleFonts.montserrat(
                                color: _foreground,
                                fontSize: isMobile ? 11 : 14,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: isMobile ? 28 : 42),

                        // Three-slide clinic website screenshot showcase.
                        SizedBox(
                          height: isMobile ? 690 : 520,
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: _previews.length,
                            onPageChanged: (index) {
                              setState(() => _currentPage = index);
                            },
                            itemBuilder: (context, index) {
                              return _RazacksPreviewCard(
                                preview: _previews[index],
                                isMobile: isMobile,
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              tooltip: 'Previous slide',
                              onPressed: _currentPage == 0
                                  ? null
                                  : () => _pageController.previousPage(
                                      duration: const Duration(
                                        milliseconds: 350,
                                      ),
                                      curve: Curves.easeInOut,
                                    ),
                              icon: const Icon(Icons.chevron_left, size: 30),
                              color: Colors.white,
                              disabledColor: Colors.white30,
                            ),
                            const SizedBox(width: 12),
                            ...List.generate(
                              _previews.length,
                              (index) => AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                width: _currentPage == index ? 22 : 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: _currentPage == index
                                      ? _foreground
                                      : _muted.withOpacity(0.45),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            IconButton(
                              tooltip: 'Next slide',
                              onPressed: _currentPage == _previews.length - 1
                                  ? null
                                  : () => _pageController.nextPage(
                                      duration: const Duration(
                                        milliseconds: 350,
                                      ),
                                      curve: Curves.easeInOut,
                                    ),
                              icon: const Icon(Icons.chevron_right, size: 30),
                              color: Colors.white,
                              disabledColor: Colors.white30,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _projectInfo(String label, String value, bool isMobile) {
    final style = GoogleFonts.montserrat(
      color: _foreground,
      fontSize: isMobile ? 14 : 18,
      fontWeight: FontWeight.w800,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: style),
        Text(value, style: style),
      ],
    );
  }
}

class _RazacksPreview {
  const _RazacksPreview({
    required this.image,
    required this.heading,
    required this.description,
    required this.highlight,
  });

  final String image;
  final String heading;
  final String description;
  final String highlight;
}

class _RazacksPreviewCard extends StatelessWidget {
  const _RazacksPreviewCard({required this.preview, required this.isMobile});

  final _RazacksPreview preview;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      padding: EdgeInsets.all(isMobile ? 16 : 28),
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        border: Border.all(color: const Color(0xFF159BFF), width: 2.5),
        borderRadius: BorderRadius.circular(isMobile ? 24 : 32),
      ),
      child: isMobile
          ? Column(
              children: [
                Expanded(flex: 6, child: _previewImage(preview.image)),
                const SizedBox(height: 12),
                Expanded(flex: 5, child: _previewText()),
              ],
            )
          : Row(
              children: [
                Expanded(flex: 4, child: _previewImage(preview.image)),
                const SizedBox(width: 24),
                Expanded(flex: 6, child: _previewText()),
              ],
            ),
    );
  }

  Widget _previewImage(String imagePath) {
    return Center(
      child: Image.asset(
        imagePath,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Text(
            'Add screenshot here:\n$imagePath',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(color: Colors.black54, fontSize: 12),
          );
        },
      ),
    );
  }

  Widget _previewText() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              preview.heading,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: isMobile ? 15 : 23,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: isMobile ? 16 : 24),
            Text(
              preview.description,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                color: const Color(0xFF333333),
                fontSize: isMobile ? 13 : 19,
                height: 1.55,
              ),
            ),
            SizedBox(height: isMobile ? 22 : 48),
            Text(
              preview.highlight,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: isMobile ? 15 : 23,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectExpansionTile extends StatefulWidget {
  const _ProjectExpansionTile({required this.title, required this.content});

  final String title;
  final String content;

  @override
  State<_ProjectExpansionTile> createState() => _ProjectExpansionTileState();
}

class _ProjectExpansionTileState extends State<_ProjectExpansionTile> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 600;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFBDBDBD), width: 1.5),
        borderRadius: BorderRadius.circular(17),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: ExpansionTile(
          onExpansionChanged: (value) => setState(() => _expanded = value),
          tilePadding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 28,
            vertical: isMobile ? 5 : 10,
          ),
          childrenPadding: EdgeInsets.fromLTRB(
            isMobile ? 18 : 30,
            0,
            isMobile ? 18 : 30,
            isMobile ? 18 : 24,
          ),
          trailing: AnimatedRotation(
            turns: _expanded ? 0.5 : 0,
            duration: const Duration(milliseconds: 200),
            child: const Icon(
              Icons.keyboard_arrow_down,
              color: Color(0xFF9E9E9E),
              size: 25,
            ),
          ),
          title: Text(
            widget.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: isMobile ? 12 : 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          children: [
            Text(
              widget.content,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                color: const Color(0xFFBDBDBD),
                fontSize: isMobile ? 12 : 15,
                height: 1.7,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
