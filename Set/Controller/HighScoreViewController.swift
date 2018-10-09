//
//  HighScoreViewController.swift
//  Set
//
//  Created by Tommy Howell on 10/1/18.
//  Copyright © 2018 Tommy Howell. All rights reserved.
//

import UIKit

class HighScoreViewController: UIViewController {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        spinner.startAnimating()
        let id = 1
        loadHighScores(id: id)
    }
    
    let highScoreService = HighScoreServie()
    
    func loadHighScores(id: Int) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        highScoreService.getHighScoreResults(id: id) { results, errorMessage in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if let results = results {
                print(results)
            }
            if !errorMessage.isEmpty { print("Search error: " + errorMessage) }
        }
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
