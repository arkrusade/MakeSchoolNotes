//
//  DisplayNoteViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit
import RealmSwift

class DisplayNoteViewController: UIViewController {
    var note: Note?
    @IBOutlet weak var noteTitleTextField: UITextField!
    @IBOutlet weak var noteContentTextView: UITextView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // 1
        if let note = note{
            noteTitleTextField.text = note.title
            noteContentTextView.text = note.content
        }
        else
        {
            noteTitleTextField.text = ""
            noteContentTextView.text = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let listNotesTableViewController = segue.destinationViewController as! ListNotesTableViewController
        
        if let identifier = segue.identifier {
            if identifier == "Cancel" {
                print("Cancel button tapped")
            }
            else if identifier == "Save" {
                print("Save button tapped")
                
                if let note = note{
                    let newNote = note
                    newNote.title = noteTitleTextField.text ?? ""
                    newNote.content = noteContentTextView.text ?? ""
                    RealmHelper.updateNote(note, newNote: newNote)
                    
                }
                else{
                    let note = Note()
                    note.title = noteTitleTextField.text ?? ""
                    note.content = noteContentTextView.text
                    note.modificationTime = NSDate()
                    RealmHelper.addNote(note)

                    listNotesTableViewController.notes = RealmHelper.retrieveNotes()
                }
                
                
                
                
            }
        }
    }
}

