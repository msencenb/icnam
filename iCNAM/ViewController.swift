//
//  ViewController.swift
//  iCNAM
//
//  Created by Corey Edwards on 8/13/15.
//  Copyright (c) 2015 Corey Edwards. All rights reserved.
//

import Cocoa
import AppKit

class ViewController: NSViewController {

    
    
    // Set up our Interface Builder connections
    @IBOutlet weak var Status: NSTextField!
    @IBOutlet weak var Phone: NSTextField!
    @IBOutlet weak var SearchButton: NSButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        Status.stringValue = "✅ Ready";
        println("iCNAM Ready");
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func SearchClick(sender: NSButton) {
        if (Phone.stringValue == ""){
            Status.stringValue = "❌ You didn't enter a phone number, doofus!"
            Phone.stringValue = "+15551234567";
        } else {
        Status.stringValue = "You entered " + Phone.stringValue;
        query(Phone.stringValue);
        }
    }

}