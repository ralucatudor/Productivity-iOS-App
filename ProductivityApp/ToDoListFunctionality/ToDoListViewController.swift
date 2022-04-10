//
//  ToDoListViewController.swift
//  ProductivityApp
//
//  Created by Raluca Tudor on 08.04.2022.
//

import UIKit

class ToDoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self,
                       forCellReuseIdentifier: "cell")
        return table
    }()
    
    private var models = [ToDoListItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do additional setup after loading the view.
        
        title = "To Do List"
        
        view.addSubview(tableView)
        
        // Call for getting all items in the to-do list, before setting up the table view.
        getAllToDoListItems()
        
        tableView.backgroundColor = UIColor("#6699ff")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(didTapAdd))
    }
    
    @objc private func didTapAdd() {
        let alert = UIAlertController(title: "New To-Do Item",
                                      message: "Enter new item to do:",
                                      preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: nil)
        
        // Add action to the alert.
        alert.addAction(
            UIAlertAction(title: "Submit",
                          style: .cancel,
                          handler: { [weak self] _ in
                            guard let field = alert.textFields?.first,
                                  let text = field.text,
                                  !text.isEmpty else {
                                return
                            }
            
            // if the text field is not empty, create item.
            // pay attention to possible memory leaks.
            self?.createToDoListItem(name: text)
        }))
        
        present(alert, animated: true)
    }
    
    // UI Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")

        let model = models[indexPath.row]
        
        cell.textLabel?.text = "\u{2022} " + model.name!
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        
        // Use `DateFormatter` to convert from Date to String.
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        cell.detailTextLabel?.text = "  Added at " + dateFormatter.string(from: model.createdAtDate!)
        cell.detailTextLabel?.textColor = .white
        cell.detailTextLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cellColors = ["#99bbff", "#80aaff"]

        cell.contentView.backgroundColor = UIColor(cellColors[indexPath.row % cellColors.count])
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Get the selected item.
        let selectedItem = models[indexPath.row]
        
        let sheet = UIAlertController(title: selectedItem.name,
                                      message: nil,
                                      preferredStyle: .actionSheet)
        
        // Add action to the sheet.
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        sheet.addAction(UIAlertAction(title: "Edit", style: .default, handler: { _ in
            let alert = UIAlertController(title: "Edit To-Do Item",
                                          message: "Edit your item:",
                                          preferredStyle: .alert)
            
            alert.addTextField(configurationHandler: nil)
            // Pre-fill the item name before edit.
            alert.textFields!.first?.text = selectedItem.name
            
            // Add action to the alert.
            alert.addAction(UIAlertAction(title: "Save", style: .cancel, handler: { [weak self] _ in
                guard let field = alert.textFields?.first, let newName = field.text, !newName.isEmpty else {
                    return
                }
                
                // if the text field is not empty, create item.
                // pay attention to possible memory leaks.
                self?.updateToDoListItem(toDoListItem: selectedItem, newName: newName)
            }))
            
            self.present(alert, animated: true)
        }))
        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            self?.deleteToDoListItem(toDoListItem: selectedItem)
        }))
        
        present(sheet, animated: true)
    }
    
    // Core Data related functions:

    func getAllToDoListItems() {
        do {
            // Assign the result to the global variable models.
            models = try context.fetch(ToDoListItem.fetchRequest())
            // Call reload on the table view in the UI,
            // while making sure the reload is done on the main thread.
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch {
            print("Getting all to-do items failed with error: \(error)")
        }
    }
    
    func createToDoListItem(name: String) {
        let newToDoListItem = ToDoListItem(context: context)
        // Assign the properties of the item.
        newToDoListItem.name = name
        newToDoListItem.createdAtDate = Date()
        // Save the item to the database.
        do {
            try context.save()
            // Refresh the `models` and reload the table view in UI.
            getAllToDoListItems()
        }
        catch {
            print("Creating to-do item failed with error: \(error)")
        }
    }
    
    func deleteToDoListItem(toDoListItem: ToDoListItem) {
        context.delete(toDoListItem)
        do {
            try context.save()
            // Refresh the `models` and reload the table view in UI.
            getAllToDoListItems()
        }
        catch {
            print("Deleting to-do item failed with error: \(error)")
        }
    }
    
    func updateToDoListItem(toDoListItem: ToDoListItem,
                            newName: String) {
        toDoListItem.name = newName
        do {
            try context.save()
            // Refresh the `models` and reload the table view in UI.
            getAllToDoListItems()
        }
        catch {
            print("Updating to-do item failed with error: \(error)")
        }
    }
    
}

