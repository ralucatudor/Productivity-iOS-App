//
//  ToDoListItem+CoreDataProperties.swift
//  ProductivityApp
//
//  Created by Raluca Tudor on 07.04.2022.
//
//

import Foundation
import CoreData


extension ToDoListItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoListItem> {
        return NSFetchRequest<ToDoListItem>(entityName: "ToDoListItem")
    }
    
    @NSManaged public var name: String?
    @NSManaged public var createdAtDate: Date?

}

extension ToDoListItem : Identifiable {

}
