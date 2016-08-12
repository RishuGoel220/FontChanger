//
//  ViewController.swift
//  Font Changer
//
//  Created by Rishu Goel on 10/08/16.
//  Copyright © 2016 Rishu Goel. All rights reserved.
//

import UIKit





protocol UIlabeldelegate: class {
    // The following command (ie, method) must be obeyed by any
    // underling (ie, delegate) of the older sibling.
    func setfonts(label : UILabel, fontstring : String, fontsize : CGFloat)
    func labelset(label : UILabel, text : String)
}

class labelDelegate: UIlabeldelegate{
    func setfonts(label : UILabel, fontstring : String, fontsize : CGFloat) {
        label.font = UIFont(name: fontstring, size: fontsize)
    }
    func labelset(label : UILabel, text : String){
        label.text = text
    }
    
}

class ViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var Label1: UILabel!
    @IBOutlet weak var Label2: UILabel!
    @IBOutlet weak var Label4: UILabel!
    @IBOutlet weak var Label5: UILabel!
    @IBOutlet weak var Label3: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    weak var delegate: UIlabeldelegate?
    let labeldelegator = labelDelegate()
    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?
    
    @IBAction func textChanged(sender: AnyObject) {
        delegate?.labelset(Label1, text: textField.text!)
        delegate?.labelset(Label2, text: textField.text!)
        delegate?.labelset(Label3, text: textField.text!)
        delegate?.labelset(Label4, text: textField.text!)
        delegate?.labelset(Label5, text: textField.text!)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = labeldelegator
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(self.keyboardNotification(_:)),
                                                         name: UIKeyboardWillChangeFrameNotification,
                                                         object: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue()
            let duration:NSTimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.unsignedLongValue ?? UIViewAnimationOptions.CurveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            if endFrame?.origin.y >= UIScreen.mainScreen().bounds.size.height {
                self.keyboardHeightLayoutConstraint?.constant = 0.0
            } else {
                self.keyboardHeightLayoutConstraint?.constant = endFrame?.size.height ?? 0.0
            }
            UIView.animateWithDuration(duration,
                                       delay: NSTimeInterval(0),
                                       options: animationCurve,
                                       animations: { self.view.layoutIfNeeded() },
                                       completion: nil)
        }
    }
    override func viewDidLayoutSubviews(){delegate?.setfonts(Label1, fontstring: "Avenir-Light", fontsize: 15.0)
        delegate?.setfonts(Label2, fontstring: "ArialMT", fontsize: 25.0)
        delegate?.setfonts(Label3, fontstring: "Helvetica-Neue", fontsize: 5.0)
        delegate?.setfonts(Label4, fontstring: "Georgia", fontsize: 35.0)
        delegate?.setfonts(Label5, fontstring: "Copperplate Light", fontsize: 10.0)
    }


}

