//
//  TrailerViewController.swift
//  Flix
//
//  Created by Marco Aguilera on 2/11/20.
//  Copyright © 2020 Marco Aguilera. All rights reserved.
//

import UIKit
import WebKit
import SwiftUI

class TrailerViewController: UIViewController, WKUIDelegate{
    var webView: WKWebView!
    var movie: [String:Any]!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        var movie_id = "\(String(describing: movie["id"]))"
        movie_id = movie_id.filter("0123456789.".contains)
        
        
        var base = "https://api.themoviedb.org/3/movie/"
        base = base + movie_id + "/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US"

        var trailers = [[String:Any]]()
        let url = URL(string: base)!
                let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
                let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
                let task = session.dataTask(with: request) { (data, response, error) in
                   // This will run when the network request returns
                   if let error = error {
                      print(error.localizedDescription)
                   } else if let data = data {
                      let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                        
                    trailers = dataDictionary["results"] as! [[String: Any]]
                    let url_a = "https://www.youtube.com/watch?v=" + (trailers[0]["key"] as! String)
                    let myURL = URL(string: url_a)
                    let myRequest = URLRequest(url: myURL!)
                    self.webView.load(myRequest)
                   }
                }
                task.resume()

        
        print(trailers)

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

