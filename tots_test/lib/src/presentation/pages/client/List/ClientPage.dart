import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tots_test/src/domain/models/Client.dart';
import 'package:tots_test/src/domain/utils/Resource.dart';
import 'package:tots_test/src/presentation/pages/client/List/ClientListItem.dart';
import 'package:tots_test/src/presentation/pages/client/List/bloc/ClientBloc.dart';
import 'package:tots_test/src/presentation/pages/client/List/bloc/ClientEvent.dart';
import 'package:tots_test/src/presentation/pages/client/List/bloc/ClientState.dart';
import 'package:tots_test/src/presentation/pages/client/create/ClientCreatePage.dart';
import 'package:tots_test/src/presentation/pages/client/update/bloc/ClientUpdateBloc.dart';
import 'package:tots_test/src/presentation/widgets/Image_background.dart';

class ClientPage extends StatefulWidget {
  const ClientPage({super.key});

  @override
  State<ClientPage> createState() => _ClientState();
}

class _ClientState extends State<ClientPage> {
  late ClientBloc _bloc;
  int currentPage = 1;
  int clientsToShow = 5;// Inicialmente mostrar 5 clientes
  List<Client> clients = [];
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<ClientBloc>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bloc.add(FetchClients(currentPage));
    });
  }

  void _loadMore() {
    setState(() {
      currentPage++;
      clientsToShow += 5;
    });
    _fetchClients();
  }

  Future<void> _refreshClients() async {
    setState(() {
      currentPage = 1;
      clientsToShow = 5;
      clients.clear();
    });
    _fetchClients();
  }

  void _fetchClients() {
    _bloc.add(FetchClients(currentPage, searchQuery: searchQuery));
  }

  void _onSearchPressed() {
    setState(() {
      searchQuery = _searchController.text.trim();
      currentPage = 1;
      clientsToShow = 5; 
      clients.clear();
      
    });
    _fetchClients();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed:(){
              _showLogoutConfirmationDialog(context);
            } ,
            icon: Icon(Icons.logout),)
        ],
      ),
      body: Stack(
        children: [
         ImageBackground(),
         BlocListener<ClientBloc, ClientState>(
          listener: (context, state) {
            final responseState = state.response;
            if (responseState is Error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(responseState.message)),
              );
            }
          },
          child: BlocBuilder<ClientBloc, ClientState>(
            builder: (context, state) {
              final responseState = state.response;
              if (responseState is Loading && clients.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              } else if (responseState is Success) {
                clients = responseState.data as List<Client>;
              }
              final clientsToDisplay = clients.take(clientsToShow).toList();
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/img/image.png',
                          height: 50,
                        ),
                        const Align(
                         alignment: Alignment.centerLeft, 
                            child: Text(
                                'CLIENTS',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(67, 69, 69, 1),
                                ),
                              ),

                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                decoration: InputDecoration(
                                  hintText: 'Search...',
                                  prefixIcon: const Icon(Icons.search),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: _onSearchPressed,
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                backgroundColor: Colors.black,
                              ),
                              child: const Text(
                                'OK',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ClientCreatePage()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                backgroundColor: Colors.black,
                              ),
                              child: const Text(
                                'ADD NEW',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: _refreshClients,
                      child: ListView.builder(
                        itemCount: clientsToDisplay.length,
                        itemBuilder: (context, index) {
                          return ClientListItem(clientsToDisplay[index]);
                        },
                      ),
                    ),
                  ),
                  if (clients.length > clientsToShow)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ElevatedButton(
                        onPressed: _loadMore,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 120),
                          backgroundColor: Colors.black,
                        ),
                        child: const Text(
                          'LOAD MORE',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
 
        ],
      ),
    );
  }


    void _showLogoutConfirmationDialog(BuildContext context) { 
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _bloc?.add(Logout());                 
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('login');
              },
              child: Text('Logout', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

}
