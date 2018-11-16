//
//  HighScoreViewController.swift
//  Set
//
//  Created by Tommy Howell on 10/1/18.
//  Copyright © 2018 Tommy Howell. All rights reserved.
//

import UIKit

class HighScoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var highScoreTableView: UITableView!
    
    private var highscores: [ScoreHolder]?

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
        spinner.hidesWhenStopped = true
        loadHighScores()
    }
    
    let highScoreService = HighScoreServie()
    
    func loadHighScores() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        highScoreService.getHighScoreResults() { results, errorMessage in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if let results = results {
                self.spinner?.stopAnimating()
                print(results)
                self.highscores = results
                self.highScoreTableView.reloadData()
            }
            if !errorMessage.isEmpty { print("Search error: " + errorMessage) }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return highscores?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "highScoreCell") as! HighScoreTableViewCell
        cell.rank.text = String(indexPath.row + 1)
        cell.name.text = highscores?[indexPath.row].user ?? "No Player"
        cell.score.text = highscores?[indexPath.row].score.string ?? "?"
        return cell
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

extension Int {
    var string: String {
        return String(self)
    }
}
