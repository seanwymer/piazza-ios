//
//  WebViewController.swift
//  Piazza
//
//  Created by Sean Wymer on 6/19/24.
//

import UIKit
import Turbo

class WebViewController: VisitableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDismissButton()
    }
    
    // Method to make sure tab title does not change when loading a new page
    override func visitableDidRender() {
        navigationItem.title = visitableView.webView?.title
    }
    
    private func configureDismissButton() {
        if presentingViewController != nil {
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                barButtonSystemItem: .close,
                target: self,
                action: #selector(dismissModal)
            )
        }
    }
    
    @objc func dismissModal() {
        dismiss(animated: true)
    }
}
