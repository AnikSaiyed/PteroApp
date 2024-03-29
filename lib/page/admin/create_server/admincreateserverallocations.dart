/*
* Copyright 2018 Ruben Talstra and Yvan Watchman
*
* Licensed under the GNU General Public License v3.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*    https://www.gnu.org/licenses/gpl-3.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../auth/shared_preferences_helper.dart';
import '../../../globals.dart' as globals;
import 'dart:async';
import 'dart:convert';
import '../../../main.dart';
import 'admincreateservernodes.dart';
import 'admincreateserversend.dart';

class Allocations {
  final String nestid,
      userid,
      eggid,
      dockerimage,
      startup,
      limitmemory,
      limitswap,
      disklimit,
      iolimit,
      cpulimit,
      locationsid,
      nodeid,
      allocationsid,
      servername,
      port;
  const Allocations(
      {this.nestid,
      this.userid,
      this.eggid,
      this.dockerimage,
      this.startup,
      this.limitmemory,
      this.limitswap,
      this.disklimit,
      this.iolimit,
      this.cpulimit,
      this.locationsid,
      this.nodeid,
      this.allocationsid,
      this.servername,
      this.port});
}

class AdminCreateServerAllocationsPage extends StatefulWidget {
  AdminCreateServerAllocationsPage({Key key, this.server}) : super(key: key);
  final Nodes server;

  @override
  _AdminCreateServerAllocationsPageState createState() =>
      _AdminCreateServerAllocationsPageState();
}

class _AdminCreateServerAllocationsPageState
    extends State<AdminCreateServerAllocationsPage> {
  Map data;
  List userData;

  Future getData() async {
    String _apiadmin = await SharedPreferencesHelper.getString("apiAdminKey");
    String _urladmin = await SharedPreferencesHelper.getString("panelAdminUrl");
    String _adminhttps = await SharedPreferencesHelper.getString("adminhttps");
    http.Response response = await http.get(
      "$_adminhttps$_urladmin/api/application/nodes/${widget.server.nodeid}/allocations",
      headers: {
        "Accept": "Application/vnd.pterodactyl.v1+json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $_apiadmin"
      },
    );
    data = json.decode(response.body);
    setState(() {
      userData = data["data"];
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: globals.useDarkTheme ? null : Colors.transparent,
        leading: IconButton(
          color: globals.useDarkTheme ? Colors.white : Colors.black,
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back,
              color: globals.useDarkTheme ? Colors.white : Colors.black),
        ),
        title: Text(DemoLocalizations.of(context).trans('admin_create_server_7_8'),
            style: TextStyle(
                color: globals.useDarkTheme ? Colors.white : Colors.black,
                fontWeight: FontWeight.w700)),
      ),
      body: ListView.builder(
        itemCount: userData == null ? 0 : userData.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
              child: Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Stack(
              children: <Widget>[
                /// Item card
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox.fromSize(
                      size: Size.fromHeight(140.0),
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          /// Item description inside a material
                          Container(
                            margin: EdgeInsets.only(top: 24.0),
                            child: Material(
                              elevation: 14.0,
                              borderRadius: BorderRadius.circular(12.0),
                              shadowColor: globals.useDarkTheme
                                  ? Colors.blueGrey
                                  : Color(0x802196F3),
                              child: InkWell(
                                onTap: () {
                                  var route = new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new AdminCreateServerSendPage(
                                            server: Allocations(
                                          allocationsid: userData[index]
                                                  ["attributes"]["id"]
                                              .toString(),
                                          locationsid:
                                              widget.server.locationsid,
                                          limitmemory:
                                              widget.server.limitmemory,
                                          limitswap: widget.server.limitswap,
                                          disklimit: widget.server.disklimit,
                                          iolimit: widget.server.iolimit,
                                          cpulimit: widget.server.cpulimit,
                                          userid: widget.server.userid,
                                          nestid: widget.server.nestid,
                                          eggid: widget.server.eggid,
                                          dockerimage:
                                              widget.server.dockerimage,
                                          startup: widget.server.startup,
                                          nodeid: widget.server.nodeid,
                                          servername: widget.server.servername,
                                          port: userData[index]["attributes"]
                                                  ["port"]
                                              .toString(),
                                        )),
                                  );
                                  Navigator.of(context).push(route);
                                },
                                child: Container(
                                  child: Padding(
                                    padding: EdgeInsets.all(24.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        /// Title and rating
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                                '${userData[index]["attributes"]["alias"]}',
                                                style: TextStyle(
                                                    color: Colors.blueAccent)),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                    'IP: ${userData[index]['attributes']['ip']}',
                                                    style: TextStyle(
                                                        color:
                                                            globals.useDarkTheme
                                                                ? Colors.white
                                                                : Colors.black,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 18.0)),
                                              ],
                                            ),
                                          ],
                                        ),

                                        /// Infos
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                                DemoLocalizations.of(context)
                                                    .trans(
                                                        'admin_allocations_id'),
                                                style: TextStyle(
                                                  color: globals.useDarkTheme
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontSize: 18.0,
                                                )),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                              child: Material(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                color: Colors.green,
                                                child: Padding(
                                                  padding: EdgeInsets.all(4.0),
                                                  child: Text(
                                                      '${userData[index]["attributes"]["id"]}',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Colors.white)),
                                                ),
                                              ),
                                            ),
                                            Text(
                                                DemoLocalizations.of(context).trans(
                                                    'admin_allocations_assigned'),
                                                style: TextStyle(
                                                  color: globals.useDarkTheme
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontSize: 18.0,
                                                )),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                              child: Material(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                color: Colors.green,
                                                child: Padding(
                                                  padding: EdgeInsets.all(4.0),
                                                  child: Text(
                                                      '${userData[index]["attributes"]["assigned"]}',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Colors.white)),
                                                ),
                                              ),
                                            ),
                                            Text(
                                                DemoLocalizations.of(context)
                                                    .trans(
                                                        'admin_allocations_port'),
                                                style: TextStyle(
                                                  color: globals.useDarkTheme
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontSize: 18.0,
                                                )),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                              child: Material(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                color: Colors.green,
                                                child: Padding(
                                                  padding: EdgeInsets.all(4.0),
                                                  child: Text(
                                                      '${userData[index]["attributes"]["port"]}',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Colors.white)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )),
                ),
              ],
            ),
          ));
        },
      ),
    );
  }
}
