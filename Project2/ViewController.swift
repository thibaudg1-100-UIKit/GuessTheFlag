//
//  ViewController.swift
//  Project2
//
//  Created by RqwerKnot on 04/10/2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!    
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var questions = 0
    
    var correctAnswer = 0
    
    var highestScore = 0 {
        didSet {
            UserDefaults.standard.set(highestScore, forKey: "highestScore")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        highestScore = defaults.integer(forKey: "highestScore")

        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
        
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        // for project 15
        UIView.animate(withDuration: 0.2) {
            self.button1.transform = .identity
            self.button2.transform = .identity
            self.button3.transform = .identity
        }
        //----
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = "Tap flag of \(countries[correctAnswer].uppercased())? Score \(score)"

    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        // for challenge project 15:
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 20) {
            sender.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }
        // ----
        
        questions += 1
        
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong! That's the flag of \(countries[sender.tag].uppercased())"
            score -= 1
        }
        
        self.title = "Tap flag of \(countries[correctAnswer].uppercased())? Score: \(score)"
        
        if questions < 10 {
            let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
            
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            
            present(ac, animated: true)
        } else {
            // UserDefaults challenge:
            let message = (score > highestScore) ? "Hurray you beat the highest score!" : "That's not bad."
            highestScore = score > highestScore ? score : highestScore
            
            let ac = UIAlertController(title: "\(score) points!", message: message, preferredStyle: .alert)
            
            ac.addAction(UIAlertAction(title: "Start again", style: .default, handler: askQuestion))
            
            present(ac, animated: true)
            
            score =  0
            questions = 0
        }
        
    }

}

