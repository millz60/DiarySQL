//
//  AddEntryViewController.swift
//  DiarySQL
//
//  Created by Matt Milner on 7/20/16.
//  Copyright © 2016 Matt Milner. All rights reserved.
//

import UIKit

protocol AddEntryDelegate {
    func entryWasAdded(entryName: String!, entryText: String!)
}

class AddEntryViewController: UIViewController {
    
    @IBOutlet weak var entryName: UITextField!
    @IBOutlet weak var entryText: UITextField!
    var delegate: AddEntryDelegate!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func cancelButtonPressed(){
        
        
        self.dismissViewControllerAnimated(true, completion: {});
        
    }
    
    @IBAction func saveButtonPressed(){
        
        self.delegate.entryWasAdded(self.entryName.text, entryText: self.entryText.text)
        self.dismissViewControllerAnimated(true, completion: {});
        
    }
    
    
    
    
    
    
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
