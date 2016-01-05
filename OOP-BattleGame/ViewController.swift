//
//  ViewController.swift
//  OOP-BattleGame
//
//  Created by Joshua Ide on 4/01/2016.
//  Copyright © 2016 Fox Gallery Studios. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    //Outlets
    @IBOutlet weak var btnAttack1: UIButton!
    @IBOutlet weak var btnAttack2: UIButton!
    @IBOutlet weak var imgPlayer1: UIImageView!
    @IBOutlet weak var imgPlayer2: UIImageView!
    @IBOutlet weak var lblOutput: UILabel!
    @IBOutlet weak var lblPlayer1HP: UILabel!
    @IBOutlet weak var lblPlayer2HP: UILabel!
    @IBOutlet weak var btnReset: UIButton!
    
    //Variables
    var player1: Character!
    var player2: Character!
    
    var bgMusic: AVAudioPlayer!
    var audAttack: AVAudioPlayer!
    var audDie:  AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initialise sounds
        //BG Music
        let pathBG = NSBundle.mainBundle().pathForResource("bg_music", ofType: "mp3")
        let soundURLBG = NSURL(fileURLWithPath: pathBG!)
        do {
            try bgMusic = AVAudioPlayer(contentsOfURL: soundURLBG)
            bgMusic.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        //attack sound
        let pathATK = NSBundle.mainBundle().pathForResource("sword_slash", ofType: "wav")
        let soundURLATK = NSURL(fileURLWithPath: pathATK!)
        do {
            try audAttack = AVAudioPlayer(contentsOfURL: soundURLATK)
            audAttack.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        //death sound
        let pathDTH = NSBundle.mainBundle().pathForResource("death", ofType: "wav")
        let soundURLDTH = NSURL(fileURLWithPath: pathDTH!)
        do {
            try audDie = AVAudioPlayer(contentsOfURL: soundURLDTH)
            audDie.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        //Initialise players
        player1 = Character(startingHP: 100, attackPower: 15, name: "OrcMan")
        player2 = Character(startingHP: 100, attackPower: 15, name: "KnightMan")
        
        bgMusic.play()
    }
    
    @IBAction func onAttack2Pressed(sender: AnyObject) {
        player1.attemptAttack(player2.attackPower)
        lblOutput.text = "\(player2.name) attacked \(player1.name) for \(player2.attackPower) HP!"
        lblPlayer1HP.text = "\(player1.hp)"
        btnAttack2.hidden = true
        
        if !player1.isAlive() {
            audDie.play()
            imgPlayer1.hidden = true
            lblOutput.text = "\(player2.name) killed \(player1.name)!"
            gameOver()
            return
        }

        playAttackSound()
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "canAttack2", userInfo: nil, repeats: false)
    }
    
    @IBAction func onAttack1Pressed(sender: AnyObject) {
        player2.attemptAttack(player1.attackPower)
        lblOutput.text = "\(player1.name) attacked \(player2.name) for \(player1.attackPower) HP!"
        lblPlayer2HP.text = "\(player2.hp)"
        btnAttack1.hidden = true
        
        if !player2.isAlive() {
            audDie.play()
            imgPlayer2.hidden = true
            lblOutput.text = "\(player1.name) killed \(player2.name)!"
            gameOver()
            return
        }
        
        playAttackSound()
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "canAttack1", userInfo: nil, repeats: false)
    }
    
    @IBAction func onResetPressed(sender: AnyObject) {
        player1.reset(100)
        player2.reset(100)
        btnReset.hidden = true
        btnAttack1.hidden = false
        btnAttack2.hidden = false
        imgPlayer1.hidden = false
        imgPlayer2.hidden = false
        lblPlayer1HP.hidden = false
        lblPlayer2HP.hidden = false
        lblPlayer1HP.text = "\(player1.hp)"
        lblPlayer2HP.text = "\(player2.hp)"
        lblOutput.text = "Press buttons to attack!"
    }
    
    func gameOver() {
        btnReset.hidden = false
        btnAttack1.hidden = true
        btnAttack2.hidden = true
        lblPlayer1HP.hidden = true
        lblPlayer2HP.hidden = true
    }
    
    func canAttack1() {
        if !player2.isAlive() || !player1.isAlive() {
            btnAttack1.hidden = true
        } else {
            btnAttack1.hidden = false
        }
    }
    
    func canAttack2() {
        if !player1.isAlive() || !player2.isAlive() {
            btnAttack2.hidden = true
        } else {
            btnAttack2.hidden = false
        }
    }
    
    func playAttackSound() {
        if audAttack.playing {
            audAttack.stop()
            audAttack.play()
        } else {
            audAttack.play()
        }
    }
    
}

