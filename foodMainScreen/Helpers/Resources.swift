//
//  Resources.swift
//  test1
//
//  Created by Артем Макар on 9.04.23.
//


import UIKit

enum Resources {
    enum Colors {
        static var active =  UIColor(hex: "#fd3a69ff")
        static var inactive =  UIColor(hex: "#C3C4C9ff")
        static var separator = UIColor(hex: "#c3c4c9ff")
    }
    enum Strings {
        enum TabBar {
            static var contacts = "Контакты"
            static var menu = "Меню"
            static var basket = "Корзина"
            static var profile = "Профиль"
        }
    }
    enum Images {
        static var contacts = UIImage(named: "Contacts")
        static var menu = UIImage(named: "Menu")
        static var basket = UIImage(named: "Basket")
        static var profile = UIImage(named: "Profile")
    }
}
