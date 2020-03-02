//
//  ViewController.swift
//  catchTheKennyGame
//
//  Created by Mustafa IŞIK on 29.02.2020.
//  Copyright © 2020 Mustafa ISIK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Views
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var hightScoreLabel: UILabel!
    
    
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    
    //Variables
    var score = 0
    var timer = Timer()
    var counter = 0
    var kennyArray =  [UIImageView]()
    var hideTimer = Timer()
    var hightScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        scoreLabel.text = "Score : " + String(score)
        
        //hight score check
        
        let storedHightScore = UserDefaults.standard.object(forKey: "hightScore")
        if storedHightScore == nil{
            hightScore = 0
            hightScoreLabel.text = "Hight Score : " + String(hightScore)
        }
        if let newhightScore = storedHightScore as? Int{
            hightScore = newhightScore
            hightScoreLabel.text = "Hight Score : " + String(hightScore)
        }
        
        // images
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
       
        
        kenny1.addGestureRecognizer(recognizer1)
        kenny2.addGestureRecognizer(recognizer2)
        kenny3.addGestureRecognizer(recognizer3)
        kenny4.addGestureRecognizer(recognizer4)
        kenny5.addGestureRecognizer(recognizer5)
        kenny6.addGestureRecognizer(recognizer6)
        kenny7.addGestureRecognizer(recognizer7)
        kenny8.addGestureRecognizer(recognizer8)
        kenny9.addGestureRecognizer(recognizer9)
        
        kennyArray =  [kenny1, kenny2, kenny3, kenny4, kenny5, kenny6, kenny7, kenny8, kenny9]
        
        // Times
        
        counter = 10
        timerLabel.text = "Time : " + String(counter)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(coundDown), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        
    }
    
    @objc func hideKenny(){
        for kenny in kennyArray{
            kenny.isHidden = true
        }
        
        let randomKenny = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
        kennyArray [randomKenny].isHidden = false
    }
    
    @objc func coundDown(){
        counter -= 1
        timerLabel.text = "Timer : " + String(counter)
        
        if counter == 0{
            timer.invalidate()
            hideTimer.invalidate()
            
            for kenny in kennyArray{
                kenny.isHidden = true
            }
            // Hight Score
            
            if self.score > self.hightScore{
                self.hightScore = self.score
                self.hightScoreLabel.text = "Hight Score : " + String(self.hightScore)
                UserDefaults.standard.set(self.hightScore, forKey: "hightScore")
            }
            
            
            //Alert
            
            let alert = UIAlertController(title: "Time`s Up", message: "Do You Want To Play Again", preferredStyle: UIAlertController.Style.alert)
            
            let buttonOky = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            let buttonReplace = UIAlertAction(title: "Replace", style: UIAlertAction.Style.default) { (UIAlertAction) in
                self.score = 0
                self.scoreLabel.text = "Score : " + String(self.score)
                self.counter = 10
                self.timerLabel.text = "Time : " + String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.coundDown), userInfo: nil, repeats: true)
                
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
                
            }
            
            alert.addAction(buttonOky)
            alert.addAction(buttonReplace)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func increaseScore() {
        score += 1
        scoreLabel.text = "Score : " + String(score)
    }


}

