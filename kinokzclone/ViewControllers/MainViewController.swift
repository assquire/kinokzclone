//
//  ViewController.swift
//  kinokzclone
//
//  Created by Askar on 17.01.2023.
//

import UIKit
import SnapKit

final class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let vc1 = UINavigationController(rootViewController: PosterViewController())
        let vc2 = UINavigationController(rootViewController: PlacesViewController())
        let vc3 = UINavigationController(rootViewController: TicketsViewController())
        let vc4 = UINavigationController(rootViewController: ProfileViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "film")
        vc1.tabBarItem.selectedImage = UIImage(systemName: "film.fill")
        vc2.tabBarItem.image = UIImage(systemName: "safari")
        vc2.tabBarItem.selectedImage = UIImage(systemName: "safari.fill")
        vc3.tabBarItem.image = UIImage(systemName: "ticket")
        vc3.tabBarItem.selectedImage = UIImage(systemName: "ticket.fill")
        vc4.tabBarItem.image = UIImage(systemName: "person")
        vc4.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        
        vc1.title = Constants.Values.tabBarItems[0]
        vc2.title = Constants.Values.tabBarItems[1]
        vc3.title = Constants.Values.tabBarItems[2]
        vc4.title = Constants.Values.tabBarItems[3]
        
        tabBar.tintColor = .label
        
        setViewControllers([vc1, vc2, vc3, vc4], animated: true)
    }
}

