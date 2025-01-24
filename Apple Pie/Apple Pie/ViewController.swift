//
//  ViewController.swift
//  Apple Pie
//
//  Created by Randylon Torda on 11/4/24.
//

import UIKit

//this is array of my list of words for gueesing the answer.
var listOfWords = ["leopard","swift","glorious","mustang","mississippi","program"]

//this is variable for my my moves allowed.
let incorrecMovesAllowed = 7



class ViewController: UIViewController {
    
    var totalWins = 0{
        didSet{
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    // Ise an oulet for Image, and label
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLael: UILabel!
    
    
    @IBOutlet var letterButtons: [UIButton]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        newRound()
    }
    
    var currentGame: Game!
    
    
    //Function for newRound everytime the game has ended it will set a new round.
    func newRound(){
        
        //condition for keyboard so we need to enable the button once all letter is correct.
        if !listOfWords.isEmpty{
            let newWord = listOfWords.removeFirst()
            
            currentGame = Game(word: newWord,
            incorrectMovesRemaining: incorrecMovesAllowed,
            guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
        }else{
            enableLetterButtons(false)
        }
        
        
    }
    
    //this is the function of button so we declare the value as default enable.
    func enableLetterButtons(_ enable: Bool){
        for button in letterButtons{
            button.isEnabled = enable
        }
    }
    
    //Function for update interface.
    func updateUI(){
        
        var letters = [String]()
        for letter in currentGame.formmattedWord{
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        
        scoreLael.text = "Victories: \(totalWins), Misplaces: \(totalLosses) "
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    
    //this my function for my button once int pressed so it configure and call the updateGameState once it is done
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        
        let letterString = sender.configuration!.title!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
       updateGamesState()
        
    }
    
    //function for update game state which is the total wins and losses
    func updateGamesState() {
        if currentGame.incorrectMovesRemaining == 0{
            totalLosses += 1
        
        }else if currentGame.word == currentGame.formmattedWord{
            totalWins += 1
            
        }else{
            updateUI()
        }
    }
    
}

