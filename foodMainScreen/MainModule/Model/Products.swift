//
//  Products.swift
//  test1
//
//  Created by Артем Макар on 7.04.23.
//

import Foundation

struct Products: Codable {
    let type: String
    let products: [Product]
    let offset, number, totalProducts, processingTimeMS: Int
    let expires: Int

    enum CodingKeys: String, CodingKey {
        case type, products, offset, number, totalProducts
        case processingTimeMS = "processingTimeMs"
        case expires
    }
}

// MARK: - Product
struct Product: Codable {
    var numberID: String?
    let id: Int
    let title: String
    let price: Double?
//    let likes: Int
//    let badges, importantBadges: [String]
//    let nutrition: Nutrition
//    let servings: Servings
//    let spoonacularScore: Double
//    let breadcrumbs: [Breadcrumb]
    let aisle, description: String?
    let image: String
//    let imageType: String
//    let images: [String]
    let generatedText: String?
//    let upc, brand: String
//    let ingredients: [Ingredient]
//    let ingredientCount: Int
//    let ingredientList: String
}

enum Breadcrumb: String, Codable {
    case mainDish = "main dish"
    case menuItemType = "menu item type"
    case pizza = "pizza"
}

// MARK: - Ingredient
struct Ingredient: Codable {
    let name: String
    let safetyLevel: SafetyLevel?
    let description: String?

    enum CodingKeys: String, CodingKey {
        case name
        case safetyLevel = "safety_level"
        case description
    }
}

enum SafetyLevel: String, Codable {
    case controversial = "controversial"
    case high = "high"
    case medium = "medium"
}

// MARK: - Nutrition
struct Nutrition: Codable {
    let nutrients: [Nutrient]
    let caloricBreakdown: CaloricBreakdown
    let calories: Int
    let fat, protein: String
    let carbs: String?
}

// MARK: - CaloricBreakdown
struct CaloricBreakdown: Codable {
    let percentProtein, percentFat, percentCarbs: Double
}

// MARK: - Nutrient
struct Nutrient: Codable {
    let name: String
    let amount: Double
    let unit: Unit
    let percentOfDailyNeeds: Double
}

enum Unit: String, Codable {
    case g = "g"
    case iu = "IU"
    case kcal = "kcal"
    case mg = "mg"
}

// MARK: - Servings
struct Servings: Codable {
    let number: Int
    let size: Double
    let unit: String
}
