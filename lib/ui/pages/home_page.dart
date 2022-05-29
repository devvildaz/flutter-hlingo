import 'package:flutter/material.dart';
import 'package:hlinog/ui/widgets/sections_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.amber[200],
        titleTextStyle: const TextStyle(
            color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        title: Row(
          children: [
            Row(
              children: [
                Image.asset(
                  "assets/logo.png",
                  height: 42,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const Text("HoloLingo"),
                )
              ],
            ),
            const Spacer(),
            Row(
              children: const [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 32,
                ),
                Text(
                  "36/120",
                  style: TextStyle(fontSize: 16),
                )
              ],
            )
          ],
        ),
      ),
      body: const SingleChildScrollView(child: SectionsList()),
      floatingActionButton: FloatingActionButton.large(
        elevation: 1,
        backgroundColor: Colors.amber[200],
        tooltip: "Ir al perfil",
        child: Image.asset(
          "assets/profile.png",
          height: 80,
        ),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          color: Colors.amber[200],
          child: SizedBox(
            height: 50,
            child: Row(
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.amber[300]),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(10))),
                  child: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          )),
    );
  }
}
