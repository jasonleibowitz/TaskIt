//
//  AddTaskViewController.swift
//  TaskIt
//
//  Created by Jason Leibowitz on 12/22/14.
//  Copyright (c) 2014 Jason Leibowitz. All rights reserved.
//

import UIKit
import CoreData

class AddTaskViewController: UIViewController {
    
    // pass the instance of our view controller to our add task view controller to have access to it. Set in prepare for segue.
    var mainVC: ViewController!
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subtaskTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonTapped(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func addTaskButtonTapped(sender: UIButton) {
        // get access to app delegate. UIApplication is entire app.
        let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        let managedObjectConext = appDelegate.managedObjectContext
        // Entity Description allows us to map an entity to our persistant store. Allows us to create our TaskModel.
        let entityDescription = NSEntityDescription.entityForName("TaskModel", inManagedObjectContext: managedObjectConext!)
        // Create task model instance
        let task = TaskModel(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectConext!)
        
        // set attributes on instance like before
        task.task = taskTextField.text
        task.subtask = subtaskTextField.text
        task.date = dueDatePicker.date
        task.isCompleted = false
        
        // save changes to core data
        appDelegate.saveContext()
        
        // request instances of task model
        var request = NSFetchRequest(entityName: "TaskModel")
        // optional error instance, intially set to nil
        var error: NSError? = nil
        // results of fetch is an ObjC array. execute fetch request could be nil, so it's an optional. 
        var results:NSArray = managedObjectConext!.executeFetchRequest(request, error: &error)!
        
        // loop over results and do something
        for res in results {
            println(res)
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
