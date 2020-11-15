Card(
                    clipBehavior: Clip.antiAlias,
                    color: Colors.blue[200],
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Column(children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: ListTile(
                          title: new Center(
                            child: Text(
                              "Card Title 1",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FlatButton(
                            color: new Color(0x000000),
                            onPressed: () {
                              // Perform some action
                            },
                            child: new Icon(Icons.room),
                          ),
                          FlatButton(
                            color: new Color(0x000000),
                            onPressed: () {
                              // Perform some action
                            },
                            child: const Icon(Icons.phone),
                          ),
                        ],
                      ),
                      Image.asset('assets/card-sample-image.jpg'),
                      Image.asset('assets/card-sample-image-2.jpg'),
                    ])),
