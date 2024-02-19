import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easykey/screens/ad_detail.page.dart';
import 'package:flutter/material.dart';

import '../classes/ads.dart';

class advertPage extends StatefulWidget {
  const advertPage({super.key});

  @override
  State<advertPage> createState() => _advertPageState();
}

class _advertPageState extends State<advertPage> {
  late ScrollController scrollController;
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      print(scrollController.offset);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('ads').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Bir hata oluştu: ${snapshot.error}');
          } else {
            List<QueryDocumentSnapshot> adsDocuments = snapshot.data!.docs;
            List<ads> adsList = adsDocuments
                .map((document) =>
                    ads.fromMap(document.data() as Map<String, dynamic>))
                .toList();

            return Column(
              children: [
                Expanded(
                  child: adsList.isEmpty
                      ? Center(
                          child: Text(
                            'Herhangi bir ilan yok',
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.all(5),
                          itemCount: adsList.length,
                          controller: scrollController,
                          itemBuilder: (context, index) {
                            ads ad = adsList[index];
                            return Card(
                              margin: EdgeInsets.all(5),
                              child: ListTile(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => adDetail(
                                              ad: ad,
                                            ))),
                                contentPadding: EdgeInsets.all(0),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      ad.images.isNotEmpty ? ad.images[0] : '',
                                      width: double
                                          .infinity, // Resmi genişliği ekrana sığacak şekilde ayarla
                                      height:
                                          200, // Resmin yüksekliğini ayarla (isteğe bağlı)
                                      fit: BoxFit
                                          .cover, // Resmi uygun şekilde boyutlandır
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${ad.price} TL",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            ad.title ?? "",
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal),
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: ElevatedButton(
                                                  onPressed: () {},
                                                  child: Text("Ara"),
                                                ),
                                              ),
                                              SizedBox(
                                                  width:
                                                      5), // Butonlar arası boşluk
                                              Expanded(
                                                child: ElevatedButton(
                                                  onPressed: () {},
                                                  child: Text("Mesaj"),
                                                ),
                                              ),
                                              SizedBox(
                                                  width:
                                                      5), // Butonlar arası boşluk
                                              Expanded(
                                                child: ElevatedButton(
                                                  onPressed: () {},
                                                  child: Text("Whatsapp"),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
                SizedBox(height: 80),
              ],
            );
          }
        },
      ),
    );
  }
}