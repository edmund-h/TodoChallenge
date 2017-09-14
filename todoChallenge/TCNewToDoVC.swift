//
//  TCNewToDoVC.swift
//  todoChallenge
//
//  Created by Edmund Holderbaum on 9/13/17.
//  Copyright © 2017 Bozo Design Labs. All rights reserved.
//

import UIKit

class TCNewToDoVC: UIViewController {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var descriptionField: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.delegate = self
        descriptionField.delegate = self
        titleField.returnKeyType = .done
        descriptionField.returnKeyType = .done
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createPressed(_ sender: UIButton) {
        if let title = titleField.text{
            let newToDo = TCToDo()
            newToDo.title = title
            newToDo.dateDue = datePicker.date
            newToDo.content = descriptionField.text
            newToDo.dateAdded = Date()
            newToDo.done = false
            
            TCToDo.realmAdd(newToDo)
        }
        let getNew = NSNotification.Name(rawValue: "GetNewData")
        NotificationCenter.default.post(name: getNew, object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func doneKeyTapped(_ sender: UITextField) {
        sender.resignFirstResponder()
    }

}

extension TCNewToDoVC: UITextViewDelegate {
    //MARK: UITextViewDelegate
    //manages actions taking place in the textView
    
    
}

extension TCNewToDoVC: UITextFieldDelegate {
    //MARK: UITextFieldDelegate
    //manages actions taking place in the textField
    
}
