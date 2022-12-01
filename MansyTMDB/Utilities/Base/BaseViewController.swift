//
//  BaseViewController.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 25/11/2022.
//

import UIKit
import Combine
import MansyTMDBCore

class BaseViewController: UIViewController, Storyboarded {

    var subscriptions: [AnyCancellable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkMonitor.shared.startMonitoring()
        // Do any additional setup after loading the view.
    }
    
    func showAlert(title: String, body: String? = nil, actions: [UIAlertAction] = [.close]){
        let alert = UIAlertController(title: title, message: body, preferredStyle: .alert)
        actions.forEach { action in
            alert.addAction(action)
        }
        present(alert,animated: true)
    }

    func navigateTo(_ vc: UIViewController){
        if let nvc = navigationController{
            nvc.pushViewController(vc, animated: true)
        }else{
            let nvc = NavigationContollerBuilder.build(rootViewController: vc)
            present(nvc, animated: true)
        }
    }

}
