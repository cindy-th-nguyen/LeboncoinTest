//
//  FilterView.swift
//  LeBonCoin
//
//  Created by Cindy Nguyen on 07/05/2022.
//

import UIKit

class FilterViewController: UIViewController {
    private enum Constants {
        static let segmentedControlHeight: CGFloat = 40
        static let underlineViewColor: UIColor = .blue
        static let underlineViewHeight: CGFloat = 2
    }
    
    private var categories: [String] = []
    
    private lazy var segmentedControlContainerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .clear
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.backgroundColor = .clear
        segmentedControl.tintColor = .clear

        fetchJsonData() { (categories, error) in
            if let err = error {
                print(err)
                return
            }

            categories?.forEach() { (category) in
                DispatchQueue.main.async {
                    segmentedControl.insertSegment(withTitle: category.name, at: category.id - 1, animated: true)
                }
            }
        }

        segmentedControl.selectedSegmentIndex = 0

        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular)], for: .normal)

        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.blue,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)], for: .selected)

        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)

        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(segmentedControlContainerView)
        segmentedControlContainerView.addSubview(segmentedControl)

        let safeLayoutGuide = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            segmentedControlContainerView.topAnchor.constraint(equalTo: safeLayoutGuide.topAnchor),
            segmentedControlContainerView.leadingAnchor.constraint(equalTo: safeLayoutGuide.leadingAnchor),
            segmentedControlContainerView.widthAnchor.constraint(equalTo: safeLayoutGuide.widthAnchor),
            segmentedControlContainerView.heightAnchor.constraint(equalToConstant: Constants.segmentedControlHeight)
        ])
    }

    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        
    }
    
    func fetchJsonData(completion: @escaping ([Category]?, Error?) -> ()) {
        let urlString = "https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, error) in
            
            if let err = error {
                completion(nil, err)
                return
            }
            
            do {
                let posts = try JSONDecoder().decode([Category].self, from: data!)
                completion(posts, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}
