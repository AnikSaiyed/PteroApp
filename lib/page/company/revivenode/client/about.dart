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

class ReviveNodeAboutPage extends StatefulWidget {
  @override
  _ReviveNodeAboutPageState createState() => new _ReviveNodeAboutPageState();
}

class _ReviveNodeAboutPageState extends State<ReviveNodeAboutPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('About'),
        backgroundColor: Colors.blue[300],
      ),
      body: new Center(
        child: new Text("About Page", style: new TextStyle(fontSize: 35.0)),
      ),
    );
  }
}
