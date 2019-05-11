//
//  ViewController.swift
//  test
//
//  Created by mac on 5/11/19.
//  Copyright © 2019 com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var bt1: UIButton!
    @IBOutlet weak var bt2: UIButton!
    @IBOutlet weak var container: UIView!
    @IBOutlet var lcHorizontal: [NSLayoutConstraint]!
    @IBOutlet var lcVertical: [NSLayoutConstraint]!
    
    let space: CGFloat = 16
    let margin: CGFloat = 8
    
    var isVertical: Bool {
        return bt1.frame.width + bt2.frame.width + space + 2*margin >= container.frame.width
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setText("Lorem ipsum dolor sit ame", to: bt1, index: 21)
        setText("Lorem ipsum dolor sit ame", to: bt2, index: 21)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let lcVerticalPriority: UILayoutPriority = UILayoutPriority(rawValue: isVertical ? 999 : 1)
        let lcHorizontalPriority: UILayoutPriority = UILayoutPriority(rawValue: isVertical ? 1 : 999)
        
        if lcVertical.first!.priority != lcVerticalPriority {
            
            print(#function)
            
            self.lcVertical.forEach {
                $0.priority = lcVerticalPriority
            }
            
            self.lcHorizontal.forEach {
                $0.priority = lcHorizontalPriority
            }
            
            UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
                self.container.layoutSubviews()
            })
        }
    }
    
    func setText(_ text: String, to bt: UIButton, index: Int = 1, increment: Bool = true) {
        print(index)
        
        let title = String(text.prefix(index))
        let nextIndex = index + (increment ? 1 : -1)
        
        bt.setTitle(title, for: .normal)
        
        bt.sizeToFit()
        
        var nextIncrement = increment
        
        if increment, text.count - 1 == index {
            nextIncrement = false
        } else if !increment, index == 21 {
            nextIncrement = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.setText(text, to: bt, index: nextIndex, increment: nextIncrement)
        }
    }

}

