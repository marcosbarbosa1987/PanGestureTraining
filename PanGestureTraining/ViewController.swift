//
//  ViewController.swift
//  PanGestureTraining
//
//  Created by Marcos Barbosa on 17/09/19.
//  Copyright © 2019 Marcos Barbosa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    // MARK: - Properties
    
    internal var panView: PanView!
    internal var panGesture: UIPanGestureRecognizer!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var removeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlerVertical(recognizer:)))
        addButton.isEnabled = true
        removeButton.isEnabled = false
    }
    
    
    @IBAction func addPanViewClicked(_ sender: Any) {
        addButton.isEnabled = false
        removeButton.isEnabled = true
        setLayout()
    }
    
    @IBAction func removePanViewClicked(_ sender: Any) {
        
        if let view = self.view.viewWithTag(99) {
            view.removeGestureRecognizer(panGesture)
            view.removeFromSuperview()
            
            addButton.isEnabled = true
            removeButton.isEnabled = false
        }
    }
    
    func setLayout() {
        
        panView = PanView()
        panView.tag = 99
        panView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(panView)
        panView.addGestureRecognizer(panGesture)
        
        panView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.frame.height -  94).isActive = true
        panView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        panView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        panView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        
        self.view.layoutIfNeeded()
        print(panView.frame)
    }
    
    @objc private func handlerVertical(recognizer: UIPanGestureRecognizer) {
        
        let translation = recognizer.translation(in: self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x: view.center.x, y: view.center.y + translation.y)
            print(translation.y)
            print(panView.frame)
        }
        
        if translation.y >= 0.0 && (panView.frame.minY > (UIScreen.main.bounds.size.height - 95)){
            changeTabBar(hidden: false, animated: true)
        } else {
            changeTabBar(hidden: true, animated: true)
        }
        
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        
        switch recognizer.state {
        case .ended:
            if translation.y >= 0.0 && (panView.frame.minY > (UIScreen.main.bounds.size.height / 2)){
                changeTabBar(hidden: false, animated: true)
                UIView.animate(withDuration: 0.5) {
                    self.panView.frame.origin.y = (UIScreen.main.bounds.size.height - 95)
                    self.panView.layoutIfNeeded()
                }
            } else {
                changeTabBar(hidden: true, animated: true)
                
                UIView.animate(withDuration: 0.5) {
                    self.panView.frame.origin.y = 0.0
                    self.panView.layoutIfNeeded()
                }
            }
            
            
        default:
            print("error")
        }
        
    }
    
    func changeTabBar(hidden:Bool, animated: Bool){
        let tabBar = self.tabBarController?.tabBar
        let offset = (hidden ? UIScreen.main.bounds.size.height : UIScreen.main.bounds.size.height - (tabBar?.frame.size.height)! )
        if offset == tabBar?.frame.origin.y {return}
        print("changing origin y position")
        let duration:TimeInterval = (animated ? 0.5 : 0.0)
        UIView.animate(withDuration: duration,
                       animations: {tabBar!.frame.origin.y = offset},
                       completion:nil)
    }
}
