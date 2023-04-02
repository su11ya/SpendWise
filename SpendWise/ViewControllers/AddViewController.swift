//
//  AddViewController.swift
//  SpendWise
//
//  Created by ya su on 2023-03-24.
//

import UIKit

class AddViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
   
//    let categoryLabel: [String] = ["Cloth", "Groceries", "Gas", "Gym", "Restaurant", "Vacation", "Rent", "Transport", "Gift", "Phone", "Entertainment"]
    
    
//    let categoryIcon = ["cloth", "groceries", "gas", "gym", "restaurant", "vacation", "rent", "transport", "gift", "phone", "entertainment"]


    let incomeCategotyLabel: [String] = ["Salary", "Bonus", "Gift", "Finance", "Stock"]
    
    let incomeCategoryIcon = ["salary", "bonus", "gift", "finance", "stock"]
    
    
    @IBOutlet var lbAmount : UILabel!
    @IBOutlet var sgType : UISegmentedControl!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var amountLabel: UILabel!
    
    var selectedCategory : String = "Cloth"
    var selectedDateOfBirth : String = ""
    var amount: Double = 0.0
    var categoryLabel : [String] = []
    var categoryIcon = ["cloth", "groceries", "gas", "gym", "restaurant", "vacation", "rent", "transport", "gift", "phone", "entertainment"]
    var typeResult = "Expense"
    var descriptionResult: String = "N/A"
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    let dateFormatter = DateFormatter()


    func updateType(){
        let type = sgType.selectedSegmentIndex
        
        if type == 0 {
            
            categoryLabel = ["Cloth", "Groceries", "Gas", "Gym", "Restaurant", "Vacation", "Rent", "Transport", "Gift", "Phone", "Entertainment", "Movie", "Game", "Taxi", "Book", "Drug", "Education", "Toy", "House"]
            categoryIcon = ["cloth", "groceries", "gas", "gym", "restaurant", "vacation", "rent", "transport", "gift", "phone", "entertainment", "movie", "game", "taxi", "book", "drug", "education", "toy", "house"]
            typeResult = "Expense"
            print("segment expense")
            
        } else{
            
            categoryLabel = ["Salary", "Bonus", "Gift", "Finance", "Stock"]
            categoryIcon = ["salary", "bonus", "gift", "finance", "stock"]
            typeResult = "Income"
            print("segement income")
        }
        
        categoryCollectionView.reloadData()
        selectedCategory = categoryLabel[0]
    }
    

    
    

    

    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategory = categoryLabel[indexPath.row]
        print(selectedCategory)
    }

    
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBAction func addTransaction(sender : Any){
        let transaction : TransactionData = TransactionData.init()
        transaction.initWithData(theRow: 0, theDate: selectedDateOfBirth, theCategory: selectedCategory, theAmount: lbAmount.text!, theType: typeResult, theDescriptions: descriptionResult, theBalance: "0")
        
        let returnCode = mainDelegate.insertIntoDatabase(transcation: transaction)
        
        var returnMSG : String = "Transaction Added"
        if returnCode == false {
            returnMSG = "Transaction add failed"
        }
        
        let alertController = UIAlertController(title: "SQLite add", message: returnMSG, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel)
        
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
        
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
    
    @IBAction func calanderPressed(_ sender: UIButton) {
        
            // Set the frame for the date picker
            datePicker.frame = CGRect(x: 0, y: view.frame.height - 216, width: view.frame.width, height: 216)
            
            // Unhide the date picker
            datePicker.isHidden = false
        
       }
    
    @IBAction func datePickerValueChanged(sender: UIDatePicker){
        let selectedDate = sender.date
        selectedDateOfBirth = dateFormatter.string(from: selectedDate)
        
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
    
    @IBAction func segmentDidChange(sender: UISegmentedControl){
        updateType()
    }
    
    @IBAction func showNotesDialog(sender: UIButton) {
        let alertController = UIAlertController(title: "Add a Note", message: nil, preferredStyle: .alert)

        alertController.addTextField { (textField) in
            textField.placeholder = "Enter your note here"
        }

        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] (_) in
            if let noteText = alertController.textFields?.first?.text {
                // Save the note to a variable or storage mechanism in your view controller
                self?.descriptionResult = noteText
            }
        }
        alertController.addAction(saveAction)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        //navigationBar.delegate = nil
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
        // Create the date picker
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: .valueChanged)
        datePicker.isHidden = true // Hide the date picker initially

        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        updateType() // Add this line to update the collection view with expense categories by default
        
    }

    

    
}

