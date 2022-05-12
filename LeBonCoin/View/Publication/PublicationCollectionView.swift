//
//  PublicationView.swift
//  LeBonCoin
//
//  Created by Cindy Nguyen on 07/05/2022.
//

import UIKit

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func setUpCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: 300)
        publicationsCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        publicationsCollectionView?.register(PublicationCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        publicationsCollectionView?.backgroundColor = UIColor.white
    }
    
    func decodeAPI(){
        guard let url = URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json") else { return }

        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            let decoder = JSONDecoder()
            if let data = data{
                do {
                    let tasks = try decoder.decode([Publication].self, from: data)
                    tasks.forEach { value in
                        self.publications.append(value)
                        self.publications.sort {
                            $0!.creationDate.compare($1!.creationDate) == .orderedDescending
                        }
                        self.publications.sort { $0!.isUrgent && !$1!.isUrgent }
                    }
                } catch {
                    print(error)
                }
                
                DispatchQueue.main.async {
                    self.publicationsCollectionView.reloadData()
                }
            }
        }
        task.resume()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return publications.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let filterVC = FilterViewController()
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PublicationCollectionViewCell
        cell.titleLabel.text = publications[indexPath.row]?.title
        cell.priceLabel.text = "\(publications[indexPath.row]!.price)€"
        cell.publicationImage.downloaded(from: (publications[indexPath.row]?.small) ?? "")
        filterVC.fetchJsonData { (categories, error) in
            if let err = error {
                print(err)
                return
            }
            
            categories?.forEach() { (category) in
                DispatchQueue.main.async {
                    if category.id == self.publications[indexPath.row]!.categoryId {
                        cell.categoryLabel.text = category.name
                    }
                }
            }
        }
        cell.urgentLabel.isHidden = !publications[indexPath.row]!.isUrgent
            
        
        cell.titleLabel.text = publications[indexPath.row]?.title ?? ""
        cell.layer.cornerRadius = 15
        var isPair: Bool {
            return indexPath.row % 2 == 0
        }
        cell.backgroundColor = isPair ? UIColor.customLightBeige : UIColor.customDarkBeige
        return cell
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}

extension ViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let publicationDetail = self.publications[indexPath.row] else {
            return
        }
        let detailsViewController = DetailsViewController(publicationDetail)
        self.present(detailsViewController, animated:true, completion:nil)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width - 16, height: 120)
    }
}
