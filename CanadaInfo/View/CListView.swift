//
//  CListView.swift
//  CanadaInfo
//
//  Created by Dinny Anand on 01/04/2020.
//  Copyright © 2020 Dinny Anand. All rights reserved.
//

import UIKit
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
        view.backgroundColor = Theme.colors.ciWhite()
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
    }
    
    private func setupViews() {
        self.addSubview(backgroundView)
        backgroundView.pin(to: self)
   //     self.addSubview(tableview)
        backgroundView.addSubview(self.tableview)
        
        tableview.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.92)
            make.height.equalToSuperview().multipliedBy(0.95)
            make.centerX.equalTo(backgroundView)
            make.centerY.equalTo(backgroundView)
        }
        backgroundView.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}





