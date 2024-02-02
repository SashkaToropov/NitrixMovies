//
//  TabBarController.swift
//  NitrixMovies
//
//  Created by  Toropov Oleksandr on 02.02.2024.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupTabs()
        self.tabBar.isTranslucent = true
        self.tabBar.unselectedItemTintColor = .gray
    }
    
    private func setupTabs() {
        let movieListViewController = self.createNavigationController(viewController: MovieListViewController(), title: "Movies", image: UIImage(systemName: "movieclapper"))
        let favoriteViewController = self.createNavigationController(viewController: FavoriteViewController(), title: "Favorite", image: UIImage(systemName: "star"))
        
        self.setViewControllers([movieListViewController, favoriteViewController], animated: true)
    }
    
    private func createNavigationController(viewController: UIViewController, title: String, image: UIImage?) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        return navigationController
    }
}
