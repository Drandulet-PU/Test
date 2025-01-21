import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(ForceZakupApp());
}

class ForceZakupApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FORCEZAKUP',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ForceZakupHomePage(),
    );
  }
}

class ForceZakupHomePage extends StatefulWidget {
  @override
  _ForceZakupHomePageState createState() => _ForceZakupHomePageState();
}

class _ForceZakupHomePageState extends State<ForceZakupHomePage> {
  int _visitorCount = 0;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _incrementVisitorCount();
    // Показываем рекламный баннер при старте приложения
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showAdvertisementBanner();
    });
  }

  void _incrementVisitorCount() {
    setState(() {
      _visitorCount++;
    });
  }

  void _showChatBot() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ChatBotDialog();
      },
    );
  }

  // Добавляем метод для показа рекламного баннера
  void _showAdvertisementBanner() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: _buildAdvertisementBanner(),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Закрыть диалог при нажатии кнопки
              },
              child: Text('Закрыть'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      _buildCatalogView(),
      _buildDeliveryPaymentView(),
      _buildContactView(),
      _buildReviewsView(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('FORCEZAKUP'),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Каталог'),
          BottomNavigationBarItem(icon: Icon(Icons.payment), label: 'Доставка и оплата'),
          BottomNavigationBarItem(icon: Icon(Icons.contact_mail), label: 'Контакты'),
          BottomNavigationBarItem(icon: Icon(Icons.comment), label: 'Отзывы'),
        ],
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showChatBot,
        tooltip: 'Чат-бот',
        child: Icon(Icons.chat),
      ),
    );
  }

  Widget _buildCatalogView() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBannerSection(),
          _buildProductGrid(),
        ],
      ),
    );
  }

  Widget _buildBannerSection() {
    return Container(
      height: 250, // Размер основного баннера
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/banner.jpg'), // Основной баннер
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildAdvertisementBanner() {
    return Container(
      height: 200, // Размер рекламного баннера
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.amber, // Цвет фона рекламного баннера
        image: DecorationImage(
          image: AssetImage('assets/ad_banner.jpg'), // Замените на свой рекламный баннер
          fit: BoxFit.cover,
        ),
      ),
      // Убрали текст "Специальное предложение"
    );
  }

  Widget _buildProductGrid() {
    final products = [
      {'name': 'Наушники HOCO', 'price': '1000₽', 'image': 'assets/product1.jpg'},
      {'name': 'Чехол iPhone 13 pro', 'price': '2000₽', 'image': 'assets/product2.jpg'},
      {'name': 'Чайник', 'price': '3599', 'image': 'assets/product3.jpg'},
      {'name': 'Smart Часы', 'price': '4999', 'image': 'assets/product4.jpg'},
      {'name': 'Беспроводная мышь', 'price': '5699', 'image': 'assets/product5.jpg'},
      {'name': 'Клавиатура', 'price': '6799', 'image': 'assets/product6.jpg'},
      {'name': 'Умная колонка', 'price': '6500', 'image': 'assets/product7.jpg'},
      {'name': 'Микрофон', 'price': '7000', 'image': 'assets/product8.jpg'},
    
      // Добавьте другие товары...
    ];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            elevation: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0), // Меньше в три раза
                    child: Image.asset(
                      product['image']!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    product['name']!,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Text(product['price']!),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDeliveryPaymentView() {
    return Center(
      child: Text('Информация о доставке и оплате'),
    );
  }

  Widget _buildContactView() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () async {
            final Uri emailUri = Uri(
              scheme: 'mailto',
              path: 'adamcorp01@gmail.com',
            );
            if (await canLaunch(emailUri.toString())) {
              await launch(emailUri.toString());
            }
          },
          child: Text(
            'Связаться: adamcorp01@gmail.com, '
            'sshaduntsev@yandex.ru, '
            'vlad.koptelov@gmail.com, '
            'stmustang74@gmail.com',
            style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
          ),
        ),
        SizedBox(height: 10), // Отступ между текстом и изображением
        Image.asset(
          'photo_333', // Замените на путь к вашему изображению
          height: 100, // Установите нужную высоту
          width: 100, // Установите нужную ширину
        ),
      ],
    ),
  );
}
  Widget _buildReviewsView() {
    return Center(
      child: Text('Отзывы пользователей'),
    );
  }

  Widget _buildVisitorCounter() {
    return Container(
      padding: EdgeInsets.all(8.0),
      color: Colors.grey.shade200,
      child: Text(
        'Посетители: $_visitorCount',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
class ChatBotDialog extends StatefulWidget {
  @override
  _ChatBotDialogState createState() => _ChatBotDialogState();
}

class _ChatBotDialogState extends State<ChatBotDialog> {
  final List<String> _messages = [];
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() async {
    if (_controller.text.isNotEmpty) {
      String userMessage = _controller.text;

      setState(() {
        _messages.add("Вы: " + userMessage);
        _controller.clear();
      });

      // Условие для перехода на ссылку Telegram-бота
      if (userMessage.toLowerCase().contains("привет")) { // Обратите внимание на использование toLowerCase()
        String telegramBotUrl = "https://t.me/RoboChatForceZakup_bot"; // замените на вашу ссылку

        // Попробуем запустить URL и добавим отладочный вывод
        if (await canLaunch(telegramBotUrl)) {
          await launch(telegramBotUrl);
        } else {
          print('Не удалось открыть $telegramBotUrl'); // Вывод сообщения об ошибке
        }
      } else {
        setState(() {
          _messages.add("Екатерина (онлайн): " + "Спасибо за ваше сообщение!");
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return Text(_messages[index]);
                },
              ),
            ),
            TextField(
              controller: _controller,
              onSubmitted: (_) => _sendMessage(),
              decoration: InputDecoration(
                labelText: "Введите ваше сообщение",
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}