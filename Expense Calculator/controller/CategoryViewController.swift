//
//  CategoryViewController.swift
//  Expense Calculator
//
//  Created by viraj shah on 03/03/25.
//

import UIKit

class CategoryViewController:UITableViewController{
    var category = ["Food","Travel","Education","Entertainment","Clothing"]
    var rowno:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Hello")
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell",for:indexPath)
        cell.textLabel?.text = category[indexPath.row]
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
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let destinationVc = segue.destination as! ExpenseViewController
//        if let indexPath = tableView.indexPathForSelectedRow{
//            destinationVc.selectedCategory = category[indexPath.row]  // passing value to variable
//        }
//    }

}
