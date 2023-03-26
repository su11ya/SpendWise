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
                    
                    let description: String
                    if let cdescription = cdescription {
                        description = String(cString: cdescription)
                    } else {
                        description = ""
                    }
                    let balance = String(cString: cbalance!)
                    
                    let transcationData = TransactionData()
                    transcationData.initWithData(theRow: id, theDate: date, theCategory: category, theAmount: amount, theType: type, theDescriptions: description, theBalance: balance)
                    transcation.append(transcationData)
                    
                    print("Query result: ")
                    print("\(id) | \(date) | \(category) | \(amount) | \(type) | \(description) | \(balance)")
         
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

