//
//  QandAViewController.swift
//  QASelect
//
//  Created by 郭家宇 on 2023/8/9.
//

import UIKit

class QandAViewController: UIViewController {

    @IBOutlet var numberCOunt: UILabel!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var questionButton: [UIButton]!
    var questions: [Question] = []
    var score :Int = 0
    var currentQuestionIndex = 0{
        didSet{
            loadQuestion()
        }
    }
//    var currentCategory: codecategory? {
//        return questions.isEmpty ? nil : questions[currentQuestionIndex].category
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setipQuestions()
        loadQuestion()
        // Do any additional setup after loading the view.
    }
    func setipQuestions(){
//        Question(question: "意大利有名的披薩起源於哪個城市？",
//                 options: ["羅馬", "米蘭", "拿坡里", "佛羅倫薩"],
//                 correctAnswer: 2,
//                 category: .italian),
        questions = [
            Question(question: "在 Swift 語言中，如何宣告一個常數？",
                     options: ["var", "let", "const", "constant"],
                     answer: 1,
                     category: .swift),
            Question(question: "Swift裡的Label是什麼？",
                     options: ["標籤", "按鈕", "開關", "圖片"],
                     answer: 0,
                     category: .swift),
            Question(question: "在 Swift 中，類別是什麼單字",
                     options: ["Switch", "Class", "While", "didSet"],
                     answer: 1,
                     category: .swift),
            Question(question: "Swift 中的「選擇結構」如何表示？",
                     options: ["if", "choose", "switch", "elect"],
                     answer: 0,
                     category: .swift),
            Question(question: "Swift 中，字典是什麼單字",
                     options: ["Array", "Set", "Dictionary", "List"],
                     answer: 2,
                     category: .swift),
            Question(question: "Swift 中，變數是什麼單字",
                     options: ["let", "var", "const", "def"],
                     answer: 1,
                     category: .swift),
            Question(question: "Swift的整數屬性是什麼",
                     options: ["Int", "String", "Double", "Float"],
                     answer: 0,
                     category: .swift),
            Question(question: "Python 中的「條件結構」如何表示？",
                     options: ["if", "while", "didset", "switch"],
                     answer: 0,
                     category: .python),
            Question(question: "在 Python 中，列表是什麼單字",
                     options: [" List", "Tuple", "Set", "Dictionary"],
                     answer: 0,
                     category: .python),
            Question(question: "在 Swift 中，開發IOSAPP要用什麼App",
                     options: ["DevC++", "Xcode", "Android Studio", "APPInventor"],
                     answer: 1,
                     category: .swift),
            ]
        questions.shuffle()
        for (index, question) in questions.enumerated() {
                var options = question.options
                options.shuffle()
                let newQuestion = Question(
                    question: question.question, options: options, answer:  options.firstIndex(of: question.options[question.answer])!, category: question.category
                )
                questions[index] = newQuestion
            }
        }
    func loadQuestion() {
        if currentQuestionIndex < questions.count {
            let question = questions[currentQuestionIndex]
            questionLabel.text = question.question
            numberCOunt.text = "題目 \(currentQuestionIndex + 1) / \(questions.count)"
            
            for (index, optionButton) in questionButton.enumerated() {
                optionButton.setTitle(question.options[index], for: .normal)
            }
        } else {
            showFinishedAlert()
        }
    }
    @IBAction func optionButtonTapped(_ sender: UIButton) {
        guard let selectedIndex = questionButton.firstIndex(of: sender) else { return }
                   
            let question = questions[currentQuestionIndex]
            let alertController: UIAlertController
            
            if question.answer == selectedIndex {
                score += 10
                alertController = UIAlertController(title: "答對了！", message: "你答對了這題，繼續加油！", preferredStyle: .alert)
            } else {
                let correctAnswerText = question.options[question.answer]
                alertController = UIAlertController(title: "答錯了！", message: "正確答案是：\(correctAnswerText)", preferredStyle: .alert)
            }
            
            alertController.addAction(UIAlertAction(title: "繼續", style: .default, handler: { _ in
                self.currentQuestionIndex += 1
            }))
            
            self.present(alertController, animated: true, completion: nil) // 注意這裡的 self.present
    }
    func showFinishedAlert() {
        let alertController = UIAlertController(title: "完成", message: "您已完成所有題目！", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "確定", style: .default) { _ in
            self.performSegue(withIdentifier: "showResultSegue", sender: self)
        }
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    

    @IBSegueAction func showResultAction(_ coder: NSCoder) -> ResultViewController? {
        let controller = ResultViewController(coder: coder)
        controller?.score = self.score
        return controller
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
