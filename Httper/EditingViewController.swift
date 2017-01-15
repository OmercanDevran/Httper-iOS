//
//  EditingViewController.swift
//  Httper
//
//  Created by 李大爷的电脑 on 16/01/2017.
//  Copyright © 2017 limeng. All rights reserved.
//

import UIKit

class EditingViewController: UIViewController, UITextFieldDelegate {

    var editingTextField: UITextField!
    var shownHeight: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - UITextViewDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        editingTextField = textField
        let offset = keyboardHeight - (self.view.frame.size.height - shownHeight)
        if offset > 0 {
            UIView.animate(withDuration: 0.5, animations: {
                self.view.frame = CGRect(x: 0, y: -offset, width: self.view.frame.size.width, height: self.view.frame.size.height)
            })
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.isFirstResponder {
            textField.resignFirstResponder()
        }
        return true;
    }
    
    // MARK: - Service
    func finishEdit() {
        if editingTextField.isFirstResponder {
            editingTextField.resignFirstResponder()
        }
    }
}
