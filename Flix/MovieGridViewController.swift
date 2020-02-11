//
//  MovieGridViewController.swift
//  Flix
//
//  Created by Marco Aguilera on 2/10/20.
//  Copyright © 2020 Marco Aguilera. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var movies = [[String:Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        
      
        layout.minimumInteritemSpacing = -10
        // layout.minimumLineSpacing = layout.minimumInteritemSpacing
        // layout.sectionInset = CGSize(width: <#T##CGFloat#>, height: <#T##CGFloat#>)
    
        
        // let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / 3
        //layout.itemSize = CGSize(width: width - 10, height: width * 3 / 2)
//        )
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.itemSize = CGSize(width: (self.collectionView.frame.size.width - 30) / 2, height:(
        self.collectionView.frame.size.height) / 3)

        
        // let width = view.frame.size.width / 2
        // layout.itemSize = CGSize(width: width, height: width * 1.5)
        

        // Do any additional setup after loading the view.
        let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
             let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
             let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
             let task = session.dataTask(with: request) { (data, response, error) in
                // This will run when the network request returns
                if let error = error {
                   print(error.localizedDescription)
                } else if let data = data {
                   let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

                    self.movies = dataDictionary["results"] as! [[String:Any]]
                    self.collectionView.reloadData() 
                }
             }
             task.resume()
        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
        let movie = movies[indexPath.item]
        let baseUrl = "https://image.tmdb.org/t/p/w780"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)!
        cell.posterView.af_setImage(withURL: posterUrl)
        
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)
        let movie = movies[indexPath!.row]
        let gridDetailsViewController = segue.destination as! MovieGridDetailsViewController
        gridDetailsViewController.movie = movie
        
    }
    

    
}

