//
//  ViewController.swift
//  Separation_Concern
//
//  Created by Sateesh Dara on 08/09/18.
//  Copyright © 2018 Sateesh Dara. All rights reserved.
//
import UIKit

class DetailedCourseController: UITableViewController {
    
    let cellId = "cellId"
    
    var courseDetails: [CourseDetails]?
    
    var video: Video! {
        didSet {
            let urlString = "https://api.letsbuildthatapp.com/youtube/course_detail?id=\(video.id)"
            Service.shared.fetchGenericData(urlString: urlString) { (courseDetails: [CourseDetails]) in
                self.courseDetails = courseDetails
                self.tableView.reloadData()
            }
            navigationItem.title = video.name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseDetails?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = courseDetails?[indexPath.row].name
        return cell
    }
}
