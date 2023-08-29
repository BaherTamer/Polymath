//
//  MainTabBarController.swift
//  Polymath
//
//  Created by Baher Tamer on 24/08/2023.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().tintColor = .systemPink
        
        setupTabBarViewControllers()
    }
    
}

// MARK: - Setup Functions
extension MainTabBarController {
    
    private func setupTabBarViewControllers() {
        
        tabBar.tintColor = .systemPink
        
        viewControllers = [
            setupNavigationController(for: ViewController(), title: "Following", imageName: "headphones.circle"),
            setupNavigationController(for: SearchTableViewController(), title: "Search", imageName: "magnifyingglass.circle"),
            setupNavigationController(for: ViewController(), title: "Downloaded", imageName: "arrow.down.circle")
        ]
    }
    
    private func setupNavigationController(for rootViewController: UIViewController, title: String, imageName: String) -> UINavigationController {
        
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = UIImage(systemName: imageName)
        navigationController.tabBarItem.selectedImage = UIImage(systemName: "\(imageName).fill")
        
        rootViewController.navigationItem.title = title
        
        return navigationController
    }
    
}
