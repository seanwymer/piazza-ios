//
//  NavMenuComponent.swift
//  Piazza
//
//  Created by Sean Wymer on 6/19/24.
//

import Strada
import UIKit

final class NavMenuComponent: BridgeComponent {
    override class var name: String { "nav-menu" }
    
    override func onReceive(message: Message) {
        switch message.event {
        case "connect":
            renderMenuItems(message: message)
        case "disconnect":
            viewController?.navigationItem.rightBarButtonItems = []
        default:
            print("Unknown message type: \(message)")
        }
    }
    
    private func renderMenuItems(message: Message) {
        guard let data: MessageData = message.data() else { return }
        createBarButtonItems(data.items)
    }
    
    private func createBarButtonItems(_ items: [MenuItem]) {
        guard let viewController else { return }
        
        var barButtonItems =
        viewController.navigationItem.rightBarButtonItems ??
        [UIBarButtonItem] ()
        
        items.forEach { item in
            barButtonItems.append(createBarButtonItem(item))
        }
        
        viewController
            .navigationItem
            .rightBarButtonItems = barButtonItems
    }
    
    private func createBarButtonItem(_ item: MenuItem)
    -> UIBarButtonItem {
        let barButton =
        UIBarButtonItem(
            title: item.title,
            style: .plain,
            target: self,
            action: #selector(sendSelectedMessage)
        )
        
        barButton.tag = item.index
        
        return barButton
    }
    
    @objc func sendSelectedMessage(barButton: UIBarButtonItem) {
        reply(
            to: "connect",
            with: ResponseData(selectedIndex: barButton.tag)
        )
    }
    
    private var viewController: UIViewController? {
        delegate.destination as? UIViewController
    }
}

private extension NavMenuComponent {
    struct MessageData: Decodable {
        let items: [MenuItem]
    }
    
    struct MenuItem: Decodable {
        let title: String
        let index: Int
        let icon: String?
    }
    
    struct ResponseData: Encodable {
        let selectedIndex: Int
    }
}
