import 'package:flutter/material.dart';

class Search extends SearchDelegate{
  List recipeNames;
  String selectedResult;

  Search(this.recipeNames);

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          icon: Icon(Icons.close),
          onPressed: (){
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: (){
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text(selectedResult),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List suggestedRecipeNames = [];
    query.isEmpty ? suggestedRecipeNames = recipeNames
        : suggestedRecipeNames.addAll(recipeNames.where(
          (element) => element["name"].toLowerCase().contains(query.toLowerCase()),
    ));

    return ListView.builder(
        itemCount: suggestedRecipeNames.length,
        itemBuilder: (BuildContext context, int index)
    {
      return new Container(
          padding: EdgeInsets.only(top: 15),
          child: Row(
            children: [
              Image.network(suggestedRecipeNames[index]["picture"], height: 80,
                  width: 120,
                  fit: BoxFit.fill),
              Expanded(child: ListTile(
                title: Text(
                  suggestedRecipeNames[index]["name"],
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                subtitle: Text(suggestedRecipeNames[index]["description"]),
                trailing: Text(
                  suggestedRecipeNames[index]["id"].toString(),
                  style: TextStyle(color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),

              )
              )

            ],
          )
      );
    },
    );
  }
}