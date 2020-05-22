//
//  BreedInfoViewController.swift
//  Cats
//
//  Created by Inna Litvinenko on 5/5/20.
//  Copyright © 2020 Inna Litvinenko. All rights reserved.
//

import UIKit

class BreedInfoViewController: UIViewController {
    
    var modelController = ModelController()
    var index = Int()
    
    let pointsInterpreter = [-1 : "No information", 0 : "Absolutely not", 1: "No", 2 : "Not really", 3 : "50/50", 4 : "Almost yes", 5 : "Yes"]
    
    @IBOutlet weak var stackView: UIStackView!
    

    let imageBlock = (UINib(nibName: "CatImageView", bundle: nil).instantiate(withOwner: self, options: nil).first as? CatImageView)
    let descriptionBlock = (UINib(nibName: "DescriptionView", bundle: nil).instantiate(withOwner: self, options: nil).first as? DescriptionView)
    let loadingIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = modelController.catBreeds[index].name
        modelController.fetcher.getImage(modelController.catBreeds[index].id, index, imageBlock?.catImage ?? UIImageView())
       setBlocks()
        
    }
    
    func setBlocks() {
        loadingIndicator.center = imageBlock?.backgroundView.center ?? CGPoint()
        loadingIndicator.startAnimating()
        imageBlock?.backgroundView.addSubview(loadingIndicator)

        imageBlock?.newImageButton.addTarget(self, action: #selector(newImageButtonTapped), for: .touchDown)
        
        stackView.addArrangedSubview(imageBlock ?? UIView())
        
        descriptionBlock?.descriptionLabel.sizeToFit()
        descriptionBlock?.descriptionLabel.text = modelController.catBreeds[index].description
        descriptionBlock?.lifespanLabel.text = modelController.catBreeds[index].life_span + " years"
        descriptionBlock?.originLabel.text = modelController.catBreeds[index].origin
        descriptionBlock?.temperLabel.text = modelController.catBreeds[index].temperament
        descriptionBlock?.weightLabel.text =  modelController.catBreeds[index].imperial + " lb"
        
        descriptionBlock?.imperialMetric.addTarget(self, action: #selector(change), for: .touchDown)
        
        descriptionBlock?.lapLabel.text = pointsInterpreter[modelController.catBreeds[index].lap]
        descriptionBlock?.energyLabel.text = pointsInterpreter[modelController.catBreeds[index].energy_level]
        descriptionBlock?.adaptabilityLabel.text = pointsInterpreter[modelController.catBreeds[index].adaptability]
        descriptionBlock?.childLabel.text = pointsInterpreter[modelController.catBreeds[index].child_friendly]
        descriptionBlock?.dogLabel.text = pointsInterpreter[modelController.catBreeds[index].dog_friendly]
        descriptionBlock?.strangerLabel.text = pointsInterpreter[modelController.catBreeds[index].stranger_friendly]
        descriptionBlock?.vocalLabel.text = pointsInterpreter[modelController.catBreeds[index].vocalisation]
        descriptionBlock?.sheddingLabel.text = pointsInterpreter[modelController.catBreeds[index].shedding_level]
        descriptionBlock?.healthLabel.text = pointsInterpreter[modelController.catBreeds[index].health_issues]
        descriptionBlock?.intelligenceLabel.text = pointsInterpreter[modelController.catBreeds[index].intelligence]
        descriptionBlock?.socialLabel.text = pointsInterpreter[modelController.catBreeds[index].social_needs]
        descriptionBlock?.affectionLabel.text = pointsInterpreter[modelController.catBreeds[index].affection_level]
        descriptionBlock?.hypoalLabel.text = modelController.catBreeds[index].hypoallergenic == 1 ? "Yes" : "No"
        
        stackView.addArrangedSubview(descriptionBlock ?? UIView())
        
    }
    
    @objc func newImageButtonTapped() {
        imageBlock?.catImage.isHidden = true
        modelController.fetcher.getImage(modelController.catBreeds[index].id, index, imageBlock?.catImage ?? UIImageView())
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.imageBlock?.catImage.isHidden = false
        }
    }
    
    @objc func change() {
        let defaultFlag = true
        if descriptionBlock?.isImperial ?? defaultFlag {
            descriptionBlock?.weightLabel.text =  modelController.catBreeds[index].metric + " kg"
            descriptionBlock?.isImperial = false
            
        }
        else {
            descriptionBlock?.weightLabel.text =  modelController.catBreeds[index].imperial + " lb"
            descriptionBlock?.isImperial = true
        }
    }


}
