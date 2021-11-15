//
//  SplashScreenViewController.swift
//  aigoe
//
//  Created by Utari on 13/11/21.
//

import UIKit

class SplashScreenViewController: UIViewController {
    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 260, height: 92))
        imageView.image = UIImage(named: "imgLogoAigoe")
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.center = view.center
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
            self.animate()
        })
    }

    private func animate() {
        UIView.animate(withDuration: 1, animations: {
            let size = self.view.frame.size.width * 2
            let diffX = size - self.view.frame.size.width
            let diffY = self.view.frame.size.height - size
            
            self.imageView.frame = CGRect(
                x: -(diffX/2),
                y: diffY/2,
                width: size,
                height: size
            )
        })
        
        UIView.animate(withDuration: 1, animations: {
            self.imageView.alpha = 0
        }, completion: { done in
            if done {
                DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                    let storyboard = UIStoryboard(name: "Homepage", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "HomepageController")
                    UIApplication.shared.keyWindow?.rootViewController = vc
                })
            }
        })

    
    }

}
