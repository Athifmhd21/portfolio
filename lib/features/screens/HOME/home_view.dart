import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/features/screens/HOME/home_viewmodel.dart';
import 'package:portfolio/pdf/open_pdf.dart';
import 'package:portfolio/features/screens/HOME/home_widgets.dart';

import 'package:portfolio/features/projects/data/project_data.dart';
import 'package:portfolio/features/projects/model/project_model.dart';
import 'package:portfolio/features/projects/view/project_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final HomeViewModel _viewModel;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _portfolioKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();
  final _contactFormKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();

  late final AnimationController _introController;
  late final Animation<double> _introFade;
  late final Animation<double> _nameFade;
  late final Animation<double> _detailsFade;
  late final Animation<double> _lineProgress;
  bool _showIntro = kIsWeb;

  void _onViewModelChanged() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _viewModel = HomeViewModel()..addListener(_onViewModelChanged);
    _introController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );
    _introFade = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(
          begin: 0.0,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 18,
      ),
      TweenSequenceItem(tween: ConstantTween<double>(1.0), weight: 62),
      TweenSequenceItem(
        tween: Tween(
          begin: 1.0,
          end: 0.0,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 20,
      ),
    ]).animate(_introController);
    _nameFade = CurvedAnimation(
      parent: _introController,
      curve: const Interval(0.12, 0.48, curve: Curves.easeOut),
    );
    _detailsFade = CurvedAnimation(
      parent: _introController,
      curve: const Interval(0.32, 0.62, curve: Curves.easeOut),
    );
    _lineProgress = CurvedAnimation(
      parent: _introController,
      curve: const Interval(0.35, 0.90, curve: Curves.easeInOut),
    );
    if (kIsWeb) {
      _introController.forward().whenComplete(() {
        if (mounted) setState(() => _showIntro = false);
      });
    }
  }

  @override
  void dispose() {
    _viewModel
      ..removeListener(_onViewModelChanged)
      ..dispose();
    _introController.dispose();
    _scrollController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _scrollToPortfolio() {
    final targetContext = _portfolioKey.currentContext;
    if (targetContext == null) return;
    final box = targetContext.findRenderObject() as RenderBox;
    final position = box.localToGlobal(Offset.zero);
    final offset = position.dy + _scrollController.offset - 170;
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  void _scrollToContact() {
    final targetContext = _contactKey.currentContext;
    if (targetContext == null) return;
    Scrollable.ensureVisible(
      targetContext,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
      alignment: 0,
    );
  }

  Future<void> _submitContactForm() async {
    if (!_contactFormKey.currentState!.validate()) return;
    final success = await _viewModel.submitContactForm(
      name: _nameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      message: _messageController.text,
    );
    if (!mounted) return;
    if (success) {
      _contactFormKey.currentState!.reset();
      _nameController.clear();
      _emailController.clear();
      _phoneController.clear();
      _messageController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Thanks for reaching out! We will get back to you ASAP.',
          ),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Message could not be sent. Please try again later.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _openProject(Map<String, String> project) {
    ProjectModel? selectedProject;

    switch (project['project']) {
      case 'grela':
        selectedProject = ProjectData.grela;
        break;

      case 'razacks_homeopathy':
        selectedProject = ProjectData.razacks;
        break;

      case 'foodiaq':
        selectedProject = ProjectData.foodiaq;
        break;

      default:
        final link = project['link'];
        if (link != null && link.isNotEmpty) {
          _viewModel.launchURL(link);
        }
        return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProjectDetailsView(project: selectedProject!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth > 900;
              return SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    if (isDesktop)
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: DesktopHeroSection(
                          onResume: openPdf,
                          onPortfolio: _scrollToPortfolio,
                          onContact: _scrollToContact,
                          onGithub: () => _viewModel.launchURL(
                            'https://github.com/athifmhd21',
                          ),
                          onLinkedIn: () => _viewModel.launchURL(
                            'https://www.linkedin.com/in/athif21/',
                          ),
                        ),
                      )
                    else
                      MobileHeroSection(
                        onResume: openPdf,
                        onPortfolio: _scrollToPortfolio,
                        onContact: _scrollToContact,
                        onGithub: () => _viewModel.launchURL(
                          'https://github.com/athifmhd21',
                        ),
                        onLinkedIn: () => _viewModel.launchURL(
                          'https://www.linkedin.com/in/athif21',
                        ),
                      ),
                    AboutSection(onResume: openPdf),
                    PortfolioSection(
                      sectionKey: _portfolioKey,
                      projects: _viewModel.filteredProjects,
                      selectedFilter: _viewModel.selectedFilter,
                      onFilterChanged: _viewModel.setSelectedFilter,
                      onProjectTap: _openProject,
                    ),
                    ContactSection(
                      sectionKey: _contactKey,
                      formKey: _contactFormKey,
                      nameController: _nameController,
                      emailController: _emailController,
                      phoneController: _phoneController,
                      messageController: _messageController,
                      isSending: _viewModel.isSendingMessage,
                      onSubmit: _submitContactForm,
                      onWhatsApp: _viewModel.openWhatsApp,
                    ),
                  ],
                ),
              );
            },
          ),
          if (_showIntro)
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _introController,
                builder: (context, child) => IgnorePointer(
                  child: Opacity(opacity: _introFade.value, child: child),
                ),
                child: PortfolioIntroOverlay(
                  nameFade: _nameFade,
                  detailsFade: _detailsFade,
                  lineProgress: _lineProgress,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
