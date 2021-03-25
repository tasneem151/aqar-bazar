/* Center(
                    child: loading
                        ? CircularProgressIndicator()
                        : InkWell(
                            onTap: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                setState(() {
                                  loading = true;
                                });
                                Services.getSearchResponse(
                                  context,
                                  selectedItem.toLowerCase(),
                                  title,
                                  catId,
                                  minPrice,
                                  maxPrice,
                                  space,
                                ).then((value) => {
                                      print(value.data.length),
                                      setState(() {
                                        loading = false;
                                      }),
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return SearchResult(
                                          searchResponse: value,
                                          buy: selectedItem == "Purchase"
                                              ? true
                                              : false,
                                        );
                                      })),
                                    });
                              }
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height / 18,
                              width: MediaQuery.of(context).size.width / 2.2,
                              child: Center(
                                child: Text(
                                  "Search",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xff4e89c7),
                                    Color(0xff21d8a2),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: [0.1, 1.0],
                                ),
                              ),
                            ),
                          ),
                  ), */
