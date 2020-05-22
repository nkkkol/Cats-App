//
//  BreedsTableViewCell.swift
//  Cats
//
//  Created by Inna Litvinenko on 5/4/20.
//  Copyright © 2020 Inna Litvinenko. All rights reserved.
//

import UIKit

class BreedsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var temperLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    var modelController = ModelController()
    
    var isFav = false
    var index = Int()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       favouriteButton.addTarget(self, action: #selector(addToFav), for: .touchDown)
    }
    
    @objc func addToFav() {
        isFav = !isFav
        if isFav {
            favouriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            DBManager.share.saveBreed(breed: modelController.catBreeds[modelController.breedIndex[breedLabel.text ?? ""] ?? 0])
        }
        else {
            favouriteButton.setImage(UIImage(systemName: "star"), for: .normal)
            DBManager.share.favouriteBreeds?.forEach({ breed in
                if breed.name == self.breedLabel.text {
                    DBManager.share.delete(breed: breed)
                }
            })
        }
    }
}
