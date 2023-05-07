//
//  ViewController.swift
//  KennyGame
//
//  Created by mustafa ölmezses on 5.05.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var kennyİmage: UIImageView!
    @IBOutlet weak var kennyİmage2: UIImageView!
    @IBOutlet weak var kennyİmage3: UIImageView!
    @IBOutlet weak var kennyİmage5: UIImageView!
    @IBOutlet weak var kennyİmage4: UIImageView!
    @IBOutlet weak var kennyİmage6: UIImageView!
    @IBOutlet weak var kennyİmage9: UIImageView!
    @IBOutlet weak var kennyİmage8: UIImageView!
    @IBOutlet weak var kennyİmage7: UIImageView!
    
    var timer = Timer()
    var hideTimer = Timer()
    var counter = 0;
    var kennyArray = [UIImageView]()
    var score = 1
    var highScore = 0
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highScore")
        
        if storedHighScore == nil {
            highScore=0
            highScoreLabel.text = "Highscore : \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int{
            highScore = newScore
            highScoreLabel.text = "Highcore :\(highScore)"

        }
        


        
        kennyArray = [kennyİmage,kennyİmage2,kennyİmage3,kennyİmage4,kennyİmage5,kennyİmage6,kennyİmage7,kennyİmage8,kennyİmage9]
        
        counter = 10
        secondLabel.text = String(counter)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector:#selector(timerFunction) , userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappPicture))
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(tappPicture))
        let gestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(tappPicture))
        let gestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(tappPicture))
        let gestureRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(tappPicture))
        let gestureRecognizer6 = UITapGestureRecognizer(target: self, action: #selector(tappPicture))
        let gestureRecognizer7 = UITapGestureRecognizer(target: self, action: #selector(tappPicture))
        let gestureRecognizer8 = UITapGestureRecognizer(target: self, action: #selector(tappPicture))
        let gestureRecognizer9 = UITapGestureRecognizer(target: self, action: #selector(tappPicture))
        
        kennyİmage.addGestureRecognizer(gestureRecognizer)
        kennyİmage2.addGestureRecognizer(gestureRecognizer2)
        kennyİmage3.addGestureRecognizer(gestureRecognizer3)
        kennyİmage4.addGestureRecognizer(gestureRecognizer4)
        kennyİmage5.addGestureRecognizer(gestureRecognizer5)
        kennyİmage6.addGestureRecognizer(gestureRecognizer6)
        kennyİmage7.addGestureRecognizer(gestureRecognizer7)
        kennyİmage8.addGestureRecognizer(gestureRecognizer8)
        kennyİmage9.addGestureRecognizer(gestureRecognizer9)
        
        
        hideKenny()
    } // ViewDidLoad
    
    
    @objc func timerFunction(){
        secondLabel.text = String(counter)
        counter -= 1
        
        for kenny in kennyArray{
            kenny.isUserInteractionEnabled = true
        }
        
        if counter == -1 {
            timer.invalidate()
            hideTimer.invalidate()
            for array in kennyArray{
                array.isUserInteractionEnabled = false
            }
            //high score
            
            if self.score > self.highScore{
                
                self.highScore = self.score
                self.highScoreLabel.text = "Highscore : \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highScore")
            }
            
            //alert
            
            let alert = UIAlertController(title: "Times's up", message: "Dou you want to play again ?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default){ (UIAlertAction) in
                
                self.score = 0
                self.scoreLabel.text = "Score \(self.score)"
                self.counter = 10
                self.secondLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector:#selector(self.timerFunction) , userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
                
                
                
                
            }//replay button
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true)
            
            
            
            
            
            
        }//if
        
        
        
    }//timerFunction
    
    
    @objc func tappPicture(){
        
        scoreLabel.text = "Score : \(score)"
        score += 1
        
    }//tappPicture()
    
    
    @objc func hideKenny(){
        
        for kenny in kennyArray{
            kenny.isHidden = true
        }
        
        let randomNumber = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
        print(randomNumber)
        
        kennyArray[randomNumber].isHidden = false
        
    }//hideKenny()
    
    
    
}

