import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Routing Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/detail': (context) => const DetailScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Nasi Goreng'),
            subtitle: Text('Nasi yang digoreng dengan bumbu dan ditambah bahan makanan lainnya'),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/detail',
                arguments: {
                  'title': 'Nasi Goreng',
                  'subtitle': 'Nasi yang digoreng dengan bumbu dan ditambah bahan makanan lainnya',
                  'imagePath': 'assets/nasi_goreng_image.png',
                  'description': 'Nasi Goreng adalah makanan yang populer di Indonesia. Nasi ini digoreng dengan berbagai bumbu dan ditambah dengan berbagai macam bahan makanan lainnya seperti telur, daging, atau seafood. Rasanya yang gurih dan sedikit pedas membuatnya disukai oleh banyak orang. Makanan ini biasanya disajikan di warung-warung atau restoran Indonesia.'
                },
              );
            },
          ),
          ListTile(
            title: Text('Mie Goreng'),
            subtitle: Text('Mie yang digoreng dengan bumbu dan ditambah bahan makanan lainnya'),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/detail',
                arguments: {
                  'title': 'Mie Goreng',
                  'subtitle': 'Mie yang digoreng dengan bumbu dan ditambah bahan makanan lainnya',
                  'imagePath': 'assets/mie_goreng_image.png',
                  'description': 'Mie Goreng adalah makanan yang sangat populer di Indonesia. Mie ini digoreng dengan berbagai bumbu dan ditambah dengan berbagai macam bahan makanan lainnya seperti daging, sayuran, dan telur. Rasanya yang gurih dan tekstur mie yang kenyal membuatnya menjadi favorit banyak orang di Indonesia.'
                },
              );
            },
          ),
          ListTile(
            title: Text('Ayam Goreng'),
            subtitle: Text('Ayam yang digoreng dengan bumbu'),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/detail',
                arguments: {
                  'title': 'Ayam Goreng',
                  'subtitle': 'Ayam yang digoreng dengan bumbu',
                  'imagePath': 'assets/ayam_goreng_image.png',
                  'description': 'Ayam Goreng adalah hidangan yang terbuat dari potongan ayam yang digoreng dalam minyak panas. Ayam biasanya digoreng dengan bumbu-bumbu rempah seperti kunyit, lada, dan bawang putih. Hidangan ini sering disajikan sebagai makanan utama di rumah-rumah dan restoran-restoran di seluruh dunia.'
                },
              );
            },
          ),
          ListTile(
            title: Text('Soto Ayam'),
            subtitle: Text('Kuah dengan irisan daging ayam dan ditambah bahan lainnya'),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/detail',
                arguments: {
                  'title': 'Soto Ayam',
                  'subtitle': 'Kuah dengan irisan daging ayam dan ditambah bahan lainnya',
                  'imagePath': 'assets/soto_ayam_image.png',
                  'description': 'Soto Ayam adalah makanan khas Indonesia yang terbuat dari kuah kaldu ayam yang gurih dan irisan daging ayam. Biasanya disajikan dengan tambahan mie, tauge, ketupat, dan bahan pelengkap lainnya seperti perkedel atau telur. Rasanya yang kaya rempah dan hangat membuatnya menjadi hidangan yang cocok disantap di pagi hari.'
                },
              );
            },
          ),
          ListTile(
            title: Text('Nasi Kuning'),
            subtitle: Text('Nasi yang dimasak dengan kunyit dan disajikan dengan lauk pauk'),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/detail',
                arguments: {
                  'title': 'Nasi Kuning',
                  'subtitle': 'Nasi yang dimasak dengan kunyit dan disajikan dengan lauk pauk',
                  'imagePath': 'assets/nasi_kuning_image.png',
                  'description': 'Nasi Kuning adalah hidangan nasi yang berasal dari Indonesia. Nasi ini dimasak dengan bumbu kunyit sehingga berwarna kuning cerah. Biasanya disajikan dengan berbagai lauk pauk seperti ayam goreng, telur, dan sayuran. Nasi Kuning sering disajikan pada acara-acara khusus dan merupakan simbol keberuntungan dan keberkahan.'
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text(args['title']),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage(args['imagePath']),
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            Text(
              args['title'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              args['description'],
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
