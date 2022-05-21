//
//  ViewController.swift
//  QuizGame
//
//  Created by user216966 on 5/20/22.
//

import UIKit
import Foundation

enum SelectedButtonTag: Int {
    case First
    case Second
    case Third
    case Forth
}

class GameViewController: UIViewController {
    
    @IBOutlet weak var livesNum: UILabel!
    @IBOutlet weak var questionNum: UILabel!
    @IBOutlet weak var questionImage: UIImageView!
    @IBOutlet weak var firstAnswer: UIButton!
    @IBOutlet weak var secondAnswer: UIButton!
    @IBOutlet weak var thirdAnswer: UIButton!
    @IBOutlet weak var forthAnswer: UIButton!
    
    
    var questions: [Question] = []
    var currentQuestionNum: Int = 0
    var successCounter: Int = 0
    var livesCounter: Int = 3

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(questions.forEach { print($0.correctAnswer) }) // -> Prints out all the answers
        initButtons()
        
        setUIByCurrentQuestionNum(index: currentQuestionNum)
    }
    
    func initButtons(){
        firstAnswer.tag = 0
        secondAnswer.tag = 1
        thirdAnswer.tag = 2
        forthAnswer.tag = 3
        
        firstAnswer.addTarget(self, action: #selector(onAnswerTap(sender:)), for: .touchUpInside)
        secondAnswer.addTarget(self, action: #selector(onAnswerTap(sender:)), for: .touchUpInside)
        thirdAnswer.addTarget(self, action: #selector(onAnswerTap(sender:)), for: .touchUpInside)
        forthAnswer.addTarget(self, action: #selector(onAnswerTap(sender:)), for: .touchUpInside)

    }
    
    func setUIByCurrentQuestionNum(index: Int){
        if(currentQuestionNum + 1 < questions.count && livesCounter > 0){
            //get data from network
            print("image url ::::: \(questions[index].imageUrl)")
            let url = URL(string: questions[index].imageUrl)!
            questionImage.downloaded(from: url)
            //get answers from json
            firstAnswer.setTitle(questions[index].answers[0], for: .normal)
            secondAnswer.setTitle(questions[index].answers[1], for: .normal)
            thirdAnswer.setTitle(questions[index].answers[2], for: .normal)
            forthAnswer.setTitle(questions[index].answers[3], for: .normal)
            // set question number ui label
            questionNum.text = "\(String(currentQuestionNum + 1))/\(String(questions.count))"
        }else{
            // Go back start view with the success counter
            print("number of lives : \(livesCounter)")
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let viewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            viewController.successCounter = String(successCounter)
            self.present(viewController, animated:true, completion:nil)
//            self.performSegue(withIdentifier: "EndGame", sender: self)
        }
        
    }
    
    
    @IBAction func onAnswerTap(sender: UIButton)
    {
       // self.performSegue(withIdentifier: "StartGame", sender: self)
       print("ANSWER TAP")
        print(sender.tag)
        switch sender.tag {
                case 0:
                    print("do something when first button is tapped")
                    validateAnswer(index: sender.tag)
                case 1:
                    print("do something when second button is tapped")
                    validateAnswer(index: sender.tag)
                case 2:
                    print("do something when third button is tapped")
                    validateAnswer(index: sender.tag)
                case 3:
                    print("do something when Forth button is tapped")
                    validateAnswer(index: sender.tag)
                default:
                    print("default")
            }

    }
    
    func validateAnswer(index: Int){
        // Correct answer
        if(questions[currentQuestionNum].correctAnswer == questions[currentQuestionNum].answers[index]){
            successCounter += 1
            print("correct")

        }else{
            updatelivesCounter()
        }
        currentQuestionNum += 1
        setUIByCurrentQuestionNum(index: currentQuestionNum)
        print("after refresh")
    }
    
    
    func updatelivesCounter(){
        livesCounter -= 1
        livesNum.text = "x\(livesCounter)"
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "FirstScreen",
//            let destination = segue.destination as? ViewController {
//            print("im hereeeeeee")
//            // pass through questions to destination view controller
//            if(currentQuestionNum == questions.count || livesCounter == 0){
//                destination.successCounter = String(successCounter)
//            }
//        }
//    }
    
}



extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}



