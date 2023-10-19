import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:newsapp/models/category_model.dart';

import 'package:newsapp/models/modellprovider.dart';

import 'package:newsapp/views/articleviewscreen.dart';
import 'package:newsapp/widget/customappbar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _textcontroller = TextEditingController();
    final appState = Provider.of<ModelProvider>(context);
    List<CategoryModel> categories = appState.categories;
    List<ArticleModel> articles = appState.articles;

    return Scaffold(
      appBar: const CustomAppBar(title: "Apna "),
      body: appState.loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                child: Column(
                  children: [
                    Container(
                      decoration:
                          const BoxDecoration(color: Colors.transparent),
                      child: TextField(
                        onEditingComplete: () {
                          appState.getsearchdata(search: _textcontroller.text);
                        },
                        controller: _textcontroller,
                        decoration: const InputDecoration(
                          labelText: "Enter Text",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Container(
                      height: 70,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return CategoryTile(
                            imageUrl: categories[index].imageUrl,
                            categoryName: categories[index].categoryName,
                          );
                        },
                      ),
                    ),
                    //article
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: (articles.isEmpty)
                          ? const Center(
                              child: Text(
                                "Not Found",
                                style: TextStyle(
                                    fontSize: 50,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54),
                              ),
                            )
                          : ListView.builder(
                              itemCount: articles.length,
                              physics: const ClampingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return BlogTile(
                                  imageUrl: articles[index].urlToImage,
                                  title: articles[index].title,
                                  desc: articles[index].description,
                                  url: articles[index].url,
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String imageUrl, categoryName;
  const CategoryTile({
    super.key,
    required this.imageUrl,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    final getcategoryprovider = Provider.of<ModelProvider>(context);
    return GestureDetector(
      onTap: () async {
        await getcategoryprovider.getcategorydata(category: categoryName);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 12, right: 16),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: 120,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: 120,
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                categoryName,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc, url;
  const BlogTile(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.desc,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(newspageurl: url)));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(imageUrl),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              desc,
              style: const TextStyle(
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}




  // floatingActionButton: FloatingActionButton(
  //       onPressed: toggleTextFieldVisibility,
  //       // onPressed: () {
  //       //   Navigator.push(context,
  //       //       MaterialPageRoute(builder: (context) => const SearchScreen()));
  //       // },
  //       child: Icon(isTextFieldVisible ? Icons.close : Icons.edit),
  //     ),
  //     bottomNavigationBar: AnimatedContainer(
  //       color: Colors.transparent,
  //       duration: const Duration(milliseconds: 50),
  //       curve: Curves.easeInOut,
  //       height: isTextFieldVisible
  //           ? (sizz > 0)
  //               ? sizz + 100
  //               : 500
  //           : 0.0,
  //       child: isTextFieldVisible
  //           ? Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Container(
  //                 decoration: const BoxDecoration(color: Colors.transparent),
  //                 child: TextField(
  //                   controller: _textcontroller,
  //                   decoration: const InputDecoration(
  //                     labelText: "Enter Text",
  //                     border: OutlineInputBorder(),
  //                   ),
  //                 ),
  //               ),
  //             )
  //           : null,
  //     ),
  //     drawer: Drawer(
  //       surfaceTintColor: Colors.yellow,
  //       child: ListView(
  //         padding: EdgeInsets.zero,
  //         children: const <Widget>[
  //           DrawerHeader(
  //             decoration: BoxDecoration(
  //               color: Colors.blue,
  //             ),
  //             child: Text(
  //               'Apna Khabari',
  //               style: TextStyle(
  //                 color: Colors.white,
  //                 fontSize: 24,
  //               ),
  //             ),
  //           ),
  //           ListTile(
  //             leading: Icon(Icons.message),
  //             title: Text('Messages'),
  //           ),
  //           ListTile(
  //             leading: Icon(Icons.account_circle),
  //             title: Text('Profile'),
  //           ),
  //           ListTile(
  //             leading: Icon(Icons.settings),
  //             title: Text('Settings'),
  //           ),
  //         ],
  //       ),
  //     ),