//
//  CategoryViewController.swift
//  Todoit
//
//  Created by Paolo Bernardo on 6/08/18.
//  Copyright © 2018 Paolo Bernardo. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework




class CategoryViewController: SwipeTableViewController{

    let realm = try! Realm()
    var categories : Results<Category>?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()
        tableView.separatorStyle = .none
    }
    
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let category = categories?[indexPath.row]{
            cell.textLabel?.text = category.name
            guard let categoryColour = UIColor(hexString: category.colour) else {fatalError()}
            cell.backgroundColor = categoryColour
            cell.textLabel?.textColor = ContrastColorOf(categoryColour, returnFlat: true)
        }

        return cell
    }

    
    //MARK: - Data Manipulation Methods
    
    func save(category: Category){
        do{
            try realm.write{
                realm.add(category)
            }
        }catch{
            print("Error saving category")
        }
        
        self.tableView.reloadData()
    }
    
    
    func loadCategory(){
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    
    //MARK: - Delete Data From Swipe
    
    override func updateModel(at indexPath: IndexPath) {
        if let categoryForDeletion = self.categories?[indexPath.row]{
            do{
                try realm.write{
                    self.realm.delete(categoryForDeletion)
                }
            }catch{
                print("Error deleting category")
            }
        }
    }
    
    
    //MARK: Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default){
            (action) in
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.colour = RandomFlatColor().hexValue()
            self.save(category: newCategory)
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    
}












