//
//  AddViewController.swift
//  SpendWise
//
//  Created by ya su on 2023-03-24.
//

import UIKit

class AddViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
 
    let categoryLabel: [String] = ["Cloth", "Groceries", "Gas", "Gym", "Restaurant", "Vacation", "Rent", "Transport", "Gift", "Phone", "Entertainment"]
    
    
    let categoryIcon = ["cloth", "groceries", "gas", "gym", "restaurant", "vacation", "rent", "transport", "gift", "phone", "entertainment"]
    
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryLabel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CollectionViewCell
        cell.CategoryImageView.image = UIImage(named: categoryIcon[indexPath.row])
        cell.CategoryNameLabel.text = categoryLabel[indexPath.row]
        
        return cell
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
  
    }

}

//extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return categoryLabel.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CollectionViewCell
//        cell.CategoryImageView.image = UIImage(named: categoryIcon[indexPath.row])
//        cell.CategoryNameLabel.text = CategoryNameLabel[indexPath.row]
//
//        return cell
//    }
//}
