//
//  TableViewCell.swift
//  test1
//
//  Created by Артем Макар on 5.04.23.
//

import UIKit

class AdCell: UITableViewCell {
    @IBOutlet private var foodImage: UIImageView!
    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet private var buyBotton: UIButton!
    
    

    
    func config(image: String?, header: String, description: String?) {
        
        headerLabel.text = header
        headerLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
        var textForDescription = ""
        for i in 1...Int.random(in: 1...5) {
            textForDescription += "\(header)"
        }
        descriptionLabel.text = textForDescription
        descriptionLabel.font = UIFont.systemFont(ofSize: 13)
        descriptionLabel.textColor = UIColor(red: 0.665, green: 0.668, blue: 0.679, alpha: 1)

        buyBotton.setTitle("От 320 р", for: .normal)
        buyBotton.tintColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 1)
        buyBotton.layer.cornerRadius = 6
        buyBotton.layer.borderWidth = 1
        buyBotton.layer.borderColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 1).cgColor

        if let stringImage = image {
            if let url = URL(string: stringImage) {
                let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                  if let data = data {
                    DispatchQueue.main.async {
                        self?.foodImage.image = UIImage(data: data)
                    }
                }

                }
                task.resume()
            }
        } else {
            foodImage.image = UIImage(named: "1")
        }
        
    }
}
