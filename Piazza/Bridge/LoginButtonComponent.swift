//
//  LoginButtonComponent.swift
//  Piazza
//
//  Created by Sean Wymer on 6/19/24.
//

import Strada
import UIKit

final class LoginButtonComponent: BridgeComponent {
    override class var name: String { "login-button" }
    
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
        createLoginButtonItems(data.items)
    }
    
    private func createLoginButtonItems(_ items: [MenuItem]) {
        guard let viewController else { return }
        
        var loginButtonItems =
        viewController.navigationItem.rightBarButtonItems ??
        [UIBarButtonItem] ()
        
        items.forEach { item in
            loginButtonItems.append(createLoginButtonItem(item))
        }
        
        viewController
            .navigationItem
            .rightBarButtonItems = loginButtonItems
    }
    
    private func createLoginButtonItem(_ item: MenuItem)
    -> UIBarButtonItem {
        let loginButton =
        UIBarButtonItem(
            title: item.title,
            style: .plain,
            target: self,
            action: #selector(sendSelectedMessage)
        )
        
        loginButton.tag = item.index
        
        return loginButton
    }
    
    @objc func sendSelectedMessage(loginButton: UIBarButtonItem) {
        reply(
            to: "connect",
            with: ResponseData(selectedIndex: loginButton.tag)
        )
    }
    
    private var viewController: UIViewController? {
        delegate.destination as? UIViewController
    }
}

private extension LoginButtonComponent {
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

    
    

