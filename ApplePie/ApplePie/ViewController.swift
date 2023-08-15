//
//  ViewController.swift
//  ApplePie
//
//  Created by Asmaa Mohamed on 31/07/2023.
//

import UIKit

class ViewController: UIViewController {
    var listOfWords = ["buccaneer","swift","glorious","incandescent","bug","program"]
    let incorrectMovesAllowed = 7
    var totalWin = 0{
        didSet {
            newRound()
        }
    }

    var totalLosess = 0{
        didSet {
            newRound()
        }
    }



    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    @IBOutlet weak var treeImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    var currentGame: Game!

    func newRound(){
        if !listOfWords.isEmpty{
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
            
        }else{
            enableLetterButtons(false)
            
        }

        
    }
    func enableLetterButtons(_ enable: Bool) {
      for button in letterButtons {
        button.isEnabled = enable
      }
    }
    

    func updateUI(){
        var letters = [String]()
        for letter in currentGame.formattedWord {
                letters.append(String(letter))
            }
        let wordWithSpacing = letters.joined(separator: " ")
        
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins : \(totalWin) ,losses :\(totalLosess)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
        
    }

    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.configuration!.title!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    func updateGameState(){
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosess += 1
          }else if currentGame.word == currentGame.formattedWord {
              totalWin += 1
            
            }else {
                updateUI()
              }


        

    
        
    }
    
}

