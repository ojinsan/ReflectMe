//
//  detailpageVC.swift
//  ReflectMe
//
//  Created by Fauzan Ramadhan on 07/04/20.
//  Copyright © 2020 Group 11 - Apple Developer Academy. All rights reserved.
//

import UIKit

class detailpageVC: UIViewController, UITextViewDelegate {

    //set the outlet of each element
    @IBOutlet weak var reflectionEmotionBg: UIImageView!
    @IBOutlet weak var reflectionDate: UILabel!
    @IBOutlet weak var reflectionMonthYear: UILabel!
    @IBOutlet weak var reflectionDay: UILabel!
    @IBOutlet weak var reflectionStory: UITextView!
    @IBOutlet weak var reflectionThought: UITextView!
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    //dummy data, delete this when segue is prepared in home page
    var aPost = Post (postId: 1, postDate: Date(), postEmotion: "happy", postDo: "blabla", postThought: "blulb")
    let date:Date = Date()
    
    var isEdit: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isEdit{
            reflectionStory.isEditable = true
            reflectionStory.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.00)
            reflectionThought.isEditable = true
            reflectionThought.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.00)
            doneButton.isHidden = false
            backButton.isHidden = true
        } else {
            reflectionStory.backgroundColor = UIColor.white
            reflectionStory.isEditable = false
            reflectionThought.backgroundColor = UIColor.white
            reflectionThought.isEditable = false
            doneButton.isHidden = true
            backButton.isHidden = false
        }
        
        //MARK: HIDE KEYBOARD WHEN TAPPING ON SCREEN
        let tapOnScreen: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        tapOnScreen.cancelsTouchesInView = false

        view.addGestureRecognizer(tapOnScreen)
        
        
        //put background image
        switch aPost.postEmotion {
        case "super-sad":
            reflectionEmotionBg.image = UIImage (named: "bg-emotion-1")
        case "sad":
            reflectionEmotionBg.image = UIImage (named: "bg-emotion-2")
        case "neutral":
            reflectionEmotionBg.image = UIImage (named: "bg-emotion-3")
        case "happy":
            reflectionEmotionBg.image = UIImage (named: "bg-emotion-4")
        case "super-happy":
            reflectionEmotionBg.image = UIImage (named: "bg-emotion-5")
        default:
            print("error")
        }
        
        //put date
        reflectionDate.text = "\(currentNow(aPost.postDate, "day"))"
        reflectionMonthYear.text = "\(currentNow(aPost.postDate, "month")), \(currentNow(aPost.postDate, "year"))"
        reflectionDay.text = "\(currentNow(aPost.postDate, "dayname"))"
        
        //put the story
        reflectionStory.text = "\(aPost.postDo)"
        reflectionThought.text = "\(aPost.postThought)"
    }
    
    // Keyboard Setting
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textViewDidBeginEditing(_ textview: UITextView) {
        if (textview == reflectionThought) {
            scrollview.setContentOffset(CGPoint(x: 0, y: 250), animated: true)
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
    
    //get specific format of date to be displayed
    func currentNow(_ date:Date, _ outputFormat:String) -> String {
        let dateFormatter = DateFormatter()
        switch outputFormat {
            case "dayname":
                dateFormatter.dateFormat = "EEEE"
            case "day":
                dateFormatter.dateFormat = "dd"
            case "month":
                dateFormatter.dateFormat = "MMMM"
            case "year":
                dateFormatter.dateFormat = "y"
            default:
                dateFormatter.dateFormat = "EEEE"
        }
        let desiredDateFormat = dateFormatter.string(from: date)
        return desiredDateFormat
    }
}
  
