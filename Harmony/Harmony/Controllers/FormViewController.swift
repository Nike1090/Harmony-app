//
//  FormViewController.swift
//  Harmony
//
//  Created by Karicharla sricharan on 12/15/23.
//

import UIKit

class FormViewController: UIViewController {

    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var textField4: UITextField!
    @IBOutlet weak var textField5: UITextField!
    @IBOutlet weak var textField6: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveForm(_ sender: Any) {
        guard let text1 = textField1.text, !text1.isEmpty,
                      let text2 = textField2.text, !text2.isEmpty,
                      let text3 = textField3.text, !text3.isEmpty,
                      let text4 = textField4.text, !text4.isEmpty,
                      let text5 = textField5.text, !text5.isEmpty,
                      let text6 = textField6.text, !text6.isEmpty else {
            Helper.showAlert(from: self,with: "Fill all fields")
                    return
                }
        let db = DataStorageManager.shared
                do {
                    try db.insertForm(textField1: text1, textField2: text2, textField3: text3, textField4: text4, textField5: text5, textField6: text6)
                    Helper.showAlert(from:self, with: "Form saved successfully")
                } catch {
                    print("Error saving form: \(error)")
                    Helper.showAlert(from: self, with: "Failed to save form")
                }
    }
    
  
}
