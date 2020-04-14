//
//  ViewController.swift
//  ReflectMe
//
//  Created by James Barlian on 03/04/20.
//  Copyright © 2020 Group 11 - Apple Developer Academy. All rights reserved.
//

import UIKit

class InputPageVC: UIViewController, UITextViewDelegate {

    // Text Views
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var superHappyImage: UIButton!
    @IBOutlet weak var happyImage: UIButton!
    @IBOutlet weak var neutralImage: UIButton!
    @IBOutlet weak var sadImage: UIButton!
    @IBOutlet weak var superSadImage: UIButton!
    
    @IBOutlet weak var doText: UITextView!
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBAction func dismissButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // Label for placeholders
    var placeholderLabel : UILabel!
    var doTextLabel : UILabel!

    // Data for Inputs
    var aPost: Post? = Post(postId: 1, postDate: Date(), postEmotion: "Happy", postDo: "Aku senang", postThought: "Aku belajar")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
// Do any additional setup after loading the view.
//        aPost?.postId = 1
//        aPost?.postEmotion = "happy"
//        aPost?.postDo = doText.text
//        aPost?.postThought = textView.text

        // Insert placeholders
        FeelingsPlaceHolder()
        ThoughtsPlaceHolder()
  
        // Print Today's Date
        GetCurrentDate()
    
        //MARK: HIDE KEYBOARD WHEN TAPPING ON SCREEN
        let tapOnScreen: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        tapOnScreen.cancelsTouchesInView = false

        view.addGestureRecognizer(tapOnScreen)
    
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    // Keyboard Setting
    func textViewDidBeginEditing(_ textview: UITextView) {
        if (textview == textView) {
            scrollview.setContentOffset(CGPoint(x: 0, y: 240), animated: true)
        } else {
            scrollview.setContentOffset(CGPoint(x: 0, y: 30), animated: true)
        }
        
    }
    
    func textViewShouldReturn(_ textview: UITextView) -> Bool {
        return true
    }
    
    func textViewDidEndEditing(_ textview: UITextView) {
        scrollview.setContentOffset(CGPoint(x:0, y:0), animated: true)
    }
    
    @IBAction func submitButton(_ sender: UIButton) {
        aPost?.postDo = doText.text
        aPost?.postThought = textView.text
    }
    
    @IBAction func superSadButton(_ sender: UIButton) {
        if superSadImage.currentBackgroundImage == #imageLiteral(resourceName: "sad-2"){
                superSadImage.setBackgroundImage(#imageLiteral(resourceName: "sad-3"), for: .normal)
                sadImage.setBackgroundImage(#imageLiteral(resourceName: "sad"), for: .normal)
                neutralImage.setBackgroundImage(#imageLiteral(resourceName: "meh"), for: .normal)
                superHappyImage.setBackgroundImage(#imageLiteral(resourceName: "happy"), for: .normal)
                happyImage.setBackgroundImage(#imageLiteral(resourceName: "smile-2"), for: .normal)
            
                aPost?.postEmotion = "super-sad"
            
            // Prevent other buttons to be pressed
//            sadImage.isUserInteractionEnabled = false
//            neutralImage.isUserInteractionEnabled = false
//            happyImage.isUserInteractionEnabled = false
//            superHappyImage.isUserInteractionEnabled = false
            
            }
            else{
            superSadImage.setBackgroundImage(#imageLiteral(resourceName: "sad-2"), for: .normal)
            
            // Allows buttons to be pressed again
//            sadImage.isUserInteractionEnabled = true
//            neutralImage.isUserInteractionEnabled = true
//            happyImage.isUserInteractionEnabled = true
//            superHappyImage.isUserInteractionEnabled = true
            
            }
    }
    
    @IBAction func sadButton(_ sender: UIButton) {
        if sadImage.currentBackgroundImage == #imageLiteral(resourceName: "sad"){
            sadImage.setBackgroundImage(#imageLiteral(resourceName: "sad-1"), for: .normal)
            superSadImage.setBackgroundImage(#imageLiteral(resourceName: "sad-2"), for: .normal)
            neutralImage.setBackgroundImage(#imageLiteral(resourceName: "meh"), for: .normal)
            superHappyImage.setBackgroundImage(#imageLiteral(resourceName: "happy"), for: .normal)
            happyImage.setBackgroundImage(#imageLiteral(resourceName: "smile-2"), for: .normal)
            
            aPost?.postEmotion = "sad"
            
            // Prevent other buttons to be pressed
//            superSadImage.isUserInteractionEnabled = false
//            neutralImage.isUserInteractionEnabled = false
//            happyImage.isUserInteractionEnabled = false
//            superHappyImage.isUserInteractionEnabled = false
        }
        else{
            
        sadImage.setBackgroundImage(#imageLiteral(resourceName: "sad"), for: .normal)
            
        // Allows buttons to be pressed again
//        superSadImage.isUserInteractionEnabled = true
//        neutralImage.isUserInteractionEnabled = true
//        happyImage.isUserInteractionEnabled = true
//        superHappyImage.isUserInteractionEnabled = true
        }
    }
  
    @IBAction func neutralButton(_ sender: UIButton) {
        if neutralImage.currentBackgroundImage == #imageLiteral(resourceName: "meh"){
            neutralImage.setBackgroundImage(#imageLiteral(resourceName: "meh-1"), for: .normal)
            sadImage.setBackgroundImage(#imageLiteral(resourceName: "sad"), for: .normal)
            superSadImage.setBackgroundImage(#imageLiteral(resourceName: "sad-2"), for: .normal)
            superHappyImage.setBackgroundImage(#imageLiteral(resourceName: "happy"), for: .normal)
            happyImage.setBackgroundImage(#imageLiteral(resourceName: "smile-2"), for: .normal)
            
            aPost?.postEmotion = "neutral"
            
            // Prevent other buttons to be pressed
//            superSadImage.isUserInteractionEnabled = false
//            sadImage.isUserInteractionEnabled = false
//            happyImage.isUserInteractionEnabled = false
//            superHappyImage.isUserInteractionEnabled = false
        }
        else{
        neutralImage.setBackgroundImage(#imageLiteral(resourceName: "meh"), for: .normal)
            
        // Allows buttons to be pressed again
//        superSadImage.isUserInteractionEnabled = true
//        sadImage.isUserInteractionEnabled = true
//        happyImage.isUserInteractionEnabled = true
//        superHappyImage.isUserInteractionEnabled = true
        }
    }
    
    @IBAction func happyButton(_ sender: UIButton) {
        
        if happyImage.currentBackgroundImage == #imageLiteral(resourceName: "smile-2"){
            happyImage.setBackgroundImage(#imageLiteral(resourceName: "smile-3"), for: .normal)
            sadImage.setBackgroundImage(#imageLiteral(resourceName: "sad"), for: .normal)
            superSadImage.setBackgroundImage(#imageLiteral(resourceName: "sad-2"), for: .normal)
            neutralImage.setBackgroundImage(#imageLiteral(resourceName: "meh"), for: .normal)
            superHappyImage.setBackgroundImage(#imageLiteral(resourceName: "happy"), for: .normal)
            
            aPost?.postEmotion = "happy"
            
            // Prevent other buttons to be pressed
//            superSadImage.isUserInteractionEnabled = false
//            sadImage.isUserInteractionEnabled = false
//            neutralImage.isUserInteractionEnabled = false
//            superHappyImage.isUserInteractionEnabled = false
        }
        else{
        happyImage.setBackgroundImage(#imageLiteral(resourceName: "smile-2"), for: .normal)
            
        // Allows buttons to be pressed again
//        superSadImage.isUserInteractionEnabled = true
//        sadImage.isUserInteractionEnabled = true
//        neutralImage.isUserInteractionEnabled = true
//        superHappyImage.isUserInteractionEnabled = true
        }
    }
    
    @IBAction func superHappyButton(_ sender: Any) {
        
        if superHappyImage.currentBackgroundImage == #imageLiteral(resourceName: "happy"){
            superHappyImage.setBackgroundImage(#imageLiteral(resourceName: "happy-1"), for: .normal)
            sadImage.setBackgroundImage(#imageLiteral(resourceName: "sad"), for: .normal)
            superSadImage.setBackgroundImage(#imageLiteral(resourceName: "sad-2"), for: .normal)
            neutralImage.setBackgroundImage(#imageLiteral(resourceName: "meh"), for: .normal)
            happyImage.setBackgroundImage(#imageLiteral(resourceName: "smile-2"), for: .normal)
            
            aPost?.postEmotion = "super-happy"
            
            // Prevent other buttons to be pressed
//            superSadImage.isUserInteractionEnabled = false
//            sadImage.isUserInteractionEnabled = false
//            neutralImage.isUserInteractionEnabled = false
//            happyImage.isUserInteractionEnabled = false
        }
        else{
        superHappyImage.setBackgroundImage(#imageLiteral(resourceName: "happy"), for: .normal)
            
        // Allows buttons to be pressed again
//        superSadImage.isUserInteractionEnabled = true
//        sadImage.isUserInteractionEnabled = true
//        neutralImage.isUserInteractionEnabled = true
//        happyImage.isUserInteractionEnabled = true
        }
    }
    
    
    
    func GetCurrentDate(){
        // Gets tne current date
        let currentDateTime = Date()
        
        // Initialize formatter and set style
        let format = DateFormatter()
        format.dateStyle = .long
        
        dateLabel.text = format.string(from: currentDateTime)
    }

    // First Placeholder
    func FeelingsPlaceHolder () {
        doText.delegate = self
        doTextLabel = UILabel()
        doTextLabel.text = "Tell us about your day :)"
        doTextLabel.font = UIFont.italicSystemFont(ofSize: (doText.font?.pointSize)!)
        doTextLabel.sizeToFit()
        doText.addSubview(doTextLabel)
        doTextLabel.frame.origin = CGPoint(x: 5, y: (doText.font?.pointSize)! / 2)
        doTextLabel.textColor = UIColor.lightGray
        doTextLabel.isHidden = !doText.text.isEmpty
    }

    // Second Place holder
    func ThoughtsPlaceHolder (){
        textView.delegate = self
        placeholderLabel = UILabel()
        placeholderLabel.text = "Tell us whats on your mind :)"
        placeholderLabel.font = UIFont.italicSystemFont(ofSize: (textView.font?.pointSize)!)
        placeholderLabel.sizeToFit()
        textView.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (textView.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        if (textView == doText) {
            doTextLabel.isHidden = !doText.text.isEmpty
        } else {
            placeholderLabel.isHidden = !textView.text.isEmpty
        }
            
    }
    
}

