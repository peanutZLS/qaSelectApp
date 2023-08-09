# qaSelectApp
import UIKit

class QandAViewController: UIViewController {
    
    // 連結到畫面上的元件
    @IBOutlet var numberCOunt: UILabel!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var questionButton: [UIButton]!
    
    // 問題陣列、分數及當前問題索引
    var questions: [Question] = []
    var score: Int = 0
    var currentQuestionIndex = 0 {
        didSet {
            loadQuestion()
        }
    }
    
    // 在視圖載入時執行的程式碼
    override func viewDidLoad() {
        super.viewDidLoad()
        setipQuestions() // 初始化問題
        loadQuestion()   // 載入並顯示第一個問題
    }
    
    // 初始化問題的函式
    func setipQuestions() {
        // 在此設定題目及答案
        // ...
        questions.shuffle() // 打亂問題順序
        // 打亂每個問題的選項順序
        for (index, question) in questions.enumerated() {
            var options = question.options
            options.shuffle()
            let newQuestion = Question(
                question: question.question, options: options, answer: options.firstIndex(of: question.options[question.answer])!, category: question.category
            )
            questions[index] = newQuestion
        }
    }
    
    // 載入並顯示當前問題的函式
    func loadQuestion() {
        if currentQuestionIndex < questions.count {
            let question = questions[currentQuestionIndex]
            // 顯示問題內容和題號
            questionLabel.text = question.question
            numberCOunt.text = "題目 \(currentQuestionIndex + 1) / \(questions.count)"
            
            // 將選項設定為按鈕的標題
            for (index, optionButton) in questionButton.enumerated() {
                optionButton.setTitle(question.options[index], for: .normal)
            }
        } else {
            showFinishedAlert() // 顯示完成提示
        }
    }
    
    // 按鈕點擊事件的處理
    @IBAction func optionButtonTapped(_ sender: UIButton) {
        guard let selectedIndex = questionButton.firstIndex(of: sender) else { return }
        let question = questions[currentQuestionIndex]
        var alertController: UIAlertController
        
        // 檢查選擇是否正確
        if question.answer == selectedIndex {
            score += 10
            alertController = UIAlertController(title: "答對了！", message: "你答對了這題，繼續加油！", preferredStyle: .alert)
        } else {
            let correctAnswerText = question.options[question.answer]
            alertController = UIAlertController(title: "答錯了！", message: "正確答案是：\(correctAnswerText)", preferredStyle: .alert)
        }
        
        // 添加繼續按鈕的動作，並更新當前問題索引
        alertController.addAction(UIAlertAction(title: "繼續", style: .default, handler: { _ in
            self.currentQuestionIndex += 1
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // 顯示完成提示的函式
    func showFinishedAlert() {
        let alertController = UIAlertController(title: "完成", message: "您已完成所有題目！", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "確定", style: .default) { _ in
            self.performSegue(withIdentifier: "showResultSegue", sender: self)
        }
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }

    // 轉場至結果畫面的函式
    @IBSegueAction func showResultAction(_ coder: NSCoder) -> ResultViewController? {
        let controller = ResultViewController(coder: coder)
        controller?.score = self.score
        return controller
    }
}
