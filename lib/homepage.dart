import 'package:flutter/material.dart';

import 'orders.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

//with SingleTickerProviderStateMixin para sa tabController
class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  // initState para ma declare ang initial state sa tabController which gi specify
  // nato na iyang length kay 3 it means na naay tulo ka tab tas this lang ang vsync
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  // list na magamit sa listview builder sa items tab
  List items = ['Red Horse', 'Tanduay', 'Coke 1L', 'Sprite 1L', 'Solane'];
  List prices = [115.0, 120.0, 50.0, 50.0, 1070.0];

  //empty list para masudlan sa iyang gipang tuplok na item
  List orders = [];
  List pricesTotal = [];
  double total = 0;

  //var num sudlan sa phone # sa customer info tab
  var num;

  //global key para pag check sa formstate
  var formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController(text: '+63');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Practice Practical Exam'),
          // IconButton na clear para ma clear tanan list ug variable na gamiton
          actions: [IconButton(
              onPressed: (){
                setState(() {
                  orders.clear();
                  pricesTotal.clear();
                  total = 0;
                  name.clear();
                  phone.clear();
                  num = '+63';
                });
              },
              icon: const Icon(Icons.clear)),

          ],

          // TabBar mao ning mag hawid sa names sa Tabs
          bottom: TabBar(
              controller: tabController,
              tabs: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: const Text('Home')),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: const Text('Items')),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: const Text('Customer Information')),
          ])),

      // TabBarView mao ni na widget ang mag display sa sulod sa tab
      // Nakoy 3 ka Tab diha sa ubos which is gi declare nanato sa init state na length 3
      body: TabBarView(
          controller: tabController,
          children: [

            // 1st tab home nag contain rag background image ug some texts
            Tab(child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/Sari-sari.jpg'),
                      fit: BoxFit.cover,
                    )),
                child: const Center(
                  child: Text(
                    'Basic Online Store',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 25.0),
                  ),
                )),
          ),

            // 2nd items gamit ug listview builder para ma display ang items ug prices
            Tab(child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items[index]),
                  subtitle: Text('${prices[index].toString()} Php'),
                  onTap: () {
                    setState(() {
                      orders.add(items[index]);
                      pricesTotal.add(prices[index]);
                      total += prices[index];
                    });
                  },
                );
              },
            )
            ),

            // 3rd tab customer info basic lang name ug contact #
            Tab(
              // Form Handling
              child: Form(
                key: formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: ListView(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.name,
                        controller: name,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.account_circle),
                          labelText: 'Name',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: phone,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.phone_android),
                          labelText: 'Mobile #',
                        ),
                        onChanged: (value){
                          setState(() {
                            num = value.toString();
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ],
                  )),
            )
          ]),

      // FAB para sa pag humanag pilig order ug fill up sa customer info
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.done),
          onPressed: () async {
            // navigate to orders page which is basic lang display orders ug prices
            await Navigator.push(
                context,
                MaterialPageRoute(
                  // Routing with Parameters nara
                  // nag route ta to orders page tas nag pass pud tag data na
                  // required parameters sa orders page
                    builder: (context) => Orders(
                          orders: orders,
                          totalPay: pricesTotal,
                          name: name.text,
                          phone: num,
                        )));
          }),

      // bottomNavigationBar igo ra display sa total na bayrunon
      bottomNavigationBar: Container(
        height: 40,
        color: Colors.teal,
        child: Center(
          child: Text('Total Payment = ${total.toString()}'),
        ),
      ),
    );
  }
}
