//
//  CollectionViewCell.swift
//  SpendWise
//
//  Created by ya su on 2023-03-24.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var CategoryNameLabel: UILabel!
    
    @IBOutlet weak var CategoryImageView: UIImageView!
    func configure(with categoryName: String){
        CategoryNameLabel.text = categoryName
    }
}
