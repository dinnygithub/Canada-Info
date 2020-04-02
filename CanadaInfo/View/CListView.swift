//
//  CListView.swift
//  CanadaInfo
//
//  Created by Dinny Anand on 01/04/2020.
//  Copyright © 2020 Dinny Anand. All rights reserved.
//

import SnapKit
class CListView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let backgroundView: UIView = {
           let view = UIView(frame: .zero)
        view.backgroundColor = Theme.colors.ciGreen()
           return view
       }()

    
    
    let tableview: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = Theme.colors.ciWhite()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
 
    
    private func setup() {
           setupViews()
           setupConstraints()
       }
    
    private func setupConstraints() {
        backgroundView.pinEdges(to: self)
        self.tableview.pinEdges(to: backgroundView)
       }

    private func setupViews() {
           self.addSubview(backgroundView)
           self.addSubview(tableview)
    }
}





