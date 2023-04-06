//
//  TransactionData.swift
//  SpendWise
//
//  Created by ya su on 2023-03-24.
// Student Number: 991638096

import UIKit

class TransactionData: NSObject {
    
    var id : Int?
    var date : String?
    var category : String?
    var amount : String?
    var type : String?
    var descriptions : String?
    var balance : String?
    
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
