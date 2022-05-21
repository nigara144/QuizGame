//
//  Question.swift
//  QuizGame
//
//  Created by user216966 on 5/20/22.
//

import Foundation

struct Question: Decodable {
    let answers: [String]
    let imageUrl: String
    let correctAnswer: String
}
