//
//  ViewController.swift
//  LeBonCoin
//
//  Created by Cindy Nguyen on 04/05/2022.
//

import UIKit

class ViewController: UIViewController {
    var publicationsCollectionView: UICollectionView!
    var publications: [Publication?] = []
    let filterView = FilterViewController().view!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        publicationsCollectionView.delegate = self
        publicationsCollectionView.dataSource = self
        decodeAPI()
    }
    
    func setUpView() {
        let view = UIView()
        view.backgroundColor = .white
        
        setUpCollectionView()

        filterView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(filterView)
        NSLayoutConstraint.activate([
            filterView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            filterView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            filterView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            filterView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        publicationsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(publicationsCollectionView)
        NSLayoutConstraint.activate([
            publicationsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            publicationsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            publicationsCollectionView.topAnchor.constraint(equalTo: filterView.topAnchor, constant: 50),
            publicationsCollectionView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height - 25)
        ])
        
        self.view = view
    }
    
}
