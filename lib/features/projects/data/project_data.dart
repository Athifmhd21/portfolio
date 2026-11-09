import 'package:portfolio/features/projects/model/project_model.dart';

class ProjectData {
  ProjectData._();

  static const foodiaq = ProjectModel(
    name: 'FoodiaQ',
    type: 'MOBILE APPLICATION',
    role: 'DESIGNING',
    client: 'FREELANCING',
    description:
        'FoodiaQ is a food-ordering application that connects '
        'people across India with homemade Indian cuisines. '
        'From traditional dry snacks and flavourful curries '
        'to complete thalis, it brings the comfort of '
        'home-cooked food to a convenient online platform.',
    purpose:
        'The purpose of FoodiaQ is to make authentic '
        'homemade Indian food accessible to people '
        'across India through one convenient platform. '
        'It aims to connect customers with home chefs '
        'and independent food makers, giving people an '
        'easy way to discover and enjoy home-cooked '
        'meals while helping food makers reach a wider '
        'audience.',
    features:
        'FoodiaQ offers a simple and user-friendly '
        'platform where people can explore a wide '
        'variety of homemade Indian cuisines from '
        'different regions across India. Users can '
        'browse through food categories, discover '
        'dishes prepared by home chefs, search for '
        'their favourite meals, and view detailed '
        'information about each dish, including its '
        'description and pricing. From traditional dry '
        'snacks and delicious curries to complete '
        'thalis, the application aims to make authentic '
        'homemade food easily accessible while helping '
        'home chefs reach a wider audience.',
    previews: [
      ProjectPreview(
        image: 'assets/foodiaq1.png',
        heading: 'HOMEMADE FOOD, MADE EASY',
        description:
            'Discover a variety of homemade Indian dishes from home chefs across the country, all through one convenient platform.',
        highlight: 'A TASTE OF HOME',
      ),
      ProjectPreview(
        image: 'assets/foodiaq2.png',
        heading: 'SIMPLE & TRANSPARENT CHECKOUT',
        description:
            'Complete your purchase effortlessly with a clear billing summary, where every item, price, and payment detail is displayed right in front of you..',
        highlight: 'SOMETHING FOR EVERY CRAVING',
      ),
      ProjectPreview(
        image: 'assets/foodiaq3.png',
        heading: 'ELLABORATIVE DESCRIPTIONS',
        description:
            'Each dish is presented with a clear and detailed description, making it easy for users to understand what they are ordering and from where.',
        highlight: 'SUPPORT LOCAL FOOD MAKERS',
      ),
    ],
  );

  static const grela = ProjectModel(
    name: 'Grela',
    type: 'BUSINESS WEBSITE',
    role: 'DESIGNING',
    client: 'GRELA',
    description:
        'GRELA is a landscape design company specializing in the development of sustainable and visually appealing outdoor spaces. Their services include garden planning, irrigation systems, and landscape maintenance, with a focus on combining functionality, aesthetics, and environmental responsibility.',
    purpose:
        'The purpose of this project is to present Grela and its landscape design services through a clear, engaging business website. The experience is designed to communicate the brand, showcase its work, and make information easy for visitors to explore.',
    features:
        'The project focuses on a structured business website layout, responsive presentation across screen sizes, clear service information, and an intuitive browsing experience.',
    previews: [
      ProjectPreview(
        image: 'assets/grela1.png',
        heading: 'NEW and IMPROVED UI',
        description:
            'A cleaner and modern interface designed for a smoother and more engaging experience.',
        highlight: 'MODERN DESIGN',
      ),
      ProjectPreview(
        image: 'assets/grela2.png',
        heading: 'HOW IT WORKS',
        description:
            'A simple step-by-step process that guides users through transforming their land, from the initial consultation and site assessment to design, installation and ongoing maintenance.',
        highlight: 'FOUR SIMPLE STEPS',
      ),
      ProjectPreview(
        image: 'assets/grela3.png',
        heading: 'FREQUENTLY ASKED QUESTIONS',
        description:
            'A dedicated FAQ section that helps visitors understand Grela’s services, project timelines, irrigation solutions and maintenance support.',
        highlight: 'EASY ACCESS TO CONTACT',
      ),
    ],
  );

  static const razacks = ProjectModel(
    name: 'Razack’s Homeopathy',
    type: 'BUSINESS WEBSITE',
    role: 'DESIGNING AND CODING',
    client: 'DR. MAHSOOM',
    description:
        'DR. RAZACK’S HOMEOPATHY is a homeopathy clinic that focuses on natural, non-invasive treatments. Known for their personalized care (treatment based on each person), it has been around for years and is considered a local, well-known clinic.',
    purpose:
        'The purpose of this website is to give DR. RAZACK’S HOMEOPATHY a clear and professional online presence. It helps visitors understand the clinic, learn about its approach and treatments, meet the doctor, find the clinic, and get in touch to book an appointment.',
    features:
        'Responsive layout for desktop and mobile, welcoming hero section, clinic introduction, “Why Choose Us” highlights, founder and doctor profiles, treatment and service cards, appointment booking section, Google Maps location link, and smooth in-page navigation.',
    previews: [
      ProjectPreview(
        image: 'assets/razack1.png',
        heading: 'A FIRST IMPRESSION',
        description:
            'A clean and welcoming homepage introduces DR. RAZACK’S HOMEOPATHY, highlights the clinic’s approach to care and helps visitors quickly understand the doctor.',
        highlight: 'A PROFESSIONAL ONLINE PRESENCE',
      ),
      ProjectPreview(
        image: 'assets/razack2.png',
        heading: 'TREATMENTS AND SERVICES',
        description:
            'Dedicated service sections help visitors explore the clinic’s treatment areas, including piles, fissure and fistula care, migraine treatment, chronic disease management and asthma treatment.',
        highlight: 'CLEAR SERVICE INFORMATION',
      ),
      ProjectPreview(
        image: 'assets/razack3.png',
        heading: 'ONLINE BOOKING',
        description:
            'A dedicated section introduces the location and wherabouts to clients and how to get ahold of the doctor for an online booking with a single tap on the screen.',
        highlight: 'PERSONAL AND TRUSTWORTHY',
      ),
    ],
  );
}
