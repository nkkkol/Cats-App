//
//  ViewController.swift
//  Cats
//
//  Created by Inna Litvinenko on 5/4/20.
//  Copyright © 2020 Inna Litvinenko. All rights reserved.
//

import UIKit



class BreedsViewController: UIViewController {
    
    var modelController = ModelController()
    var foundBreedNames = [String]()
    var searching = false
    var isFav = false
    
    @IBOutlet weak var breedsTable: UITableView!
    @IBOutlet weak var searchBreed: UISearchBar!
    @IBOutlet weak var switchList: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    modelController.fetcher.getBreeds(breedsTable, modelController)
        breedsTable.delegate = self
        breedsTable.dataSource = self
        searchBreed.delegate = self
    }
    
    @IBAction func switchListTapped(_ sender: Any) {
        isFav = !isFav
        breedsTable.reloadData()
        self.title = !isFav ? "All breeds 🐈" : "Favourite Breeds 😻"
        searchBreed.text = ""
        searching = false
        breedsTable.reloadData()
    }
    
    
}

extension BreedsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !isFav {
            return searching ? foundBreedNames.count : modelController.catBreeds.count
        }
        else {
            return searching ? foundBreedNames.count : DBManager.share.favouriteBreeds?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("BreedsTableViewCell", owner: self)?.first as? BreedsTableViewCell
        if !isFav {
            cell?.breedLabel.text = searching ? foundBreedNames[indexPath.row] : modelController.catBreeds[indexPath.row].name
            cell?.temperLabel.text = modelController.catBreeds[indexPath.row].temperament
            DBManager.share.favouriteBreeds?.forEach({ breed in
                if breed.name == cell?.breedLabel.text {
                    cell?.isFav = true
                    cell?.favouriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
                }
            })
        }
        else {
            cell?.favouriteButton.isHidden = true
            cell?.breedLabel.text = searching ? foundBreedNames[indexPath.row] :  DBManager.share.favouriteBreeds?[indexPath.row].name
            if !searching {
                cell?.temperLabel.text = DBManager.share.favouriteBreeds?[indexPath.row].temperament
            }
            else {
                DBManager.share.favouriteBreeds?.forEach({ breed in
                    if breed.name == cell?.breedLabel.text {
                        cell?.temperLabel.text = breed.temperament
                    }
                })
            }
        }
        cell?.modelController = modelController
        cell?.index = indexPath.row
        return cell ?? BreedsTableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        breedsTable.deselectRow(at: indexPath, animated: false)
        let storyBoard: UIStoryboard = UIStoryboard(name: "BreedInfoStoryboard", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "BreedInfoViewController") as? BreedInfoViewController
        if isFav {
            newViewController?.index = searching ? modelController.breedIndex[foundBreedNames[indexPath.row]] ?? 0: modelController.breedIndex[(DBManager.share.favouriteBreeds?[indexPath.row].name ?? "")] ?? 0
        }
        else {
            newViewController?.index = (searching ? modelController.breedIndex[foundBreedNames[indexPath.row]] : modelController.breedIndex[modelController.catBreeds[indexPath.row].name]) ?? 0
        }
        self.navigationController?.pushViewController(newViewController ?? self, animated: true)
        newViewController?.modelController = self.modelController
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        if isFav {
            return UISwipeActionsConfiguration(actions: [delete])
        }
        else {
            return UISwipeActionsConfiguration(actions: [])
        }
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
       let action = UIContextualAction(style: .destructive, title: "Delete") {(action, view, completion) in
        if self.searching {
            DBManager.share.favouriteBreeds?.forEach({ breed in
                if breed.name == self.foundBreedNames[indexPath.row]  {
                    DBManager.share.delete(breed: breed)
                }
            })
            self.foundBreedNames.remove(at: indexPath.row)
        }
        else {
            if DBManager.share.favouriteBreeds?[indexPath.row] != nil {
                DBManager.share.delete(breed: ((DBManager.share.favouriteBreeds?[indexPath.row] ?? FavouriteBreed())))
        }
        }
        self.breedsTable.deleteRows(at: [indexPath], with: .automatic)
        completion(true)
        }
     return action
    }

}

extension BreedsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if isFav {
            var favBreedNames = [String]()
            DBManager.share.favouriteBreeds?.forEach({ breed in
                favBreedNames.append(breed.name ?? "")
            })
            
            foundBreedNames = favBreedNames.filter({$0.prefix(searchText.count) == searchText})
        }
        else {
            foundBreedNames = modelController.breedIndex.keys.filter({$0.prefix(searchText.count) == searchText})
        }
        searching = true
        breedsTable.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searching = false
        breedsTable.reloadData()
    }

}
