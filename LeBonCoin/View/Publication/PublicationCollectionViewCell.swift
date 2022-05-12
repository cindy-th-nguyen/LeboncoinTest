//
//  PublicationCell.swift
//  LeBonCoin
//
//  Created by Cindy Nguyen on 04/05/2022.
//

import Foundation
import UIKit

class PublicationCollectionViewCell: UICollectionViewCell {
    let vStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = NSLayoutConstraint.Axis.vertical
        sv.alignment = UIStackView.Alignment.center
        sv.distribution = UIStackView.Distribution.fillEqually
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.clipsToBounds = true
        return sv
    }()
    
    let publicationImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "photo")
        image.tintColor = .gray
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let urgentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "exclamationmark.triangle.fill")
        imageAttachment.image = UIImage(systemName: "exclamationmark.triangle.fill")?.withTintColor(.red)

        let fullString = NSMutableAttributedString(string: "")
        fullString.append(NSAttributedString(attachment: imageAttachment))
        fullString.append(NSAttributedString(string: " URGENT"))
        label.attributedText = fullString
        label.textColor = .red
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setPublicationImageConstraints()
        setLabelsConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews(){
        addSubview(publicationImage)
        addSubview(vStackView)
        vStackView.addArrangedSubview(titleLabel)
        vStackView.addArrangedSubview(urgentLabel)
        vStackView.addArrangedSubview(categoryLabel)
        vStackView.addArrangedSubview(priceLabel)
    }
    
    func setPublicationImageConstraints() {
        publicationImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        publicationImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        publicationImage.heightAnchor.constraint(equalToConstant: 80).isActive = true
        publicationImage.widthAnchor.constraint(equalTo: publicationImage.heightAnchor, multiplier: 1).isActive = true
    }
    
    func setLabelsConstraints() {
        vStackView.topAnchor.constraint(equalTo: publicationImage.topAnchor).isActive = true
        vStackView.leadingAnchor.constraint(equalTo: publicationImage.trailingAnchor, constant: 13).isActive = true
        vStackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: publicationImage.trailingAnchor, constant: 13).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        urgentLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        categoryLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
    }
}
