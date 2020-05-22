//
//  DBManager.swift
//  Cats
//
//  Created by Inna Litvinenko on 5/6/20.
//  Copyright © 2020 Inna Litvinenko. All rights reserved.
//

import Foundation
import CoreData

class DBManager {
    
    static var share = DBManager()
    let manageContext = appDelegate?.persistentContainer.viewContext
    
    var favouriteBreeds: [FavouriteBreed]? {
        get {
            return getData()
        }
    }
    
    func getData() -> [FavouriteBreed]? {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteBreed")
        
        do {
            return try manageContext?.fetch(request) as? [FavouriteBreed]
        } catch {
            print("Error when getting data")
            return nil
        }
    }
    
    func saveBreed(breed: Breed) {
        guard let manageContext = manageContext else { return }
        let favBreed = FavouriteBreed(context: manageContext)
        favBreed.name = breed.name
        favBreed.id = breed.id
        favBreed.adaptability = Int16(breed.adaptability)
        favBreed.affection_level = Int16(breed.affection_level)
        favBreed.alt_names = breed.alt_names
        favBreed.child_friendly = Int16(breed.child_friendly)
        favBreed.dog_friendly = Int16(breed.dog_friendly)
        favBreed.stranger_friendly = Int16(breed.stranger_friendly)
        favBreed.vocalisation = Int16(breed.vocalisation)
        favBreed.country_code = breed.country_code
        favBreed.imperial_weight = breed.imperial
        favBreed.metric_weight = breed.metric
        favBreed.energy_level = Int16(breed.energy_level)
        favBreed.origin = breed.origin
        favBreed.description_ = breed.description
        favBreed.hairless = Int16(breed.hairless)
        favBreed.grooming = Int16(breed.grooming)
        favBreed.rex = Int16(breed.rex)
        favBreed.rare = Int16(breed.rare)
        favBreed.experimental = Int16(breed.experimental)
        favBreed.health_issues = Int16(breed.health_issues)
        favBreed.hypoallergenic = Int16(breed.hypoallergenic)
        favBreed.indoor = Int16(breed.indoor)
        favBreed.intelligence = Int16(breed.intelligence)
        favBreed.temperament = breed.temperament
        favBreed.lap = Int16(breed.lap)
        favBreed.life_span = breed.life_span
        favBreed.natural = Int16(breed.natural)
        favBreed.shedding_level = Int16(breed.shedding_level)
        favBreed.short_legs = Int16(breed.short_legs)
        favBreed.social_needs = Int16(breed.social_needs)
        favBreed.suppressed_tail = Int16(breed.suppressed_tail)
        saveContext()
    }
    
    private func saveContext() {
        do {
            try manageContext?.save()
        } catch {
            print("Error when saving manageContext")
        }
    }
    
    func delete(breed: FavouriteBreed) {
        manageContext?.delete(breed)
        saveContext()
    }
}
