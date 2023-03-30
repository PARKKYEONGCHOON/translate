//
//  TabBarController.swift
//  Translate
//
//  Created by 박경춘 on 2023/03/29.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let translateViewController = TranlateViewController()
        translateViewController.tabBarItem = UITabBarItem(
            title: NSLocalizedString("Translate", comment: "번역"),
            image: UIImage(systemName: "mic"),
            selectedImage: UIImage(systemName: "mic.fill")
        )
        
        let bookmarkViewController = UINavigationController(rootViewController: BookmarkListViewController())
        bookmarkViewController.tabBarItem = UITabBarItem(
            title: NSLocalizedString("Bookmark", comment: "즐겨찾기"),
            image: UIImage(systemName: "star"),
            selectedImage: UIImage(systemName: "star.fill")
        )
        
        viewControllers = [translateViewController,bookmarkViewController]
        
    }


}

