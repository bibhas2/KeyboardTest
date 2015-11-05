//
//  KeyboardManager.swift
//  KeyboardTest
//
//  Created by Bibhas Bhattacharya on 11/5/15.
//  Copyright © 2015 Bibhas Bhattacharya. All rights reserved.
//

import Foundation
import UIKit

/**
This class implements various common features of keyboard handling:
 
- Move a text box that will be obscured by an open keyboard.
- Move a text box only slightly above the keyboard.
- Hide keyboard when user taps anywhere on screen that can't take focus.
*/
class KeybardManager : NSObject {
    var rootView : UIView
    var textFields : [UIView]
    /**
     This initializer registers the keybaord manager for various notification events.
     
     - Parameter root: The root view of the view controller using this keyboard manager.
     - Parameter textFields: An array of UIView that upon receiving focus will open the keybaord.
    */
    init(root : UIView, textFields: [UIView]) {
        self.rootView = root
        self.textFields = textFields
        
        super.init()
        
        let dismiss: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: "dismissKeyboard")
        
        rootView.addGestureRecognizer(dismiss)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: Selector("keyboardWillShow:"),
            name:UIKeyboardWillShowNotification,
            object: rootView.window)
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: Selector("keyboardWillHide:"),
            name:UIKeyboardWillHideNotification,
            object: rootView.window)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func dismissKeyboard(){
        rootView.endEditing(true)
    }
    
    func keyboardWillHide(sender: NSNotification) {
        UIView.animateWithDuration(0.1, animations: {
            self.rootView.frame.origin.y = 0
        })
    }
    
    func keyboardWillShow(sender: NSNotification) {
        let userInfo: [NSObject : AnyObject] = sender.userInfo!
        let keyboardEndSize: CGSize = userInfo[UIKeyboardFrameEndUserInfoKey]!.CGRectValue.size
        let GAP : CGFloat = 5.0
        
        //Find out which text field has focus
        var viewWithFocus : UIView?
        
        for view in textFields {
            if view.isFirstResponder() {
                viewWithFocus = view
                
                break;
            }
        }
        
        let textBottomY = viewWithFocus!.frame.origin.y + viewWithFocus!.frame.size.height
        let shiftY = keyboardEndSize.height + GAP - (rootView.frame.size.height - textBottomY - rootView.frame.origin.y)
        
        //Do we need to move the text box above the keyboard?
        if shiftY > 0 {
            UIView.animateWithDuration(0.1, animations: {
                self.rootView.frame.origin.y = -(shiftY)
            })
        }
    }
}