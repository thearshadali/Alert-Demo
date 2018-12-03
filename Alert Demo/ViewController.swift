//
//  ViewController.swift
//  Alert Demo
//
//  Created by Arshad Ali on 02/12/18.
//  Copyright © 2018 Arshad Ali. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func buttonAction(_ sender: Any) {
//        presentAlert()
        alertWithTextField()
        
    }
    
    func presentAlert(){
        let alertController = UIAlertController(title: "title!", message: """
Do you really want to do this \
desctructive things?
"""
            , preferredStyle: .alert)
        
        // internal function
        func handler(action: UIAlertAction!){
            print("User tapped \(action.title as Any)")
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: handler))
        alertController.addAction(UIAlertAction(title: "Just do it", style: .destructive, handler: handler))
        alertController.addAction(UIAlertAction(title: "May be", style: .default, handler: handler))
        present(alertController, animated: true, completion: nil)
        
        // if action is more that two then they will appear as a list ..if one/two action button they will apper side by side
 
    }
    func alertWithTextField(){
       let alertController = UIAlertController(title: "Enter a number", message: nil, preferredStyle: .alert)
        alertController.addTextField { (tf: UITextField) in
            tf.keyboardType = .numberPad
            tf.addTarget(self, action: #selector(self.textChanged), for: .editingChanged)
//            tf.delegate = self   // run your code and without entering any text in textfield press return(enter key) of your mac you will see our alert dismiss .. you are using delegate to fix this bug
        }
        
        // inner function
        func handler(_ ac : UIAlertAction){
            let tf = alertController.textFields![0]
            print(tf.text ?? "no text in textfield")
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))  // handler parameter is removed bcz handler parameter has default value nil .. if a parameter has default value you can remove it from function during function call
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: handler))
        alertController.actions[1].isEnabled = false
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func textChanged(_ sender: Any){
        let tf = sender as! UITextField
        var responder: UIResponder! = tf
        
        while !(responder is UIAlertController) {
            responder = responder.next
        }
        let alertcontroller = responder as! UIAlertController
        alertcontroller.actions[1].isEnabled = (tf.text != "")
        
    }
  
    
}

extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.text != "" // Bool
    }
}

