//
//  NavigationBarController.swift
//  test1
//
//  Created by Артем Макар on 9.04.23.
//

import UIKit
//
final class NavBarController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    private func configure() {
      view.backgroundColor = .white
    }
}
