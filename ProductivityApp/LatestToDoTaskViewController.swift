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
    let shape = CAShapeLayer()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Your latest task"
        label.font = .systemFont(ofSize: 30, weight: .light)
        label.textColor = .white
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getLatestToDoTaskItem()
        
        label.sizeToFit()
        view.addSubview(label)
        label.center = view.center
        
        let cirlePath = UIBezierPath(arcCenter: view.center,
                                     radius: 150,
                                     startAngle: -(.pi / 2),
                                     endAngle: .pi * 2,
                                     clockwise: true)
        let trackShape = CAShapeLayer()
        trackShape.path = cirlePath.cgPath
        trackShape.fillColor = UIColor.clear.cgColor
        trackShape.lineWidth = 15
        trackShape.strokeColor = UIColor.lightGray.cgColor
        view.layer.addSublayer(trackShape)
        
        shape.path = cirlePath.cgPath
        shape.lineWidth = 15
        shape.strokeColor = UIColor.blue.cgColor
        shape.fillColor = UIColor.clear.cgColor
        shape.strokeEnd = 0
        view.layer.addSublayer(shape)
        
        animate()
    }
    
    @objc func animate() {
        // Animate
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = 3
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        shape.add(animation, forKey: "animation")
    }

    // Core Data

    func getLatestToDoTaskItem() {
        
        do {
            let request = ToDoListItem.fetchRequest() as NSFetchRequest<ToDoListItem>
            
            // Set the sorting on the request
            let sort = NSSortDescriptor(key: "createdAtDate", ascending: false)
            request.sortDescriptors = [sort]
            
            let items = try context.fetch(request)

            var textToAdd: String
            if items.count == 0 {
                textToAdd = "Oops! There are no to-do items!"
            } else {
                textToAdd = "\"" + items[0].name! + "\""
            }
            
            DispatchQueue.main.async {
                let label = UILabel(
                    frame: CGRect(x: 0,
                                  y: self.view.frame.size.height-200-self.view.safeAreaInsets.bottom,
                                  width: self.view.frame.size.width,
                                  height: 50))
             
                label.textAlignment = .center
                label.text = textToAdd
                label.font = .systemFont(ofSize: 30, weight: .light)
                label.textColor = .white

                self.view.addSubview(label)
            }
        }
        catch {
            // TODO handle error
        }
    }
}
