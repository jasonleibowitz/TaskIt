//
//  ViewController.swift
//  TaskIt
//
//  Created by Jason Leibowitz on 12/21/14.
//  Copyright (c) 2014 Jason Leibowitz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var baseArray:[[TaskModel]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let date1 = Date.from(year: 2014, month: 05, day: 20)
        let date2 = Date.from(year: 2014, month: 03, day: 3)
        let date3 = Date.from(year: 2014, month: 12, day: 13)
        
        tableView.tableFooterView = UIView()
        let task1 = TaskModel(task: "Study French", subTask: "Verbs", date: date1, isCompleted: false)
        let task2 = TaskModel(task: "Eat Dinner", subTask: "Burgers", date: date2, isCompleted: false)
        
        let taskArray = [task1, task2, TaskModel(task: "Gym", subTask: "Leg Day", date: date3, isCompleted: false)]
        let completedArray = [TaskModel(task: "Code", subTask: "Task Project", date: date2, isCompleted: true)]
        
        baseArray = [taskArray, completedArray]
        
        // Refreshes data in table view - will recall both UITableView functions. If taskArray changed, it'll refresh info in these functions for us.
        self.tableView.reloadData()
    }
    
    // called everytime this view controller is presented on the screen as the main view controller. 
    // view did load only called first time view loaded up. this function called everytime this view comes up.
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // Defining function inside of a function
        
//        func sortByDate(taskOne:TaskModel, taskTwo:TaskModel) -> Bool {
//            // convert both dates into numbers then evaluate comparison of values
//            return taskOne.date.timeIntervalSince1970 < taskTwo.date.timeIntervalSince1970
//        }
//        taskArray = taskArray.sorted(sortByDate)
        
        // refactor the above with a closure
        
        baseArray[0] = baseArray[0].sorted {
            (taskOne:TaskModel, taskTwo:TaskModel) -> Bool in
            // comparison logic here
            return taskOne.date.timeIntervalSince1970 < taskTwo.date.timeIntervalSince1970
        }
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // called right before new view controller presented on screen
        
        if segue.identifier == "showTaskDetail" {
            let detailVC: TaskDetailViewController = segue.destinationViewController as TaskDetailViewController
            // tells us which indexPath was currently selected in our tableView. Gain access to cell.
            let indexPath = self.tableView.indexPathForSelectedRow()
            let thisTask = baseArray[indexPath!.section][indexPath!.row]
            detailVC.detailTaskModel = thisTask
            detailVC.mainVC = self
            
            // alternative
            // let indexPath = sender as NSIndexPath
        }
        else if segue.identifier == "showTaskAdd" {
            let addTaskVC:AddTaskViewController = segue.destinationViewController as AddTaskViewController
            addTaskVC.mainVC = self
        }
    }
    
    @IBAction func addButtonTapped(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("showTaskAdd", sender: self)
    }
    
    
    // UITableViewDataSource
    
    // number of sections equal to number of arrays in base arrays
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return baseArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // allows us to access table view currently being set up via tableView param, and get number of rows in section via param.
        return baseArray[section].count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // dequeReusableCellWithIdentifier will return reusuable cell that is specific in storyboard as myCell.
        // reusable cell is a cell that can be used over and over again just by updating info in cell. Leads to efficient way of creating cells.
        
        let thisTask = baseArray[indexPath.section][indexPath.row]
        
        var cell: TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell") as TaskCell
        
        cell.taskLabel.text = thisTask.task
        cell.descriptionLabel.text = thisTask.subTask
        cell.dateLabel.text = Date.toString(date: thisTask.date)
        
        return cell
    }
    
    // UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // will run every time we select a cell
        println(indexPath.row)
        
        performSegueWithIdentifier("showTaskDetail", sender: self)
    }
    
    // set height for header in each section to be 25pt. won't display info though.
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "To Do"
        } else {
            return "Completed"
        }
    }
    
    // adds ability to add swipe, and says what happens when user does swipe
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let thisTask = baseArray[indexPath.section][indexPath.row]
        
        if indexPath.section == 0 {
            // everything is the same as thisTask except isCompleted
            var newTask = TaskModel(task: thisTask.task, subTask: thisTask.subTask, date: thisTask.date, isCompleted: true)
            baseArray[1].append(newTask)
        } else {
            var newTask = TaskModel(task: thisTask.task, subTask: thisTask.subTask, date: thisTask.date, isCompleted: false)
            baseArray[0].append(newTask)
        }
        baseArray[indexPath.section].removeAtIndex(indexPath.row)
        tableView.reloadData()
    }


}

