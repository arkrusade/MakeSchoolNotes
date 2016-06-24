//
//  ListNotesTableViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit
import RealmSwift

class ListNotesTableViewController: UITableViewController {
    var notes = Results<Note>!() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            RealmHelper.deleteNote(notes[indexPath.row])
            //2
            notes = RealmHelper.retrieveNotes().sorted("modificationTime", ascending: false)
        }
    }
    
    @IBAction func unwindToListNotesViewController(segue: UIStoryboardSegue) {
        
        // for now, simply defining the method is sufficient.
        // we'll add code later
        
    }
    @IBAction func unwindAndDeleteListNotesViewController(segue: UIStoryboardSegue) {
        print("hi")
        for note in notes{
            RealmHelper.deleteNote(note)
        }
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notes = RealmHelper.retrieveNotes().sorted("modificationTime", ascending: false)
        tableView.reloadData()

    }
    // 1
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    // 2
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        /// returns note that user touched
        let cell = tableView.dequeueReusableCellWithIdentifier("listNotesTableViewCell", forIndexPath: indexPath) as! ListNotesTableViewCell
        let row = indexPath.row
        let note = notes[row]
        cell.noteTitleLabel.text = note.title
        cell.noteModificationTimeLabel.text = note.modificationTime.convertToString()
        cell.truncatedNoteContentLabel.text = note.content
        
        
        return cell
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // segues if user touched display or add
        if let identifier = segue.identifier {
            // 2
            if identifier == "displayNote" {
                // 3
                print("Transitioning to the Display Note View Controller")
                let indexPath = tableView.indexPathForSelectedRow!
                let note = notes[indexPath.row]
                let displayNoteViewController = segue.destinationViewController as! DisplayNoteViewController
                displayNoteViewController.note = note
                
            }
            if identifier == "addNote" {
                // 3
                print("Adding note, transitioning to the Display Note View Controller")
            }
        }
    }
}