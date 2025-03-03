//
//  ViewController.swift
//  Expense Calculator
//
//  Created by viraj shah on 03/03/25.
//

import UIKit

class ExpenseViewController: UITableViewController {

    var expanse = ["Apple:300","Banana:400","Orange:500","Bus:600","TV:700","Books:500"]
    var selectedCategory:String?{
        didSet{
            print("hello",selectedCategory!)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expanse.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expenseCell",for:indexPath)
        cell.textLabel?.text = expanse[indexPath.row]
        return cell
    }

}

