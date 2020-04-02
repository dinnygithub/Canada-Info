//
//  ListVC.swift
//  CanadaInfo
//
//  Created by Dinny Anand on 01/04/2020.
//  Copyright © 2020 Dinny Anand. All rights reserved.
//

import UIKit
import Alamofire

class ListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
     var tableView: UITableView!
        var canadaList : [Row] = [] {
            didSet {updateUI()}
        }
       var mainView: CListView! { return self.view as? CListView }
           
        override func loadView() {
               self.view = CListView(frame: UIScreen.main.bounds)
           }

       override func viewDidLoad() {
           super.viewDidLoad()
           tableView = self.mainView.tableview
           tableView.delegate = self
           tableView.dataSource = self
           tableView.rowHeight = UITableView.automaticDimension
           tableView.register(CanadaTVC.self, forCellReuseIdentifier: kCellId)
           
           navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem:
               UIBarButtonItem.SystemItem.refresh, target: self, action:
           #selector(refreshData))
           
           getApiData()
       }
       
       @objc func refreshData(){
           getApiData()
       }
       
       
       func getApiData(){
           AF.request(kBaseUrl,method: .get).response { response in
               guard let dataJson = response.data else { return }
               
               //Since the json response contains other characters, the response is  String.Encoding.isoLatin1 encoded
               let responseStrInISOLatin = String(data: dataJson, encoding: String.Encoding.isoLatin1)
               guard let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8) else {
                     print("could not convert data to UTF-8 format")
                     return
                }
               do {
                   guard let _ = try JSONSerialization.jsonObject(with: modifiedDataInUTF8Format, options: .mutableContainers) as? [String: Any] else {return}
                   let decoder = JSONDecoder()
                   
                   // the data is mapped to our object Canada Model and property canadaList is populated
                   guard let canadaData = try? decoder.decode(CanadaModel.self, from: modifiedDataInUTF8Format) else { return }
                   self.canadaList = (canadaData.rows)!
                    DispatchQueue.main.async() {
                           //the title of the view controller is also populated via the response from the web service
                           if canadaData.title.count>0 {
                               self.title = canadaData.title
                           }
                   }
                   self.updateUI()
               }catch {
                       debugPrint(error)
               }
           }
       }
       
       func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
              return 10;
          }

       //data is shown in sections to acheive space between each row item
       func numberOfSections(in tableView: UITableView) -> Int {
              return self.canadaList.count
           }

       // header is created which is used as space between each row item.
       func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
              let header = UIView()
              header.backgroundColor = UIColor.clear
              return header
           }

       //each section will have only 1 row. This is for  design prurpose only.
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return 1
           }
       
       //To get dynamic cell height, UITableViewAutomaticDimension is used and the constraints of the table view cell is set up accordingly.
       func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
              return UITableView.automaticDimension
          }
       
       //data from canadaList is accessed and the table view is populated
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
              let cell = tableView.dequeueReusableCell(withIdentifier: kCellId, for: indexPath) as! CanadaTVC
                    cell.backgroundColor = UIColor.white
                    cell.tag = indexPath.section
                    let canadaRow = self.canadaList[indexPath.section]
                    cell.titleLabel.text = canadaRow.title
                    cell.descriptionLabel.text = canadaRow.description
                    cell.canadaImageView.imageFromUrl(canadaRow.imageHref)
                    if cell.canadaImageView.image == nil {
                          cell.canadaImageView.image = UIImage(named: "noimage")
                    }
                    cell.makeRoundCorners(byRadius: 10)
                    return cell
       }
       
       private func updateUI() {
                 DispatchQueue.main.async() {
                     self.tableView.reloadData()
                      self.tableView.invalidateIntrinsicContentSize()
                      self.tableView.layoutIfNeeded()
                 }
              }
}
