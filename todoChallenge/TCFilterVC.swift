//
//  TCFilterVC.swift
//  todoChallenge
//
//  Created by Edmund Holderbaum on 9/13/17.
//  Copyright © 2017 Bozo Design Labs. All rights reserved.
//

import UIKit

class TCFilterVC: UIViewController {

    @IBOutlet weak var titleFilterField: UITextField!
    @IBOutlet weak var dateCreatedFilterField: UITextField!
    @IBOutlet weak var dateDueFilterField: UITextField!
    @IBOutlet weak var descriptionFilterField: UITextField!
    @IBOutlet weak var doneSwitch: UISwitch!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var filterButton: UIButton!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var pickerContainerHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerContainerHeight.constant = 0
        // Do any additional setup after loading the view.
        
        doneSwitch.isHidden = true
        doneSwitch.isUserInteractionEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func pickerDone(_ sender: Any) {
        // I built this weird system to determine which date we are editing
        if !dateCreatedFilterField.isUserInteractionEnabled {
            dateCreatedFilterField.text = TCCalendarDay.dateFormatter.string(from: datePicker.date)
        } else if !dateDueFilterField.isUserInteractionEnabled {
            dateDueFilterField.text = TCCalendarDay.dateFormatter.string(from: datePicker.date)
        }
        
        //put away date picker area
        cancelButton.isEnabled = true
        filterButton.isEnabled = true
        pickerContainerHeight.constant = 0
        UIView.animate(withDuration: 0.4, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    @IBAction func clearAllPressed(_ sender: UIButton) {
        titleFilterField.text = nil
        dateCreatedFilterField.text = nil
        dateDueFilterField.text = nil
        descriptionFilterField.text = nil
        doneSwitch.isOn = false
    }
    
    
    @IBAction func CancelPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func FilterPressed(_ sender: UIButton) {
        
        var filter: ToDoFilter = [:]
        //assemble filter parameters based on fields
        if let text = titleFilterField.text, text != "" {
            filter[.title] = text
        }
        
        if let text = dateCreatedFilterField.text, text != "" {
            filter[.dateAdded] = text
        }
        
        if let text = dateDueFilterField.text, text != "" {
            filter[.dateDue] = text
        }
        
        if let text = descriptionFilterField.text, text != "" {
            filter[.content] = text
        }
        
        filter[.done] = doneSwitch.isOn
        
        let getNew = NSNotification.Name(rawValue: "GetNewData")
        NotificationCenter.default.post(name: getNew, object: nil, userInfo: ["filter": filter])
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func titleDone(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func contentDone(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
}

extension TCFilterVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == dateDueFilterField || textField == dateCreatedFilterField {
            
            //these text fields will bring out the date picker instead of keyboard.
            cancelButton.isEnabled = false
            filterButton.isEnabled = false
            textField.isUserInteractionEnabled = false
            
            pickerContainerHeight.constant = 197
            UIView.animate(withDuration: 0.4, animations: {
                self.view.layoutIfNeeded()
            })
            return false
        }
        textField.returnKeyType = .done
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        textField.resignFirstResponder()
    }
}


