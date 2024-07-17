import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:sco_v1/models/splash/commonData_model.dart';

class Constants {
  static const String username = "liferay_access@sco.ae";
  static const String password = "India@1234";
  static const String basicAuth = 'Basic bGlmZXJheV9hY2Nlc3NAc2NvLmFlOkluZGlhQDEyMzQ=';

  static Map<String, Response> lovCodeMap = {};

  static RegExp get emiratesIdRegex =>
      RegExp(r'\b784-[0-9]{4}-[0-9]{7}-[0-9]{1}\b');

  static PinTheme defaultPinTheme = PinTheme(
      width: 44,
      height: 44,
      textStyle: const TextStyle(fontSize: 18, color: Colors.black),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.transparent),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: -1,
              blurRadius: 4,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ]));

  static const String longText = '''
  I love my India. This statement is not just an expression of my emotions, but a profound reflection of the deep-seated affection and pride I feel for my homeland. India, a nation of unparalleled diversity, rich history, and vibrant culture, holds a special place in my heart. Every aspect of this vast land, from its picturesque landscapes to its bustling cities, from its ancient traditions to its modern advancements, evokes a sense of belonging and pride.

India, often referred to as the cradle of civilization, boasts a history that dates back thousands of years. The Indus Valley Civilization, one of the world's earliest urban cultures, flourished here around 2500 BCE. This ancient civilization laid the foundation for India's cultural and societal norms, many of which have endured through the millennia. The timeless Vedas, written in Sanskrit, are among the oldest sacred texts in the world and form the bedrock of Indian philosophy, spirituality, and culture.

The resilience and continuity of Indian civilization are evident in its myriad cultural practices and traditions. Festivals like Diwali, Holi, Eid, Christmas, and Pongal showcase the country's religious diversity and the harmonious coexistence of various communities. These celebrations, filled with vibrant colors, delicious foods, and joyous rituals, embody the spirit of unity in diversity that is intrinsic to India's national identity.

India's geographical diversity is as remarkable as its cultural tapestry. The snow-capped peaks of the Himalayas, the arid expanses of the Thar Desert, the lush greenery of the Western Ghats, and the serene backwaters of Kerala all contribute to the country's breathtaking natural beauty. Each region offers a unique landscape and climate, providing habitats for diverse flora and fauna. National parks and wildlife sanctuaries across the country, such as Jim Corbett, Kaziranga, and Sundarbans, are home to majestic creatures like tigers, elephants, and rhinoceroses, underscoring India's commitment to preserving its natural heritage.

The cultural mosaic of India is further enriched by its linguistic diversity. With 22 officially recognized languages and hundreds of dialects, India is a linguistic treasure trove. Each language carries its own literary and artistic heritage, contributing to a rich tapestry of storytelling, poetry, and music. The classical dance forms of Bharatanatyam, Kathak, Odissi, and Kathakali, alongside the folk dances of Bhangra, Garba, and Bihu, exemplify the expressive power of Indian art and its ability to convey complex emotions and narratives.

Indian cuisine, celebrated worldwide for its bold flavors and aromatic spices, is another testament to the country's diversity. Each region boasts its own culinary traditions, reflecting the local climate, agriculture, and cultural influences. From the fiery curries of Rajasthan to the delicate flavors of Bengali sweets, from the hearty parathas of Punjab to the coastal delights of Goan seafood, Indian food is a sensory journey that delights the palate and warms the soul.

India's contributions to the world extend beyond its cultural and natural beauty. The country has made significant strides in science, technology, and innovation. Ancient Indian mathematicians like Aryabhata and Brahmagupta made pioneering contributions to the field of mathematics, including the concept of zero. In modern times, India has emerged as a global leader in information technology, space exploration, and medical research. The Indian Space Research Organisation (ISRO) has achieved remarkable milestones, including the successful Mars Orbiter Mission, which made India the first country to reach Mars on its maiden attempt.

Education and intellectual pursuit have always been valued in Indian society. Ancient universities like Nalanda and Takshashila were renowned centers of learning that attracted scholars from across the world. Today, India continues to prioritize education, with institutions like the Indian Institutes of Technology (IITs) and Indian Institutes of Management (IIMs) being recognized for their academic excellence globally. The country's emphasis on education has produced a wealth of talented professionals who contribute to various fields worldwide.

The spirit of democracy and resilience is deeply ingrained in the Indian ethos. Despite its immense diversity and the challenges that come with it, India has upheld its democratic values and institutions since gaining independence in 1947. The world's largest democracy, India conducts elections on an unprecedented scale, allowing millions of citizens to exercise their right to vote. This democratic framework has empowered marginalized communities and fostered a sense of inclusivity and participation in the nation-building process.

India's commitment to social justice and human rights is reflected in its progressive legal framework and social policies. The country has made significant strides in promoting gender equality, protecting the rights of marginalized communities, and ensuring access to education and healthcare for all. Initiatives like the Right to Education Act, Beti Bachao Beti Padhao (Save the Girl Child, Educate the Girl Child), and Ayushman Bharat (National Health Protection Scheme) aim to create a more equitable and inclusive society.

Indian spirituality and philosophy have also left an indelible mark on the world. The teachings of Mahatma Gandhi, who championed the principles of nonviolence and truth, continue to inspire global movements for peace and justice. The practice of yoga, with its emphasis on physical, mental, and spiritual well-being, has gained immense popularity worldwide, promoting a holistic approach to health and harmony.

In addition to its cultural and intellectual heritage, India is a land of economic opportunity and innovation. As one of the fastest-growing economies in the world, India is home to a thriving entrepreneurial ecosystem. Cities like Bangalore, Hyderabad, and Mumbai have emerged as global hubs for technology and innovation, attracting investment and talent from around the world. The government's initiatives to promote startups and ease of doing business have further bolstered India's position as a destination for innovation and economic growth.

The spirit of community and hospitality is a hallmark of Indian society. The concept of "Atithi Devo Bhava" (Guest is God) reflects the deep-rooted tradition of treating guests with utmost respect and warmth. This spirit of hospitality extends beyond individual interactions and is evident in the country's approach to international relations. India has consistently advocated for peaceful coexistence, cooperation, and mutual respect on the global stage, playing a constructive role in international organizations and regional forums.

In conclusion, my love for India is a reflection of the profound admiration and pride I feel for its rich cultural heritage, natural beauty, intellectual achievements, and commitment to democracy and social justice. India, with its unparalleled diversity and enduring spirit, stands as a testament to the resilience and creativity of its people. This love is not just an emotion, but a celebration of the values and ideals that India embodies, inspiring me and countless others to contribute to its continued growth and prosperity.
  ''';
}
