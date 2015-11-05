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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let dismiss: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: "dismissKeyboard")
        
        view.addGestureRecognizer(dismiss)

        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: Selector("keyboardWillShow:"),
            name:UIKeyboardWillShowNotification,
            object: self.view.window)
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: Selector("keyboardWillHide:"),
            name:UIKeyboardWillHideNotification,
            object: self.view.window)
    }

    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func keyboardWillHide(sender: NSNotification) {
        UIView.animateWithDuration(0.1, animations: {
            self.view.frame.origin.y = 0
        })
    }
    
    func keyboardWillShow(sender: NSNotification) {
        let userInfo: [NSObject : AnyObject] = sender.userInfo!
        let allTextFields = [textView, anotherTextField]
        let keyboardEndSize: CGSize = userInfo[UIKeyboardFrameEndUserInfoKey]!.CGRectValue.size
        let GAP : CGFloat = 5.0
        
        //Find out which text field has focus
        var viewWithFocus : UIView?
        
        for view in allTextFields {
            if view.isFirstResponder() {
                viewWithFocus = view
                
                break;
            }
        }
        
        let textBottomY = viewWithFocus!.frame.origin.y + viewWithFocus!.frame.size.height
        let shiftY = keyboardEndSize.height + GAP - (self.view.frame.size.height - textBottomY - self.view.frame.origin.y)
        
        //Do we need to move the text box above the keyboard?
        if shiftY > 0 {
            UIView.animateWithDuration(0.1, animations: {
                self.view.frame.origin.y = -(shiftY)
            })
        }
    }
}

