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
        //get data from network
        let url = URL(string: questions[index].imageUrl)!
        questionImage.downloaded(from: url)
        //get answers from json
        firstAnswer.setTitle(questions[index].answers[0], for: .normal)
        secondAnswer.setTitle(questions[index].answers[1], for: .normal)
        thirdAnswer.setTitle(questions[index].answers[2], for: .normal)
        forthAnswer.setTitle(questions[index].answers[3], for: .normal)
    }
    
    @IBAction func onAnswerTap(sender: UIButton)
    {
       // self.performSegue(withIdentifier: "StartGame", sender: self)
       print("ANSWER TAP")
        print(sender.tag)
        switch sender.tag {
                case 0:
                    print("do something when first button is tapped")
            validateAnswer(sender.tag)
                case 1:
                    print("do something when second button is tapped")
                case 2:
                    print("do something when third button is tapped")
                case 3:
                    print("do something when Forth button is tapped")
                default:
                    print("default")
            }

    }
    
    func validateAnswer(index: Int){
        
    }
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



