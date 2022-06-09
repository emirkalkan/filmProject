//
//  LoadingViewController.swift
//  filmProject
//
//  Created by Emir Kalkan on 5.06.2022.
//

import UIKit

class LoadingViewController: UIViewController {
    
    var loadingActivityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        
        indicator.style = .large
        indicator.color = .white
        // The indicator should be animating when
        // the view appears.
        indicator.startAnimating()
            
        // Setting the autoresizing mask to flexible for all
        // directions will keep the indicator in the center
        // of the view and properly handle rotation.
        indicator.autoresizingMask = [
            .flexibleLeftMargin, .flexibleRightMargin,
            .flexibleTopMargin, .flexibleBottomMargin
        ]
            
        return indicator
    }()
    
    var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.alpha = 0.8
        
        // Setting the autoresizing mask to flexible for
        // width and height will ensure the blurEffectView
        // is the same size as its parent view.
        blurEffectView.autoresizingMask = [
            .flexibleWidth, .flexibleHeight
        ]
        
        return blurEffectView
    }()
    
    var label: UILabel = {
        let label = UILabel()
        label.text = "loading..."
        label.textColor = .white
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            
            // Add the blurEffectView with the same
            // size as view
            blurEffectView.frame = self.view.bounds
            view.insertSubview(blurEffectView, at: 0)
            
            // Add the loadingActivityIndicator in the
            // center of view
            loadingActivityIndicator.center = CGPoint(
                x: view.bounds.midX,
                y: view.bounds.midY
            )
            label.center = CGPoint(
            x: view.bounds.midX-10,
            y: view.bounds.midY-10
            )
            view.addSubview(loadingActivityIndicator)
            view.addSubview(label)
    }

}
