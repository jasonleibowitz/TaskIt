//
//  TaskModel.swift
//  TaskIt
//
//  Created by Jason Leibowitz on 12/24/14.
//  Copyright (c) 2014 Jason Leibowitz. All rights reserved.
//

import Foundation
import CoreData

@objc(TaskModel)
class TaskModel: NSManagedObject {

    @NSManaged var isCompleted: NSNumber
    @NSManaged var date: NSDate
    @NSManaged var subtask: String
    @NSManaged var task: String

}
