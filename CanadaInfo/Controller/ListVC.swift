//
//  ListVC.swift
//  CanadaInfo
//
//  Created by Dinny Anand on 01/04/2020.
//  Copyright © 2020 Dinny Anand. All rights reserved.
//

import UIKit
import Alamofire

class ListVC: UIViewController, UITableViewDelegate {
    var tableView: UITableView!
    // var dataSource = CanadaDataSource()
    private var viewModel: CanadaListViewModel = CanadaListViewModel() {
        didSet{
            self.updateUI()
        }
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
        NotificationCenter.default.addObserver(self.mainView.tableview, selector: #selector(updateUI), name: UIContentSizeCategory.didChangeNotification, object: nil)

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem:
            UIBarButtonItem.SystemItem.refresh, target: self, action:
            #selector(refreshData))
        refreshData()
    }
    
    @objc func refreshData(){
        if Connectivity.isConnectedToInternet(){
            getCanadaData()
        }else{
            self.showAlertMessage(titleStr: kNoInternet, messageStr: "")
        }
    }
    
    func getCanadaData(){
        WebService().getApiData(url: kBaseUrl){ [weak self] canadaData in
            guard let strongSelf = self else { return }
            strongSelf.viewModel = CanadaListViewModel(title: canadaData.title,  rows: canadaData.rows)
            DispatchQueue.main.async() {
                self?.title = strongSelf.viewModel.title
            }
        }
    }
//    
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        self.updateUI()
//    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10;
    }
    
    // header is created which is used as space between each row item.
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = UIColor.clear
        return header
    }
    
    //To get dynamic cell height, UITableViewAutomaticDimension is used and the constraints of the table view cell is set up accordingly.
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    @objc private func updateUI() {
        DispatchQueue.main.async() { [weak self] in
            self?.tableView.reloadData()
            self?.tableView.invalidateIntrinsicContentSize()
            self?.tableView.layoutIfNeeded()
        }
    }
   
    
    
}

extension ListVC : UITableViewDataSource {
    //data is shown in sections to acheive space between each row item
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.viewModel.canadaRows?.count ?? 0 <= 0 {
            //show no data message if there is no rows available in the web service response
            tableView.setEmptyView(title: kSorry, message: kNoData)
        }
        else {
            tableView.restore()
        }
        return (self.viewModel.canadaRows?.count) ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    //data from canadaList is accessed and the table view is populated
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellId, for: indexPath) as! CanadaTVC
        cell.backgroundColor = UIColor.white
        cell.tag = indexPath.section
        let canadaRow = self.viewModel.canadaRows?[indexPath.section]
        cell.titleLabel.text = canadaRow?.title
        cell.descriptionLabel.text = canadaRow?.description
        cell.canadaImageView.imageFromUrl(canadaRow?.imageHref ?? "")
        if cell.canadaImageView.image == nil {
            cell.canadaImageView.image = UIImage(named: "noimage")
        }
        cell.makeRoundCorners(byRadius: 10)
        return cell
    }
}
