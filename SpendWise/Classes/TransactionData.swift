//
//  TransactionData.swift
//  SpendWise
//
//  Created by ya su on 2023-03-24.
// Student Number: 991638096

import UIKit

// TransactionData class represents a single transaction, including its details such as
// date, category, amount, type, description, and balance.
class TransactionData: NSObject {
    
    // Properties to store the transaction details
    var id : Int?
    var date : String?
    var category : String?
    var amount : String?
    var type : String?
    var descriptions : String?
    var balance : String?
    
    // Method to initialize the TransactionData object with the provided details
    func initWithData(theRow i : Int, theDate d : String, theCategory c : String, theAmount a : String,
                     theType t : String, theDescriptions des : String, theBalance b : String){
        id = i
        date = d
        category = c
        amount = a
        type = t
        descriptions = des
        balance = b
        
    }

}
