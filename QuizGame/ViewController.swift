//
//  ViewController.swift
//  QuizGame
//
//  Created by user216966 on 5/20/22.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var startButton: UIButton!
    var questions: [Question] = []

    let JSON = """
    [{
        "answers": ["Lionel Messi", "Cristiano Ronaldo", "Pele", "Maradona"],
        "imageUrl": "https://firebasestorage.googleapis.com/v0/b/first-project-21ae3.appspot.com/o/Lionel_Messijpg.jpg?alt=media&token=2f2eae5f-97fb-44bf-9fdd-c51357ec655b",
        "correctAnswer": "Lionel Messi"
    },
    {
        "answers": ["Lionel Messi", "Cristiano Ronaldo", "Pele", "Maradona"],
        "imageUrl": "https://firebasestorage.googleapis.com/v0/b/first-project-21ae3.appspot.com/o/Lionel_Messijpg.jpg?alt=media&token=2f2eae5f-97fb-44bf-9fdd-c51357ec655b",
        "correctAnswer": "Lionel Messi"
    },
    {
        "answers": ["Lionel Messi", "Cristiano Ronaldo", "Pele", "Maradona"],
        "imageUrl": "https://firebasestorage.googleapis.com/v0/b/first-project-21ae3.appspot.com/o/Lionel_Messijpg.jpg?alt=media&token=2f2eae5f-97fb-44bf-9fdd-c51357ec655b",
        "correctAnswer": "Lionel Messi"
    }]
    """
    
    @IBAction func onButtonTap()
    {
        self.performSegue(withIdentifier: "StartGame", sender: self)

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StartGame",
            let destination = segue.destination as? GameViewController {
            // pass through questions to destination view controller
            destination.questions = questions
        }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let jsonData = JSON.data(using: .utf8)!
        questions = try! JSONDecoder().decode([Question].self, from: jsonData)
        print(questions.forEach { print($0.answers) }) // -> Prints out all the answers

    }


}

