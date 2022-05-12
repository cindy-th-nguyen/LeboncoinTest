//
//  Publication.swift
//  LeBonCoin
//
//  Created by Cindy Nguyen on 04/05/2022.
//

import Foundation
import UIKit

struct Publication: Codable {
    var id: Double
    var categoryId: Int
    var title: String
    var description: String
    var price: Float
    var imagesUrl: [String:String]?
    var creationDate: String
    var isUrgent: Bool
    
    var thumb: String?
    var small: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case categoryId = "category_id"
        case title = "title"
        case description = "description"
        case price = "price"
        case imagesUrl = "images_url"
        case creationDate = "creation_date"
        case isUrgent = "is_urgent"
        case thumb = "thumb"
        case small = "small"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Double.self, forKey: .id)!
        categoryId = try values.decodeIfPresent(Int.self, forKey: .categoryId)!
        title = try values.decodeIfPresent(String.self, forKey: .title)!
        description = try values.decodeIfPresent(String.self, forKey: .description)!
        price = try values.decodeIfPresent(Float.self, forKey: .price)!
        imagesUrl = try values.decodeIfPresent([String: String].self, forKey: .imagesUrl)
                if let urls = self.imagesUrl {
                    self.thumb = urls["thumb"]
                    self.small = urls["small"]
                }
        creationDate = try values.decodeIfPresent(String.self, forKey: .creationDate)!
        isUrgent = try values.decodeIfPresent(Bool.self, forKey: .isUrgent)!
        
    }
}


