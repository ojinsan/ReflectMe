//
//  ProfileVC.swift
//  ReflectMe
//
//  Created by Nixi Sendya Putri on 07/04/20.
//  Copyright © 2020 Group 11 - Apple Developer Academy. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateJoinedLabel: UILabel!
    @IBOutlet weak var imageBadge: UIImageView!
    @IBOutlet weak var labelWordsWritten: UILabel!
    @IBOutlet weak var labelTotalEntries: UILabel!
    @IBOutlet weak var labelTotalBadges: UILabel!
    @IBOutlet weak var labelCurrentStreak: UILabel!
    
    @IBOutlet weak var viewProfileCard: UIView!
    
    let defaults = UserDefaults.standard
    
    var arrayOfBadges: [String] = []
    var posts:[Post] = []
    var totalWords = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Name with User Default
        
        if let savedUser = defaults.object(forKey: "savedUser") as? Data {
            let decoder = JSONDecoder()
            if let loadedUser = try? decoder.decode(User.self, from: savedUser) {
                nameLabel.text = loadedUser.username
                dateJoinedLabel.text = loadedUser.dateJoined
            }
        }
        
        viewProfileCard.layer.applySketchShadow(
            color: .black,
            alpha: 0.08,
            x: 0,
            y: 4,
            blur: 12,
            spread: 2)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Get Posts from User Defaults
        if let savedPosts = defaults.object(forKey: "savedPosts") as? Data {
            let decoder = JSONDecoder()
            if let loadedPosts = try? decoder.decode([Post].self, from: savedPosts) {
                posts = loadedPosts
            }
        }
        
        // Set statistics
        setStatistics()
        
        setCurrentBadge()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setStatistics() {
        
        if let savedUser = defaults.object(forKey: "savedUser") as? Data {
            let decoder = JSONDecoder()
            if let loadedUser = try? decoder.decode(User.self, from: savedUser) {
                
                // Set words written
                if(!posts.isEmpty) {
                    totalWords = 0
                    for n in 0...posts.count-1 {
                        totalWords += SpecificWordCount(post: posts[n])
                    }
                }
                labelWordsWritten.text = "\(totalWords)"
                
                // Set average emotion
                var emotionScore: Float = 0
                if(!posts.isEmpty) {
                    totalWords = 0
                    for n in 0...posts.count-1 {
                        emotionScore += score(posts[n].postEmotion)
                    }
                }
                
                if posts.isEmpty {
                    labelCurrentStreak.text = "0 / 5"
                } else {
                    emotionScore = emotionScore / Float((posts.count))
                    labelCurrentStreak.text = String.localizedStringWithFormat("%.1f / 5", emotionScore)
                }
                
                // Set total entries
                labelTotalEntries.text = "\(posts.count)"
                
                // Set total badges count
                print("Total badgges: \(loadedUser.badges.count)")
                labelTotalBadges.text = "\(loadedUser.badges.count)"
                
                arrayOfBadges = loadedUser.badges
            }
        }
        
    }
    
    func setCurrentBadge() {
        
        if !arrayOfBadges.isEmpty {
            let latestBadge = arrayOfBadges[arrayOfBadges.count-1]
            print("Latest badge: \(latestBadge)")
            switch latestBadge {
            case "profile-badge":
                imageBadge.image = UIImage(named: "profile-badge")
            case "profile-badge-2":
                imageBadge.image = UIImage(named: "profile-badge-2")
            case "profile-badge-3":
                imageBadge.image = UIImage(named: "profile-badge-3")
            default:
                imageBadge.image = UIImage(named: "")
            }
            
        } else {
            imageBadge.image = nil
        }
    }
    
    // counts a specific word in a string
    func SpecificWordCount(post: Post) ->Int {
        
        // Count words in Post Do
        var str = post.postDo
        var words = str.components(separatedBy: " ")
        var count = 0
        for _ in words {
            count += 1
        }
        
        // Count words in Post Thought
        str = post.postThought
        words = str.components(separatedBy: " ")
        for _ in words {
            count += 1
        }
        
        return count
    }
    
    //
    func score(_ emotion:String) -> Float {
        switch emotion {
        case "super-sad":
            return 1
        case "sad":
            return 2
        case "neutral":
            return 3
        case "happy":
            return 4
        case "super-happy":
            return 5
        default:
            return 0
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
