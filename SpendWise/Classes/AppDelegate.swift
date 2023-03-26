//
//  AppDelegate.swift
//  SpendWise
//
//  Created by ya su on 2023-03-24.
//

import UIKit
import SQLite3

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var databaseName : String? = "SpendWiseData.db"
    var databasePath : String?
    //array of data objects
    var transcation : [TransactionData] = []



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //save the database file in the documents folder
        let documentPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        let documentsDir = documentPaths[0]
        //get the location of database document on the phone
        databasePath = documentsDir.appending("/" + databaseName!)
        
        checkAndCreatedDatabase()
        readDataFromDatabase()
                
        
        return true
    }
    
    func readDataFromDatabase(){
        transcation.removeAll()
        
        var db : OpaquePointer? = nil
        
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK{
            print("Successfully opened connection to database at \(self.databasePath)")
            
            var queryStatement : OpaquePointer? = nil
            var queryStatementString : String = "select * from entries"
            
            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                
                while sqlite3_step(queryStatement) == SQLITE_ROW {
                    
                    let id : Int = Int(sqlite3_column_int(queryStatement, 0))
                    let cdate = sqlite3_column_text(queryStatement, 1)
                    let ccategory = sqlite3_column_text(queryStatement, 2)
                    let camount = sqlite3_column_text(queryStatement, 3)
                    let ctype = sqlite3_column_text(queryStatement, 4)
                    let cdescription = sqlite3_column_text(queryStatement, 5)
                    let cbalance = sqlite3_column_text(queryStatement, 6)
                    
                    let date = String(cString: cdate!)
                    let category = String(cString: ccategory!)
                    let amount = String(cString: camount!)
                    let type = String(cString: ctype!)
                    //let description = String(cString: cdescription!)
                    
                    let descriptions: String
                    if let cdescription = cdescription {
                        descriptions = String(cString: cdescription)
                    } else {
                        descriptions = ""
                    }
                    let balance = String(cString: cbalance!)
                    
                    let transcationData = TransactionData()
                    transcationData.initWithData(theRow: id, theDate: date, theCategory: category, theAmount: amount, theType: type, theDescriptions: description, theBalance: balance)
                    transcation.append(transcationData)
                    
                    print("Query result: ")
                    print("\(id) | \(date) | \(category) | \(amount) | \(type) | \(descriptions) | \(balance)")
         
                }//while ends
                
                //free up the memory that was allocated
                sqlite3_finalize(queryStatement)
                
            } else {
                print("Select statement could not be prepared")
            }// prepared ends
            
            //close connection to database
            sqlite3_close(db)
            
        } else {
            print("Unable to open database")
        }
        
    }//readDataFromDatabase ends
    
    func insertIntoDatabase(transcation : TransactionData) -> Bool {
        
        var db : OpaquePointer? = nil
        var returnCode : Bool = true
        
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
            var insertStatement : OpaquePointer? = nil
            // 7 placeholders
            var insertStatementString : String = "insert into entries values(NULL, ?, ?, ?, ?, ?, ?)"
            
            // -1 means no limit character
            if sqlite3_prepare(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
                
                //convert string to NS string, then convert NS string to C string
                let dateStr = transcation.date! as NSString
                let categoryStr = transcation.category! as NSString
                let amountStr = transcation.amount! as NSString
                let typeStr = transcation.type! as NSString
                let descriptionStr = transcation.descriptions! as NSString
                let balanceStr = transcation.balance! as NSString
                
                // 1 is column number; convert to C string; -1 means no limit on bytes
                sqlite3_bind_text(insertStatement, 1, dateStr.utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 2, categoryStr.utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 3, amountStr.utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 4, typeStr.utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 5, descriptionStr.utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 6, balanceStr.utf8String, -1, nil)
             
                if sqlite3_step(insertStatement) == SQLITE_DONE {
                    //retrieve newly inserted rown number
                    let rowID = sqlite3_last_insert_rowid(db)
                    print("Successfully inserted row \(rowID)")
                }
                else {
                    print("Could not insert row")
                    returnCode = false
                }
                // finish up memory allocations, flush data
                sqlite3_finalize(insertStatement)
            }
            else{
                print("Insert statement could not be prepared")
                returnCode = false
            }
            
            sqlite3_close(db)
        }
        else {
            print("Unable to open database")
            returnCode = false
        }
        
        return returnCode
    }
    
    
    
    
    
    func checkAndCreatedDatabase(){
        
        var success = false
        let fileManager = FileManager.default
        
        success = fileManager.fileExists(atPath: databasePath!)
        
        if success {
            return
        }
        
        let databasePathFromApp = Bundle.main.resourcePath?.appending("/" + databaseName!)
        
        try? fileManager.copyItem(atPath: databasePathFromApp!, toPath: databasePath!)
        return
        
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

