//
//  JokeDetailViewController.swift
//  Joke of the Day App
//
//  Created by Drew Miller on 8/6/20.
//  Copyright © 2020 DevMtn. All rights reserved.
//

import UIKit

class JokeDetailViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var jokeImage: UIImageView!
    @IBOutlet weak var jokeTextLabel: UILabel!
    
    //MARK: - Properties
    
    var categoryToReceive: String?
    var updatedJoke: Joke? {
        didSet {
            updateViewsWithJoke()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewsWithJoke()
        updateJokeImage()
        
    }

    
    @IBAction func getJokeActionButtonTapped(_ sender: Any) {
        updateViewsWithJoke()
    }
    
    //MARK: - Helper Methods
    func updateViewsWithJoke() {
        if let categoryToReceive = categoryToReceive {
            JokeController.fetchJoke(category: categoryToReceive) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let joke):
                        self.jokeTextLabel.text = joke.value
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }//end of function
    
    func updateJokeImage() {
        if let stringURL = updatedJoke?.icon_url {
            JokeController.fetchImage(for: stringURL) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let image):
                        self.jokeImage.image = image
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}//end of class
