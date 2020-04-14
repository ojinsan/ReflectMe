//
//  OnboardingVC.swift
//  ReflectMe
//
//  Created by Nixi Sendya Putri on 07/04/20.
//  Copyright © 2020 Group 11 - Apple Developer Academy. All rights reserved.
//

import UIKit

class OnboardingVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var scrollviewOnboard: UIScrollView!
    
    var userName: String = ""
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: HIDE KEYBOARD WHEN TAPPING ON SCREEN
        let tapOnScreen: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        tapOnScreen.cancelsTouchesInView = false

        view.addGestureRecognizer(tapOnScreen)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.isNavigationBarHidden = true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollviewOnboard.setContentOffset(CGPoint(x: 0, y: 150), animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollviewOnboard.setContentOffset(CGPoint(x:0, y:0), animated: true)
    }

    
    @IBAction func startButtonTapped(_ sender: Any) {
        
        validateName()
        
        let df = DateFormatter()
        df.dateFormat = "MMM d, yyyy"
        let dateJoined = df.string(from: Date())
        
        let user = User(username: userName, dateJoined: dateJoined, badges: [])
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "savedUser")
        }

    }
    
    func validateName() {
        
        if textFieldName.text == "" {
            let alert = UIAlertController(title: "Uh Oh!", message: "Name cannot be empty", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            userName = textFieldName.text!
            defaults.set("No", forKey:"isFirstTime")
            
            performSegue(withIdentifier: "toHomePage", sender: self)
        }
    }


}
