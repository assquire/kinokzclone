//
//  ViewController.swift
//  kinokzclone
//
//  Created by Askar on 17.01.2023.
//

import UIKit
import SnapKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let vc1 = UINavigationController(rootViewController: PosterViewController())
        let vc2 = UINavigationController(rootViewController: PlacesViewController())
        let vc3 = UINavigationController(rootViewController: TicketsViewController())
        let vc4 = UINavigationController(rootViewController: ProfileViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "film")
        vc1.tabBarItem.selectedImage = UIImage(systemName: "film.fill")
        vc2.tabBarItem.image = UIImage(systemName: "globe.central.south.asia")
        vc2.tabBarItem.selectedImage = UIImage(systemName: "globe.central.south.asia.fill")
        vc3.tabBarItem.image = UIImage(systemName: "ticket")
        vc3.tabBarItem.selectedImage = UIImage(systemName: "ticket.fill")
        vc4.tabBarItem.image = UIImage(systemName: "person")
        vc4.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        
        vc1.title = "Афиша"
        vc2.title = "Места"
        vc3.title = "Мои билеты"
        vc4.title = "Профиль"
        
        tabBar.tintColor = .label
        
        setViewControllers([vc1, vc2, vc3, vc4], animated: true)
    }
}

