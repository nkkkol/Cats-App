//
//  Breed.swift
//  Cats
//
//  Created by Inna Litvinenko on 5/4/20.
//  Copyright © 2020 Inna Litvinenko. All rights reserved.
//

import Foundation

class Breed : Decodable {
    var imperial = String()
    var metric = String()

    var id = String()
    var name = String()
    var temperament = String()
    var origin = String()
    var country_code = String()
    
    var description = String()
    var life_span = String()
    
    var indoor: Int = -1
    var lap: Int = -1
    var alt_names = String()
    var adaptability: Int = -1
    var affection_level: Int = -1
    var child_friendly: Int = -1
    var dog_friendly: Int = -1
    var energy_level: Int = -1
    var grooming: Int = -1
    var health_issues: Int = -1
    var intelligence: Int = -1
    var shedding_level: Int = -1
    var social_needs: Int = -1
    var stranger_friendly: Int = -1
    var vocalisation: Int = -1
    var experimental: Int = -1
    var hairless: Int = -1
    var natural: Int = -1
    var rare: Int = -1
    var rex: Int = -1
    var suppressed_tail: Int = -1
    var short_legs: Int = -1
    var hypoallergenic: Int = -1
    
    enum CodingKeys: String, CodingKey {
        case weight
        case id
        case name
        case temperament
        case origin
        case country_code
        case description
        case life_span
        case indoor
        case lap
        case alt_names
        case adaptability
        case affection_level
        case child_friendly
        case dog_friendly
        case energy_level
        case grooming
        case health_issues
        case intelligence
        case shedding_level
        case social_needs
        case stranger_friendly
        case vocalisation
        case experimental
        case hairless
        case natural
        case rare
        case rex
        case suppressed_tail
        case short_legs
        case hypoallergenic
       }
    
    enum WeightCodingKeys: String, CodingKey {
        case imperial
        case metric
    }
       
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            self.name = try container.decode(String.self, forKey: .name)
            self.id = try container.decode(String.self, forKey: .id)
            self.temperament = try container.decode(String.self, forKey: .temperament)
            self.origin = try container.decode(String.self, forKey: .origin)
            self.country_code = try container.decode(String.self, forKey: .country_code)
            self.description = try container.decode(String.self, forKey: .description)
            self.life_span = try container.decode(String.self, forKey: .life_span)
        }
        catch {}
        do {
            self.indoor = try container.decode(Int.self, forKey: .indoor)
        } catch {}
        do {
            self.lap = try container.decode(Int.self, forKey: .lap)
        } catch {}
        do {
            self.alt_names = try container.decode(String.self, forKey: .alt_names)
        } catch {}
        do {
            self.adaptability = try container.decode(Int.self, forKey: .adaptability)
        }catch {}
        do {
            self.affection_level = try container.decode(Int.self, forKey: .affection_level)
        }catch {}
        do {
            self.child_friendly = try container.decode(Int.self, forKey: .child_friendly)
        }catch {}
        do {
            self.dog_friendly = try container.decode(Int.self, forKey: .dog_friendly)
        }catch {}
        do {
            self.energy_level = try container.decode(Int.self, forKey: .energy_level)
        }catch {}
        do {
            self.grooming = try container.decode(Int.self, forKey: .grooming)
        } catch {}
        do {
            self.health_issues = try container.decode(Int.self, forKey: .health_issues)
        } catch {}
        do {
            self.intelligence = try container.decode(Int.self, forKey: .intelligence)
        } catch {}
        do {
            self.shedding_level = try container.decode(Int.self, forKey: .shedding_level)
        }  catch {}
        do {
            self.social_needs = try container.decode(Int.self, forKey: .social_needs)
        }  catch {}
        do {
            self.stranger_friendly = try container.decode(Int.self, forKey: .stranger_friendly)
        } catch {}
        do {
            self.vocalisation = try container.decode(Int.self, forKey: .vocalisation)
        } catch {}
        do {
            self.experimental = try container.decode(Int.self, forKey: .experimental)
        }   catch {}
        do {
            self.hairless = try container.decode(Int.self, forKey: .hairless)
        }  catch {}
        do {
            self.natural = try container.decode(Int.self, forKey: .natural)
        }  catch {}
        do {
            self.rare = try container.decode(Int.self, forKey: .rare)
        }catch {}
        do {
            self.rex = try container.decode(Int.self, forKey: .rex)
        } catch {}
        do {
            self.suppressed_tail = try container.decode(Int.self, forKey: .suppressed_tail)
        } catch {}
        do {
            self.short_legs = try container.decode(Int.self, forKey: .short_legs)
        }  catch {}
        do {
            self.hypoallergenic = try container.decode(Int.self, forKey: .hypoallergenic)
        }  catch {}
                                                                                       
        let cameraContainer = try container.nestedContainer(keyedBy: WeightCodingKeys.self, forKey: .weight)
        do {
            self.imperial = try cameraContainer.decode(String.self, forKey: .imperial)
            self.metric = try cameraContainer.decode(String.self, forKey: .metric)
        }
        catch{}
    }

}
