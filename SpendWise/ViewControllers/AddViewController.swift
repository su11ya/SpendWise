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


    
    @IBOutlet weak var amountLabel: UILabel!
        var amount: Double = 0.0
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
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
        navigationBar.delegate = nil
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
  
    }
    
    
    
        @IBAction func numberPressed(_ sender: UIButton) {
            let tag = sender.tag
            switch tag {
            case -1:
                // Delete button pressed
                amount = 0
                amountLabel.text = String(format: "$%.2f", amount)

            case 0...9:
                // Number button pressed
                let digit = Double(tag)
                if amount == 0 {
                    amount = digit / 100
                } else {
                    amount = amount * 10 + digit / 100
                }
                amountLabel.text = String(format: "$%.2f", amount)
            default:
                break
            }
        }
    

    @IBAction func okPressed(_ sender: Any) {
        // Perform action with amount
    }
    
    
    @IBAction func onePressed(_ sender: UIButton) {
        print(sender.tag)
    }
    
    
    @IBAction func twoPressed(_ sender: UIButton) {
        print(sender.tag)
    }
    
    
    @IBAction func threePressed(_ sender: UIButton) {
        print(sender.tag)
    }
    
    
    
    @IBAction func fourPressed(_ sender: UIButton) {
        print(sender.tag)
    }
    
    
    
    @IBAction func fivePressed(_ sender: UIButton) {
        print(sender.tag)
    }
    
    
    
    @IBAction func sixPressed(_ sender: UIButton) {
        print(sender.tag)
    }
    
    
    
    
    @IBAction func sevenPressed(_ sender: UIButton) {
        print(sender.tag)
    }
    
    
    
    @IBAction func eightPressed(_ sender: UIButton) {
        print(sender.tag)
    }
    
    
    @IBAction func ninePressed(_ sender: UIButton) {
        print(sender.tag)
    }
    
    
    
    
}

