//
//  LatestToDoTaskViewController.swift
//  ProductivityApp
//
//  Created by Raluca Tudor on 09.04.2022.
//

import UIKit
import CoreData

class LatestToDoTaskViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        getLatestToDoTaskItem()
    }

    // Core Data

    func getLatestToDoTaskItem() {
        
        do {
            let request = ToDoListItem.fetchRequest() as NSFetchRequest<ToDoListItem>
            
            // Set the sorting on the request
            let sort = NSSortDescriptor(key: "createdAtDate", ascending: false)
            request.sortDescriptors = [sort]
            
            let items = try context.fetch(request)
            // TODO if items count is 0
            let latestItem = items[0]
            
            DispatchQueue.main.async {
                let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 21))
                label.center = CGPoint(x: 160, y: 285)
                label.textAlignment = .center
                label.text = "The latest task is " + latestItem.name!

                self.view.addSubview(label)
            }
        }
        catch {
            // TODO handle error
        }
    }
}
