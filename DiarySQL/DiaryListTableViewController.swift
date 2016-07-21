//
//  DiaryListTableViewController.swift
//  DiarySQL
//
//  Created by Matt Milner on 7/20/16.
//  Copyright © 2016 Matt Milner. All rights reserved.
//

import UIKit
import CoreData

class DiaryListTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, AddEntryDelegate {
    
    var managedObjectContext: NSManagedObjectContext!
    
    var fetchedResultsController: NSFetchedResultsController!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let fetchRequest = NSFetchRequest(entityName: "DiaryEntry")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        self.fetchedResultsController.delegate = self
        
        try! self.fetchedResultsController.performFetch()

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let addEntryController = segue.destinationViewController as? AddEntryViewController
        addEntryController!.delegate = self
        
    }
    
    
    func entryWasAdded(entryName: String!, entryText: String!) {
        
        let diaryEntry = NSEntityDescription.insertNewObjectForEntityForName("DiaryEntry", inManagedObjectContext: self.managedObjectContext)
        
        diaryEntry.setValue(entryName, forKey: "title")
        diaryEntry.setValue(entryText, forKey: "entryText")
        
        try! self.managedObjectContext.save()

    }
    
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        switch(type){
            
        case .Insert:
            self.tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Automatic)
            break
            
        default:
            break
            
        }

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let sections = self.fetchedResultsController.sections else {
            fatalError("Sections not found")
        }
        return sections[section].numberOfObjects
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let diaryEntry = self.fetchedResultsController.objectAtIndexPath(indexPath)
        
        cell.textLabel?.text = diaryEntry.valueForKey("title") as? String
        
        cell.detailTextLabel?.text = diaryEntry.valueForKey("entryText") as? String
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            let entryData: NSManagedObject = self.fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject

            self.managedObjectContext.deleteObject(entryData)
            
            try! self.managedObjectContext.save()
            
            self.tableView.reloadData()
        }
    }

}
