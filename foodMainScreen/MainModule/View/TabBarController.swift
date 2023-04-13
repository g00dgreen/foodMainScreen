//
//  TabBarController.swift
//  test1
//
//  Created by Артем Макар on 9.04.23.
//

import UIKit

enum Tabs: Int {
    case menu
    case contacts
    case profile
    case basket
}

final class TabBarController: UITabBarController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configue()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configue(){
        
        tabBar.backgroundColor = .white
        tabBar.tintColor = Resources.Colors.active
        tabBar.barTintColor = Resources.Colors.inactive
        
        tabBar.layer.borderColor = Resources.Colors.separator!.cgColor
        tabBar.layer.borderWidth = 1
        tabBar.layer.masksToBounds = true
        tabBar.layer.shadowRadius = 10
        
        let menuController = ModelBuilder.createMainModule()
        let contactsController = UIViewController()
        let profileController = UIViewController()
        let basketController = UIViewController()
        
        let menuNavigation = NavBarController(rootViewController: menuController)
        let contactsNavigation = NavBarController(rootViewController: contactsController)
        let profileNavigation = NavBarController(rootViewController: profileController)
        let basketNavigation = NavBarController(rootViewController: basketController)
        
        menuController.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.menu,
                                                 image: Resources.Images.menu,
                                                 tag: Tabs.menu.rawValue)
        contactsController.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.contacts,
                                                 image: Resources.Images.contacts,
                                                 tag: Tabs.contacts.rawValue)
        profileController.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.profile,
                                                 image: Resources.Images.profile,
                                                 tag: Tabs.profile.rawValue)
        basketController.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.basket,
                                                 image: Resources.Images.basket,
                                                 tag: Tabs.basket.rawValue)
        basketController.tabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 13)], for: .normal)
        contactsController.tabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 13)], for: .normal)
        profileController.tabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 13)], for: .normal)
        menuController.tabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 13)], for: .normal)
        setViewControllers([
            menuNavigation,
            contactsNavigation,
            profileNavigation,
            basketNavigation
        ], animated: false)
    }

    
    
}
