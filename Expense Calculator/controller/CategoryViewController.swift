//
//  CategoryViewController.swift
//  Expense Calculator
//
//  Created by viraj shah on 03/03/25.
//

import UIKit
import CoreData

class CategoryViewController:UITableViewController{
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    var category = ["Food","Travel","Education","Entertainment","Clothing"]
    var category = [Category]()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
//    MARK: - save and load methodes.
    func saveData(){
        do{
            try context.save()
        }catch{
            print("Erroring saving context\(error)")
        }
    }
    func loadData(){
        let request :NSFetchRequest<Category> = Category.fetchRequest()
        do{
            category = try context.fetch(request)
        }catch{
            print("Error in loading data \(error)")
        }
    }
    
//    MARK: - TableView Methodes.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell",for:indexPath)
        cell.textLabel?.text = category[indexPath.row].name
        return cell
    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toExpenses", sender: self)
 
//        rowno = indexPath.row   //this is not working....
    }
    
//    how to pass the selected category to the ExpenseViewController.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(segue.identifier!)
        let destinationVC = segue.destination as! ExpenseViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = category[indexPath.row]
//            destinationVC.selectedCategory = category[rowno!] //not working
//            updation is not instance.
        }
       
    }
    
//    MARK: - adding methodes
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
    
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default){(action) in
            
            //what will happen when user click on addITem button
            print(textField.text!)
            
            if let a = textField.text{
                let newItem = Category(context: self.context)
                newItem.name = a
                self.category.append(newItem)
            }
            self.saveData()
            
//            reloadData() call the datasource method again.
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add new item"
            textField = alertTextField
            print(alertTextField.text!) //nothing printed here
            
        }
        
        alert.addAction(action)
        present(alert, animated: true)
    }
    

}
