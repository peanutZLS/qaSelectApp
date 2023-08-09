//
//  ResultViewController.swift
//  QASelect
//
//  Created by 郭家宇 on 2023/8/9.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet var scoreLabel: UILabel!


        // Do any additional setup aftvar score: Int = 0
        var score: Int = 0
          
        override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "得分：\(score)"
          
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
