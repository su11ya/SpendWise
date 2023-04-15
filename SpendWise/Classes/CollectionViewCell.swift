//
//  CollectionViewCell.swift
//  SpendWise
//
//  Created by ya su on 2023-03-24.
// Student Number: 991638096

// This file contains the CollectionViewCell class, which is a custom UICollectionViewCell
// used to display categories in SpendWise.

import UIKit

// CollectionViewCell is a UICollectionViewCell subclass that displays a category name and image.
class CollectionViewCell: UICollectionViewCell {
    
    // Outlet for the category name label.
    @IBOutlet weak var CategoryNameLabel: UILabel!
    
    // Outlet for the category image view.
    @IBOutlet weak var CategoryImageView: UIImageView!
    
    // This method is used to configure the cell with a given category name.
    // Parameter categoryName: The name of the category to display in the cell.
    func configure(with categoryName: String){
        CategoryNameLabel.text = categoryName
    }
}
