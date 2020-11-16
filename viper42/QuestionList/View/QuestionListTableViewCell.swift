//
//  QuestionListTableViewCell.swift
//  viper42
//
//  Created by Udo von Eynern on 07.12.18.
//  Copyright © 2018 Udo von Eynern. All rights reserved.
//

import UIKit

class QuestionListTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewUser: UIImageView!
    @IBOutlet weak var imageViewCover: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    func set(forQuestion question: Question) {
        
        let scaleFactor = UIScreen.main.scale
        let width = Int(round(152.0 * scaleFactor))
        let height = Int(round(152.0 * scaleFactor))
        var urlString = ""
        
        // if we have an image for given question
        if let imagePath = question.imagePath {
            if imagePath.isEmpty == false {
                urlString = API.ImageURL(filename: imagePath, width: width, height: height)
            }
        } else {
            urlString = API.GoogleMapsURL(latitude: question.latitude, longitude: question.longitude, width: width, height: height)
        }
            
        if urlString.isEmpty == false {
            /*
            if let url = URL(string: urlString) {
                self.imageViewCover.af_setImage(withURL: url)
            }
             */
        }
        
        self.titleLabel.text = question.title
        
        if question.distance > 0.0 {
            let distance = String(format: "%.2f entfernt", (question.distance * 1.609344))
            self.descriptionLabel.text = distance
        } else {
            self.descriptionLabel.text = ""
        }
        
        self.backgroundColor = UIColor.clear
        self.backgroundView = UIView.init()
        self.contentView.backgroundColor = UIColor.clear
        
        //self.usernameLabel.text = question.userId
        
        
        
    }
}
