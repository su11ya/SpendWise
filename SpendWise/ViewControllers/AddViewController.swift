//
//  AddViewController.swift
//  SpendWise
//
//  Created by ya su on 2023-03-24.
//Student Number: 991638096

// This file contains the AddViewController class, which is responsible for
// displaying the interface for adding new transactions in SpendWise.

import UIKit
import AVFoundation

// AddViewController is a UIViewController subclass that handles adding new transactions
// and managing the collection view of categories.
class AddViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, AVAudioPlayerDelegate {

    // Income category labels and icons.
    let incomeCategotyLabel: [String] = ["Salary", "Bonus", "Gift", "Finance", "Stock"]
    let incomeCategoryIcon = ["salary", "bonus", "gift", "finance", "stock"]
    
    // Outlets for UI elements.
    @IBOutlet var lbAmount : UILabel!
    @IBOutlet var sgType : UISegmentedControl!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var amountLabel: UILabel!
    
    // Variables for storing selected values.
    var selectedCategory : String = "Cloth"
    var selectedDateOfBirth : String = ""
    var amount: Double = 0.0
    var categoryLabel : [String] = []
    var categoryIcon = ["cloth", "groceries", "gas", "gym", "restaurant", "vacation", "rent", "transport", "gift", "phone", "entertainment"]
    var typeResult = "Expense"
    var descriptionResult: String = "N/A"
    
    // Outlets for the collection view and navigation bar.
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    // Date formatter and sound player instances.
    let dateFormatter = DateFormatter()
    var soundPlayer : AVAudioPlayer?
    var selectedIndex: IndexPath? = nil

    // Updates the collection view with the appropriate categories based on the selected segment.
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
    
    // This method returns the number of sections in the collection view.
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    // This method returns the number of items in each section of the collection view.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryLabel.count
    }
    
    // This method sets up each cell in the collection view and returns it.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CollectionViewCell
        cell.CategoryImageView.image = UIImage(named: categoryIcon[indexPath.row])
        cell.CategoryNameLabel.text = categoryLabel[indexPath.row]
        
        if selectedIndex == indexPath {
                // Change the cell border or background color to highlight it
                cell.layer.borderColor = UIColor.systemYellow.cgColor
                cell.layer.borderWidth = 2.0
            } else {
                // Reset the cell border or background color
                cell.layer.borderColor = UIColor.clear.cgColor
                cell.layer.borderWidth = 0.0
            }
        
        return cell
    }
    
    // Called when a cell in the collection view is selected.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedIndex = indexPath
        selectedCategory = categoryLabel[indexPath.row]
        print(selectedCategory)
        collectionView.reloadData()
    }

    
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    // Adds a new transaction to the database.
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
    
    // Handles number and delete button presses for the amount input.
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
    
    // Plays a sound when the OK button is pressed.
    @IBAction func okPressed(_ sender: Any) {
        soundPlayer?.volume = 30
        let soundURL = Bundle.main.path(forResource: "addSound", ofType: "wav")
        let url = URL(fileURLWithPath: soundURL!)
        self.soundPlayer = try! AVAudioPlayer.init(contentsOf: url)
        self.soundPlayer?.currentTime = 0
        //self.soundPlayer?.numberOfLoops = 1
        self.soundPlayer?.play()
        
    }
    
    // Unhides the date picker when the calendar button is pressed.
    @IBAction func calanderPressed(_ sender: UIButton) {
        
            // Set the frame for the date picker
            datePicker.frame = CGRect(x: 0, y: view.frame.height - 216, width: view.frame.width, height: 216)
            
            // Unhide the date picker
            datePicker.isHidden = false
        
       }
    
    // Updates the selected date when the date picker value changes.
    @IBAction func datePickerValueChanged(sender: UIDatePicker){
        let selectedDate = sender.date
        selectedDateOfBirth = dateFormatter.string(from: selectedDate)
        
    }

    // This method is triggered when the "1-9" button is pressed.
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
    
    // Handles segment control changes.
    @IBAction func segmentDidChange(sender: UISegmentedControl){
        updateType()
    }
    
    // Shows a dialog to add a note for the transaction.
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
    
    
    // Sets up the view controller and its UI elements when the view is loaded.
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up the view's background color and delegate properties.
        view.backgroundColor = .white
        //navigationBar.delegate = nil
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
        // Create the date picker and configure its initial state.
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: .valueChanged)
        datePicker.isHidden = true // Hide the date picker initially

        // Configure the date formatter.
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // Update the collection view with expense categories by default.
        updateType() // Add this line to update the collection view with expense categories by default
        
    }

    

    
}

