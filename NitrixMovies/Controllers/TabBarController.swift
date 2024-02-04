//
//  TabBarController.swift
//  NitrixMovies
//
//  Created by  Toropov Oleksandr on 02.02.2024.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupTabs()
        self.tabBar.isTranslucent = true
        self.tabBar.unselectedItemTintColor = .gray
    }
    
    private func setupTabs() {
        let movieListViewController = self.createNavigationController(viewController: MovieListViewController(), title: "Movies", image: UIImage(systemName: "movieclapper"))
        let favoriteViewController = self.createNavigationController(viewController: FavoritesViewController(), title: "Favorites", image: UIImage(systemName: "star"))
        
        favoriteViewController.viewControllers.first?.navigationItem.setTitle(title: "Favorites", subtitle: "Long Pressure on cell to delete from favorite⭐️")
        movieListViewController.viewControllers.first?.navigationItem.setTitle(title: "Movies", subtitle: "Long Pressure on cell to make it favorite⭐️")
        
        self.setViewControllers([movieListViewController, favoriteViewController], animated: true)
    }
    
    private func createNavigationController(viewController: UIViewController, title: String, image: UIImage?) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image

        return navigationController
    }
}
