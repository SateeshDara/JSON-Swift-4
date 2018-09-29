//
//  HomeCotroller.swift
//  Separation_Concern
//
//  Created by Sateesh Dara on 08/09/18.
//  Copyright © 2018 Sateesh Dara. All rights reserved.
//

import UIKit

class HomeController: UITableViewController {
    
    
    let cellId = " cellId"
    var isLoadingData = false
    let loaderView = UIActivityIndicatorView(style: .whiteLarge)
    var homeFeed: HomeFeed?
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString = "https://api.letsbuildthatapp.com/youtube/home_feed"
        Service.shared.fetchGenericData(urlString: urlString) { (feed: HomeFeed) in
            self.homeFeed = feed
            self.tableView.reloadData()
    }
        navigationItem.title = "Course"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeFeed?.videos.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = homeFeed?.videos[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailedCourseController = DetailedCourseController()
        detailedCourseController.video = homeFeed?.videos[indexPath.row]
        navigationController?.pushViewController(detailedCourseController, animated: true)
        
    }

}

struct CourseDetails: Decodable {
    let name: String
    let duration: String
    let imageUrl: String
}

struct Service {
    static let shared = Service()
    func fetchGenericData<T: Decodable>(urlString: String, completion: @escaping (T) -> ()) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, err) in
            if let err = err {
                print("Failed to fetch home feed:", err)
                return
            }
            
            guard let data = data else { return }
            do {
                let homeFeed = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(homeFeed)
                }
            } catch let jsonErr {
                print("Failed to serialize json:", jsonErr)
            }
            
            }.resume()
    }
}
