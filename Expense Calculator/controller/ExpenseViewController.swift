//
//  ViewController.swift
//  Expense Calculator
//
//  Created by viraj shah on 03/03/25.
//

import UIKit
import CoreData

class ExpenseViewController: UITableViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    var expanse = ["Apple:300","Banana:400","Orange:500","Bus:600","TV:700","Books:500"]
    var expanse = [Item]()
    var selectedCategory:Category?{
        didSet{
            print("hello",selectedCategory!.name!)
            loadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
//    MARK: - TableView Methodes
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expanse.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expenseCell",for:indexPath)
        cell.textLabel?.text = expanse[indexPath.row].title
        return cell
    }
    
//    MARK: - Saving and loading methodes
    func saveData(){
        do{
            try context.save()
        }catch{
            print("Error in saving data")
        }
       
    }
    func loadData(){
        let request:NSFetchRequest<Item> = Item.fetchRequest()
        let predicate = NSPredicate(format: "parentCategory.name MATCHES %@",selectedCategory!.name!)
        request.predicate = predicate
        do{
            expanse = try context.fetch(request)
        }catch{
            print("Error in loading Data \(error)")
        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        let alert  = UIAlertController(title: "add new item in expense", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "add Item", style: .default){(action) in
            
            if let a = textfield.text{
                let newItem = Item(context: self.context)
                newItem.title = a
                newItem.parentCategory = self.selectedCategory!
                self.expanse.append(newItem)
            }
            
            self.saveData()
            self.tableView.reloadData()
            
        }
        alert.addTextField{(field) in
            field.placeholder = "add new item in expanses"
            textfield = field
            print(field.text!) //nothing printed here
            
        }
        alert.addAction(action)
        present(alert,animated: true)
        
    }
    
    
}


