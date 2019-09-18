//
//  PanViewController.swift
//  PanGestureTraining
//
//  Created by Marcos Barbosa on 17/09/19.
//  Copyright © 2019 Marcos Barbosa. All rights reserved.
//

import UIKit

class PanView: UIView {
    
    // MARK: - Properties
    
    fileprivate var upGesture: UIPanGestureRecognizer!
    
    // MARK? - Outlets
    @IBOutlet var viewMaster: UIView!
    
    @IBOutlet weak var panGestureView: UIView!
    
    // MARK: - Constructors
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setLayout()
    }
    
    // MARK: - Overrides
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }

    private func setLayout() {
        Bundle.main.loadNibNamed(String(describing: PanView.self), owner: self, options: nil)
        addSubview(viewMaster)
        viewMaster.frame = self.bounds
        viewMaster.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    
    @IBAction func closeButtonWasClicked(_ sender: Any) {
    }
    
}

extension PanView: UIGestureRecognizerDelegate {
    
    
    
}
