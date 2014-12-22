//
//  TaskDetailViewController.swift
//  TaskIt
//
//  Created by Jason Leibowitz on 12/21/14.
//  Copyright (c) 2014 Jason Leibowitz. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
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

}
