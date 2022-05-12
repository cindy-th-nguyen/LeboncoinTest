//
//  DetailsViewController.swift
//  LeBonCoin
//
//  Created by Cindy Nguyen on 08/05/2022.
//

import UIKit

class DetailsViewController: UIViewController {
    private var publication: Publication
    
    let hStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = NSLayoutConstraint.Axis.horizontal
        sv.alignment = UIStackView.Alignment.center
        sv.distribution = UIStackView.Distribution.fillEqually
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.clipsToBounds = true
        return sv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.customAuburn
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .justified
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let publicationImage: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 100, y: 150, width: 150, height: 150))
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = image.frame.width / 3
        image.sizeToFit()
        return image
    }()
    
    let creationDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.italicSystemFont(ofSize: 14)
        return label
    }()
    
    let isUrgentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(_ publication: Publication) {
        self.publication = publication
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpViews()
        configureComponents()
        setUpConstraints()
    }
    
    func setUpViews() {
        view.addSubview(publicationImage)
        view.addSubview(titleLabel)
        view.addSubview(hStackView)
        view.addSubview(creationDateLabel)
        view.addSubview(isUrgentLabel)
        view.addSubview(descriptionLabel)
        
        hStackView.addArrangedSubview(priceLabel)
        hStackView.addArrangedSubview(categoryLabel)
    }
    
    func configureComponents() {
        titleLabel.text = publication.title
        categoryLabel.text = "\(setCategoryName())"
        descriptionLabel.text = publication.description
        priceLabel.text = "\(publication.price)€"
        creationDateLabel.text = "Créée le \(setFrenchDate())"
        isUrgentLabel.text = publication.isUrgent ? "⚠️ URGENT ⚠️" : ""
        publicationImage.downloaded(from: (publication.thumb) ?? "")
        view.backgroundColor = .customLightBeige
    }
    
    func setUpConstraints() {
        publicationImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        publicationImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        publicationImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 35).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: publicationImage.bottomAnchor, constant: 25).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        
        hStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15).isActive = true
        hStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        hStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        isUrgentLabel.topAnchor.constraint(equalTo: hStackView.bottomAnchor, constant: 15).isActive = true
        isUrgentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        isUrgentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        creationDateLabel.topAnchor.constraint(equalTo: isUrgentLabel.bottomAnchor, constant: 15).isActive = true
        creationDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        creationDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: creationDateLabel.bottomAnchor, constant: 15).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        
        categoryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        
    }
    
    func setFrenchDate() -> String{
        let dateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.date(from:publication.creationDate)!
        
        let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: date)
        
        guard let day = calendarDate.day else { return "" }
        guard let month = calendarDate.month else { return "" }
        guard let year = calendarDate.year else { return "" }
        
        var finalFrenchDate = ""
        var dayStr = ""
        var monthStr = ""
        
        dayStr = (day<=9) ? "0\(day)" : "\(day)"
        monthStr = (month <= 9) ? "0\(month)" : "\(month)"
        
        finalFrenchDate = "\(dayStr)/\(monthStr)/\(year)"
        return finalFrenchDate
    }
    
    func setCategoryName() {
        let filterVC = FilterViewController()
        filterVC.fetchJsonData { (categories, error) in
            if let err = error {
                print(err)
                return
            }
            
            categories?.forEach() { (category) in
                DispatchQueue.main.async {
                    if category.id == self.publication.categoryId {
                        self.categoryLabel.text = "\(category.name)"
                    }
                }
            }
        }
    }
}
