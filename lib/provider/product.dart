import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String image;
  final String title;
  final String description;
  final double price;
  final int quantity;
  // final double weight;
  final String id;
  final Color color;
  bool isFavorite;
  // String dummyText =
  //   "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";
  Product({
    required this.id,
    required this.image,
    required this.title,
    required this.price,
    required this.description,
    required this.quantity,
    // required this.weight,
    required this.color,
    this.isFavorite = false,
  });
  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  static List<Product> products = [
    // Product(
    //     id: '1',
    //     title: "Laptop",
    //     price: 2000,
    //     quantity: 12,
    //     description:
    //         "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.",
    //     image:
    //         "https://ict.com.mm/cdn/shop/files/MSICyborg15A12UC_i5-12thGen_TranslucentBlackNB0510121_1.jpg",
    //     color: const Color(0xFF3D82AE)),
    // Product(
    //     id: '2',
    //     title: "Power Bank",
    //     price: 120,
    //     quantity: 8,
    //     description:
    //         "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.",
    //     image:
    //         "https://www.borofone.com/wp-content/uploads/2022/05/borofone-bj18a-coolmy-digital-display-power-bank-30000mah-ports.jpg",
    //     color: const Color(0xFFD3A984)),
    // Product(
    //     id: '3',
    //     title: "TV",
    //     price: 1000,
    //     quantity: 10,
    //     description:
    //         "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.",
    //     image:
    //         "https://www.drmacmandalay.com/wp-content/uploads/2019/11/pc-specs-header02.png",
    //     color: const Color(0xFF989493)),
    // Product(
    //     id: '4',
    //     title: "Couch",
    //     price: 1200,
    //     quantity: 11,
    //     description:
    //         "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.",
    //     image:
    //         "https://www.thespruce.com/thmb/xof3_Trgry-XhSH1-2azfRdRpSM=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/signs-to-replace-your-couch-4165258-hero-5266fa7b788c41f6a02f24224a5de29b.jpg",
    //     color: const Color(0xFFE6B398)),
    // Product(
    //     id: '5',
    //     title: "Coat",
    //     price: 250,
    //     quantity: 12,
    //     description:
    //         "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.",
    //     image:
    //         "https://www.bodenimages.com/productimages/r1aproductxlarge/23waut_u0156_blu_w01.jpg",
    //     color: const Color(0xFFFB7883)),
    // Product(
    //   id: '6',
    //   title: "Bag",
    //   price: 234,
    //   quantity: 12,
    //   description:
    //       "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.",
    //   image:
    //       "https://cdn.obag.filoblu.com/media/catalog/product/cache/25162cc576cf81151d28507649e6339b/O/B/OBAGBG10_ECSN6_936_NOTAG_UNICA_L2.jpg",
    //   color: const Color(0xFFAEAEAE),
    // ),
    // Product(
    //   id: '7',
    //   title: "Readme Note12",
    //   price: 60,
    //   quantity: 12,
    //   description:
    //       "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.",
    //   image:
    //       "https://ict.com.mm/cdn/shop/files/XiaomiRedmiNote12Pro5G_1_7ffc4cf5-1d47-4487-955b-de0dc2c85b14.png",
    //   color: const Color(0xFFAEAEAE),
    // ),
    // Product(
    //   id: '8',
    //   title: "Watch",
    //   price: 500,
    //   quantity: 12,
    //   description:
    //       "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.",
    //   image:
    //       "https://assets.ajio.com/medias/sys_master/root/20231020/d3ae/6531d6e7afa4cf41f5533346/-473Wx593H-466729370-rosegold-MODEL.jpg",
    //   color: const Color(0xFFAEAEAE),
    // ),
    // Product(
    //   id: '9',
    //   title: "Lotion",
    //   price: 60,
    //   quantity: 12,
    //   description:
    //       "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.",
    //   image:
    //       "https://i5.walmartimages.com/seo/eos-Shea-Better-Body-Lotion-for-Dry-Skin-Vanilla-Cashmere-16-fl-oz_1fcba750-23cd-4c32-9b23-50af972577c4.f8a37d4761acb1db4be9162158d8dbfe.png",
    //   color: const Color(0xFFAEAEAE),
    // ),
    // Product(
    //   id: '10',
    //   title: "Dress",
    //   price: 400,
    //   quantity: 12,
    //   description:
    //       "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.",
    //   image:
    //       "https://i.etsystatic.com/35085851/r/il/90611b/5157622693/il_1588xN.5157622693_hzri.jpg",
    //   color: const Color(0xFFAEAEAE),
    // ),
    // Product(
    //   id: '11',
    //   title: "Sprit",
    //   price: 10,
    //   quantity: 12,
    //   description:
    //       "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.",
    //   image:
    //       "https://www.coca-cola.com/content/dam/onexp/au/en/brands/sprite/new/03-08-2024/sprite.png/width1960.png",
    //   color: const Color(0xFFAEAEAE),
    // ),
    // Product(
    //   id: '12',
    //   title: "Ball",
    //   price: 7,
    //   quantity: 12,
    //   description:
    //       "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.",
    //   image: "https://cdn.britannica.com/87/151887-050-BE5CB604/football.jpg",
    //   color: const Color(0xFFAEAEAE),
    // ),
  ];
}
