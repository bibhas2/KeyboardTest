//
//  ViewController.swift
//  KeyboardTest
//
//  Created by Bibhas Bhattacharya on 11/5/15.
//  Copyright © 2015 Bibhas Bhattacharya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var anotherTextField: UITextField!
    @IBOutlet weak var textView: UITextField!
    var kbMgr : KeybardManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kbMgr = KeybardManager(
            root: self.view,
            textFields: [textView, anotherTextField])
    }
}

