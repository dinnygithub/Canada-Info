//
//  CanadaTVC.swift
//  CanadaInfo
//
//  Created by Dinny Anand on 01/04/2020.
//  Copyright © 2020 Dinny Anand. All rights reserved.
//

import UIKit
import SnapKit

class CanadaTVC: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeRoundCorners(byRadius rad: CGFloat) {
        self.layer.cornerRadius = rad
        self.clipsToBounds = true
    }

    let subStack: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
     //   stackView.alignment = .leading
        stackView.spacing = 0
        return stackView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Theme.colors.ciWhite()
        label.numberOfLines = 0
        label.font = Theme.fonts.avenirMedium(size: 14.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.left
          label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = Theme.colors.ciWhite()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.fonts.avenirLight(size: 13)
        label.textAlignment = NSTextAlignment.left
          label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let canadaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let mainStack: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 0
        stackView.addBackground(color: Theme.colors.ciBlack())
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    func setupView() {
        addSubview(mainStack)
        addSubview(canadaImageView)
        addSubview(subStack)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        
        
         self.addSubview(mainStack)
         mainStack.pin(to: self)
         mainStack.addArrangedSubview(canadaImageView)
         mainStack.addArrangedSubview(subStack)
        
         mainStack.snp.makeConstraints{ make in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self)
            make.width.equalToSuperview()
            make.bottom.equalTo(self.snp.bottom)
            make.top.equalTo(self.snp.top)
        }
        
        canadaImageView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.2)
            make.height.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalTo(mainStack.snp.leading)
        }
        
        subStack.addArrangedSubview(titleLabel)
        subStack.addArrangedSubview(descriptionLabel)
        titleLabel.snp.makeConstraints{ make in
            make.height.equalTo(30)
            make.top.equalTo(subStack.snp.top)
            make.width.equalToSuperview()
            make.leading.equalTo(subStack.snp.leading)
            make.bottom.equalTo(descriptionLabel.snp.top)
        }
        descriptionLabel.snp.makeConstraints{ make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.width.equalToSuperview()
            make.bottom.equalTo(subStack.snp.bottom)
              make.leading.equalTo(subStack.snp.leading)
        }
        subStack.snp.makeConstraints{ make in
            make.bottom.equalTo(mainStack.snp.bottom)
        }
        self.descriptionLabel.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: NSLayoutConstraint.Axis.vertical);
        self.selectionStyle = .none
    }
}


