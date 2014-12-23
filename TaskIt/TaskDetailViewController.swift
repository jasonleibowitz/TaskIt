//
//  TaskDetailViewController.swift
//  TaskIt
//
//  Created by Jason Leibowitz on 12/21/14.
//  Copyright (c) 2014 Jason Leibowitz. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    var mainVC:ViewController!
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subtaskTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    

    // gain access to upcoming model in this view controller here
    var detailTaskModel: TaskModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        taskTextField.text = detailTaskModel.task
        subtaskTextField.text = detailTaskModel.subTask
        dueDatePicker.date = detailTaskModel.date
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    @IBAction func doneButtonTapped(sender: UIBarButtonItem) {
        var task = TaskModel(task: taskTextField.text, subTask: subtaskTextField.text, date: dueDatePicker.date, isCompleted: false)
        
        // update item in array
        mainVC.baseArray[0][mainVC.tableView.indexPathForSelectedRow()!.row] = task
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    

}
