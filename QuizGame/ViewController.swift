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
    var successCounter: String = ""

    let JSON = """
    [{
            "answers": ["Lionel Messi", "Cristiano Ronaldo", "Pele", "Maradona"],
            "imageUrl": "https://firebasestorage.googleapis.com/v0/b/first-project-21ae3.appspot.com/o/Lionel_Messijpg.jpg?alt=media&token=2f2eae5f-97fb-44bf-9fdd-c51357ec655b",
            "correctAnswer": "Lionel Messi"
        },
        {
            "answers": ["Gerard Pique", "Cristiano Ronaldo", "Ronaldinho", "Maradona"],
            "imageUrl": "https://firebasestorage.googleapis.com/v0/b/first-project-21ae3.appspot.com/o/Ronaldinho.jpg?alt=media&token=5c8c6a53-e124-42b3-82c4-3af560fa10f1",
            "correctAnswer": "Ronaldinho"
        },
        {
            "answers": ["Johnny Depp", "Bill Gates", "Jeff Bezos", "Elon Musk"],
            "imageUrl": "https://firebasestorage.googleapis.com/v0/b/first-project-21ae3.appspot.com/o/Elon_Musk.jpg?alt=media&token=59d70108-9074-4419-9e3e-85613b69e332",
            "correctAnswer": "Elon Musk"
        },
        {
            "answers": ["Steve Jobs", "Bill Gates", "Jeff Bezos", "Elon Musk"],
            "imageUrl": "https://firebasestorage.googleapis.com/v0/b/first-project-21ae3.appspot.com/o/Bill_Gates.jpg?alt=media&token=74e90748-8b94-4a4b-8f41-b523bcfc6c5e2",
            "correctAnswer": "Bill Gates"
        },
        {
            "answers": ["Steve Jobs", "Paul Allen", "Jeff Bezos", "Elon Musk"],
            "imageUrl": "https://firebasestorage.googleapis.com/v0/b/first-project-21ae3.appspot.com/o/jobs.jpg?alt=media&token=f8666fdc-9d43-4760-bb1c-0af710b6e292",
            "correctAnswer": "Steve Jobs"
        },
        {
            "answers": ["Federer", "Nadal", "Djokovich", "Medvedev"],
            "imageUrl": "https://firebasestorage.googleapis.com/v0/b/first-project-21ae3.appspot.com/o/federerR.png?alt=media&token=9f6e956c-a760-4981-b670-24116905a8bb",
            "correctAnswer": "Federer"
        },
        {
            "answers": ["Serena Williams", "Nadal", "Djokovich", "Medvedev"],
            "imageUrl": "https://firebasestorage.googleapis.com/v0/b/first-project-21ae3.appspot.com/o/rafa.jpg?alt=media&token=afd34364-f780-491b-a856-facc814dfd0e",
            "correctAnswer": "Nadal"
        },
        {
            "answers": ["Serena Williams", "Sara netanyahu", "Nechama leibowitz", "Golda Meir"],
            "imageUrl": "https://firebasestorage.googleapis.com/v0/b/first-project-21ae3.appspot.com/o/Golda.jpg?alt=media&token=6bf499b7-5156-4092-89b3-4cb31b83be10",
            "correctAnswer": "Golda Meir"
        },
        {
            "answers": ["Nietche", "Edgar allan poe", "William James", "Medvedev"],
            "imageUrl": "https://firebasestorage.googleapis.com/v0/b/first-project-21ae3.appspot.com/o/edgar%20allan%20poe.jpg?alt=media&token=c047ea93-a7b0-4cad-9a0d-5f0935927d05",
            "correctAnswer": "Edgar allan poe"
        },
        {
            "answers": ["Nietche", "Edgar allan poe", "William James", "Shakespeare"],
            "imageUrl": "https://firebasestorage.googleapis.com/v0/b/first-project-21ae3.appspot.com/o/Shakespeare.jpg?alt=media&token=677dc03b-1a9c-45d8-9cbc-292fc8c84482",
            "correctAnswer": "Shakespeare"
        },
        {
            "answers": ["Nietche", "Edgar allan poe", "Bach", "Shakespeare"],
            "imageUrl": "https://firebasestorage.googleapis.com/v0/b/first-project-21ae3.appspot.com/o/Nietche.jpg?alt=media&token=2c4322cb-9029-463a-9f50-c41ba695e89c",
            "correctAnswer": "Nietche"
        },
        {
            "answers": ["Galileo", "Chopin", "Bach", "Shakespeare"],
            "imageUrl": "https://firebasestorage.googleapis.com/v0/b/first-project-21ae3.appspot.com/o/Johann_Sebastian_Bach.jpg?alt=media&token=533356ba-9853-4a7f-b238-cecdf9f6ead6",
            "correctAnswer": "Bach"
        },
        {
            "answers": ["Beethoven", "Chopin", "Galileo", "Shakespeare"],
            "imageUrl": "https://firebasestorage.googleapis.com/v0/b/first-project-21ae3.appspot.com/o/Galileo.jpg?alt=media&token=c2e61ade-222f-40d3-9dd3-0b10f0f540ce",
            "correctAnswer": "Galileo"
        },
        {
            "answers": ["Bach", "Chopin", "Galileo", "Beethoven"],
            "imageUrl": "https://firebasestorage.googleapis.com/v0/b/first-project-21ae3.appspot.com/o/Beethoven.jpg?alt=media&token=60069b67-88f7-4dde-bfbd-6505c5718f11",
            "correctAnswer": "Beethoven"
        },
        {
            "answers": ["Bach", "Chopin", "Galileo", "Beethoven"],
            "imageUrl": "https://firebasestorage.googleapis.com/v0/b/first-project-21ae3.appspot.com/o/Beethoven.jpg?alt=media&token=60069b67-88f7-4dde-bfbd-6505c5718f11",
            "correctAnswer": "Chopin"
        }]
    """
    
    @IBAction func onButtonTap()
    {
//        self.performSegue(withIdentifier: "StartGame", sender: self)
//        let vc = GameViewController(nibName: "GameViewController", bundle: nil)
//        vc.questions = questions
//        self.navigationController?.pushViewController(vc, animated: true)
//
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let gameViewController = storyBoard.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        gameViewController.questions = questions
        self.present(gameViewController, animated:true, completion:nil)
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "SecondScreen",
//            let destination = segue.destination as? GameViewController {
//            // pass through questions to destination view controller
//            destination.questions = questions
//        }
//    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let jsonData = JSON.data(using: .utf8)!
        questions = try! JSONDecoder().decode([Question].self, from: jsonData)
        print(questions.forEach { print($0.answers) }) // -> Prints out all the answers
        print("successCounter :::: \(successCounter)")
        if(successCounter != ""){
            score.text = "Score: \(String(successCounter))/\(String(questions.count))"
            score.isHidden = false
        }

    }


}

