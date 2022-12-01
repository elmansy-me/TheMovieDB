//
//  LoadingManager.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 30/11/2022.
//

import Foundation
import UIKit
import Lottie

class LoadingManager{
    
    private var indicatorView: LoadingView!
    private var animationView: LottieAnimationView!

    func start() {
        guard let window = UIApplication.shared.keyWindow else { return }
        let width = window.frame.width
        let height = window.frame.height
        indicatorView = LoadingView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        indicatorView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        animationView = .init(name: "loading")
        animationView.frame = CGRect(x: width / 2 - 60, y: height / 2 - 60, width: 120, height: 120)
        animationView?.animationSpeed = 2.5
        animationView?.loopMode = .loop
        indicatorView.addSubview(animationView)
        animationView?.play()
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        window.addSubview(indicatorView)
    }
    
    func stop() {
        guard let window = UIApplication.shared.keyWindow else { return }
        if let view = window.subviews.first(where: { $0 is LoadingView }){
            view.removeFromSuperview()
        }
    }
    
    func isLoading()-> Bool {
        guard let window = UIApplication.shared.keyWindow else { return false }
        return window.subviews.first(where: { $0 is LoadingView }) != nil
    }
    
}
