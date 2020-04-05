# Canada Info

## Author
Dinny Anand

## Libraries Used
Alamofire - swift based http networking library

SnapKit - DSL to make the usage of autolayouts easier

## Utility
Theme - a common place for colors and fonts used through out the app

Extensions : functions for UIView, UIStackview, UIViewcontroller and UITableview is written

UIimage+func - a function to download an image from its url. The image is cached once it is downloaded.

Constants - all constants used throughout the app

## List of main files used in the project:

ListVC - UIViewController. the main view controller

CListView - UIVIew. the view which displays the table view

CanadaTVC - UITableViewCell. the cell for the property list view.

CanadaModel - the model created to map the json object received via web service

CandaListViewModel - supply data to the tableview

WebService.swift - makes the API calls

Connectivity.swift checks the internet reachability using the Alamofire library.

## Explanation:

Everytime the array canadaList: [Row] is populated, the table view is reloaded. The model used to save the data is CanadaModel. The model confirms to Encoding protocol. CListView is loaded to the controller. CandaListViewModel is added to supply data to the tableview.

WebService.swift is used for web services. The code for API calls is not in the view controller. 

The height of table view cells are dynamic according to the data downloaded. No content is clipped and  some rows are  larger than others. To attain this UITableViewAutomaticDimension is used and the constraints of the table view cell is set up accordingly. No story boards or xibs are used.  Snap Kit library helps to use the auto layout constraints easily. A rightBarButtonItem is added for refresh data. To fetch the data, getApiData function is called which has the implementation of web service call via Alamofire library. Since the json response contains other characters, the response is  String.Encoding.isoLatin1 encoded and then mapped to our Canada Model. The table view delagate methods are implemented and populated with data.

The image is downloaded using URLSession from the url. The image is cached once it is downloaded. The  implementation is done by creating a function imageFromUrl

