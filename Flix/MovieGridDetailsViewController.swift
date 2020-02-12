//
//  MovieGridDetailsViewController.swift
//  Flix
//
//  Created by Marco Aguilera on 2/11/20.
//  Copyright © 2020 Marco Aguilera. All rights reserved.
//

import UIKit

class MovieGridDetailsViewController: UIViewController, UIGestureRecognizerDelegate{

    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var backdropView: UIImageView!
    var movie: [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
        
        let baseUrl = "https://image.tmdb.org/t/p/w154"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)!
        posterView.af_setImage(withURL: posterUrl)
        
        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)!
        backdropView
            .af_setImage(withURL: backdropUrl)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(sender:)))
        tap.delegate = self
        posterView.addGestureRecognizer(tap)
        
        
    }
    @objc func viewTapped(sender: UITapGestureRecognizer) {
        print("View Tapped")
        performSegue(withIdentifier: "trailerSegue", sender: nil)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let trailerViewController = segue.destination as! TrailerViewController
        
        trailerViewController.movie = movie
    }
    

}
