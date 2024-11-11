import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tots_test/src/domain/models/Client.dart';
import 'package:tots_test/src/presentation/pages/client/List/bloc/ClientBloc.dart';
import 'package:tots_test/src/presentation/pages/client/List/bloc/ClientEvent.dart';
import 'package:tots_test/src/presentation/pages/client/update/bloc/ClientUpdateBloc.dart';
import 'package:tots_test/src/presentation/pages/client/update/bloc/ClientUpdateEvent.dart'; // Asegúrate de que este es el modelo correcto

class ClientListItem extends StatelessWidget {
  final Client? client;
  ClientUpdateBloc? bloc;

  ClientListItem(this.client);

  @override 
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'client/update', arguments: client);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.black, width: 1),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              _buildAvatar(),
              SizedBox(width: 16),
              _buildClientDetails(),
              _buildPopupMenu(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return CircleAvatar(
      radius: 30,
      backgroundImage: client?.photo != null
          ? _getImageProvider(client!.photo!)
          : AssetImage('assets/img/user_image.png') as ImageProvider,
    );
  }

  Widget _buildClientDetails() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${client?.firstname ?? ''} ${client?.lastname ?? ''}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            client?.email ?? 'Email Not Available',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopupMenu(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        if (value == 'edit') {
          Navigator.pushNamed(context, 'client/update', arguments: client);
        } else if (value == 'delete') {
          _showDeleteConfirmationDialog(context);
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        _buildPopupMenuItem(
          icon: Icons.edit,
          label: 'Edit',
          color: Colors.black,
          value: 'edit',
        ),
        _buildPopupMenuItem(
          icon: Icons.delete,
          label: 'Delete',
          color: Colors.red,
          value: 'delete',
        ),
      ],
      icon: Icon(Icons.more_vert),
    );
  }

  PopupMenuItem<String> _buildPopupMenuItem({
    required IconData icon,
    required String label,
    required Color color,
    required String value,
  }) {
    return PopupMenuItem<String>(
      value: value,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 16),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  ImageProvider _getImageProvider(String photoPath) {
    if (photoPath.startsWith('http') || photoPath.startsWith('https')) {
      return NetworkImage(photoPath);
    } else if (File(photoPath).existsSync()) {
      return FileImage(File(photoPath));
    } else {
      return AssetImage('assets/img/user_image.png') as ImageProvider;
    }
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('DELETE'),
          content: Text('Are you sure you want to delete this client?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteClient(context);
              },
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _deleteClient(BuildContext context) {
    try {
      final clientUpdateBloc = BlocProvider.of<ClientUpdateBloc>(context);
      clientUpdateBloc.add(ClientDelete(id: client!.id!));
      Navigator.of(context).pop();
      Fluttertoast.showToast(
        msg: 'Client successfully removed',
        toastLength: Toast.LENGTH_SHORT,
      );
      final clientBloc = BlocProvider.of<ClientBloc>(context);
      clientBloc.add(FetchClients(1));
    } catch (e) {
      print('Error: $e');
    }
  }
}


