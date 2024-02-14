//
//  Product.swift
//  JSONDecoder_CodingKeyProtocol
//
//  Created by Mac on 08/01/24.
//

import Foundation
struct Product : Decodable
{
    var id : Int
    var productName : String
    var price : Double
    var rate : Double
    var count : Int
    //var rating : [Rating]
    
    enum ProductKeys : String , CodingKey
    {
        case id
        case productName = "title"
        case price
        case rating

    }
    enum RatingKeys : CodingKey
    {
        case rate
        case count
    }
    init(from decoder: Decoder) throws {
        let productContainer = try! decoder.container(keyedBy: ProductKeys.self)
        self.id = try! productContainer.decode(Int.self, forKey: .id)
        self.price = try! productContainer.decode(Double.self, forKey: .price)
        self.productName = try! productContainer.decode(String.self, forKey: .productName)
        
        let ratingContainer = try! productContainer.nestedContainer(keyedBy: RatingKeys.self, forKey: .rating)
        
        self.rate = try! ratingContainer.decode(Double.self, forKey: .rate)
        self.count = try! ratingContainer.decode(Int.self, forKey: .count)
    }
    
    
}
//struct Rating : Decodable{
//    var rate : Double
//    var count : Int
//}
