//
//  RootViewController.swift
//  Piazza
//
//  Created by Sean Wymer on 6/18/24.
//

import UIKit

class RootViewController: UITabBarController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        let tabBarAppearance = UITabBarAppearance()
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp() {
        var viewControllers = [UIViewController]()
        
        Self.tabs.forEach { tab in
            let vc = ViewControllerVendor.viewController(for: tab.url)
            viewControllers
                .append(RoutingController(rootViewController: vc))
        }
        
        self.viewControllers = viewControllers
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension RootViewController {
    static let tabs = [
        Tab(url: Api.rootURL, icon: "house.fill", titleKey: "tab.home"),
        Tab(url: Api.rootURL, icon: "bookmark.fill", titleKey: "tab.savedAds"),
        Tab(url: Api.rootURL, icon: "message.fill", titleKey: "tab.messages"),
        Tab(url: Api.rootURL, icon: "rectangle.stack.badge.person.crop.fill", titleKey: "tab.myAds"),
        Tab(url: Api.Path.profile, icon: "person.fill", titleKey: "tab.profile")
    ]
    
    struct Tab {
        let url: URL
        let icon: String
        let titleKey: String
    }
}
