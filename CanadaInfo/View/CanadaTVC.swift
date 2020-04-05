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
    
    let cellView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 2.0
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let subStack: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        stackView.spacing = 0
        return stackView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Theme.colors.ciBlack()
        label.numberOfLines = 0
        label.font = Theme.fonts.avenirMedium(size: 14.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.left
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = Theme.colors.ciBlack()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.fonts.avenirLight(size: 13)
        label.textAlignment = NSTextAlignment.left
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
        stackView.distribution = .fill
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    func setupView() {
        addSubview(cellView)
        addSubview(mainStack)
        addSubview(canadaImageView)
        
        cellView.pin(to: self)
        cellView.addSubview(mainStack)
        
        addSubview(subStack)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        
        mainStack.addSubview(subStack)
        mainStack.pin(to: cellView)
        
        mainStack.addArrangedSubview(canadaImageView)
        canadaImageView.snp.makeConstraints{ make in
            make.width.equalTo(200)
        }
        
        
        addSubview(subStack)
        mainStack.addArrangedSubview(subStack)
        
        subStack.addArrangedSubview(titleLabel)
        subStack.addArrangedSubview(descriptionLabel)
        
        titleLabel.snp.makeConstraints{ make in
            make.height.equalTo(30)
            make.bottom.equalTo(descriptionLabel.snp.top)
        }
        
        descriptionLabel.snp.makeConstraints{ make in
            make.bottom.equalTo(subStack.snp.bottom)
        }
        subStack.snp.makeConstraints{ make in
            make.bottom.equalTo(mainStack.snp.bottom)
        }
        mainStack.snp.makeConstraints{ make in
            make.bottom.equalTo(cellView.snp.bottom)
        }
        cellView.snp.makeConstraints{ make in
            make.bottom.equalTo(self.snp.bottom)
        }
        self.descriptionLabel.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: NSLayoutConstraint.Axis.vertical);
        self.selectionStyle = .none
    }
}


