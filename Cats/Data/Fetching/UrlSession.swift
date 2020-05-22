//
//  UrlSession.swift
//  Cats
//
//  Created by Inna Litvinenko on 5/4/20.
//  Copyright © 2020 Inna Litvinenko. All rights reserved.
//

import UIKit

struct UrlSession {
    
    func getBreeds(_ tableView: UITableView, _ modelController : ModelController) {
        let session = URLSession.shared
        if let url = URL(string: "https://api.thecatapi.com/v1/breeds?api_key=d3f3f448-ab7a-4cf7-9898-417761a99c1b")  {
        _ = session.dataTask(with: url, completionHandler: { data, response, error in
            do {
                let name = try JSONDecoder().decode([Breed].self, from: data!)
                modelController.catBreeds = name
                var tmpindex = 0
                modelController.catBreeds.forEach { breed in
                    modelController.breedIndex[breed.name] = tmpindex
                    tmpindex += 1
                }
                DispatchQueue.main.async {
                    tableView.reloadData()
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }).resume()
        }
    }
    
    func getImage( _ breedId: String, _ index: Int, _ imageView: UIImageView) {
        let session = URLSession.shared
        if let url = URL(string: "https://api.thecatapi.com/v1/images/search?breed_id=\(breedId)&api_key=d3f3f448-ab7a-4cf7-9898-417761a99c1b") {
            _ = session.dataTask(with: url, completionHandler: { data, response, error in
                do {
                    let image = try JSONDecoder().decode([CatImage].self, from: data!)
                    if let imageUrl = URL(string: image[0].url) {
                        self.downloadImage(imageUrl, index, imageView)
                        }
                }
                catch {
                    print(error.localizedDescription)
                }
            }).resume()
        }
    }
    
    func downloadImage(_ url: URL, _ index: Int, _ imageView: UIImageView) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                    imageView.image = image
                }
            }
        }
        task.resume()
    }


}
