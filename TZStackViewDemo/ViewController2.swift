//
//  ViewController.swift
//  TZStackView-Example
//
//  Created by Tom van Zummeren on 20/06/15.
//  Copyright (c) 2015 Tom van Zummeren. All rights reserved.
//

import UIKit

import TZStackView

class ViewController2: UIViewController {
    //MARK: - Properties
    //--------------------------------------------------------------------------
    var tzStackView: TZStackView!

    let resetButton = UIButton(type: .System)
    let instructionLabel = UILabel()

    //MARK: - Lifecyle
    //--------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = .None;

        view.backgroundColor = UIColor.lightGrayColor()
        title = "TZStackView"

        let redView = ExplicitIntrinsicContentSizeView(intrinsicContentSize: CGSize(width: 100, height: 100), name: "Red")
        redView.backgroundColor = UIColor.redColor().colorWithAlphaComponent(0.75)
        redView.translatesAutoresizingMaskIntoConstraints = false

        tzStackView = TZStackView(arrangedSubviews: [redView])
        tzStackView.translatesAutoresizingMaskIntoConstraints = false
        tzStackView.axis = .Vertical
        tzStackView.spacing = 40
        tzStackView.backgroundColor = UIColor.darkGrayColor()
        view.addSubview(tzStackView)

        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        instructionLabel.font = UIFont.systemFontOfSize(15)
        instructionLabel.text = "Tap any of the boxes to set hidden=true"
        instructionLabel.textColor = UIColor.whiteColor()
        instructionLabel.numberOfLines = 0
        instructionLabel.setContentCompressionResistancePriority(900, forAxis: .Horizontal)
        instructionLabel.setContentHuggingPriority(1000, forAxis: .Vertical)
        view.addSubview(instructionLabel)

        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.setTitle("Reset", forState: .Normal)
        resetButton.addTarget(self, action: #selector(ViewController.reset), forControlEvents: .TouchUpInside)
        resetButton.setContentCompressionResistancePriority(1000, forAxis: .Horizontal)
        resetButton.setContentHuggingPriority(1000, forAxis: .Horizontal)
        resetButton.setContentHuggingPriority(1000, forAxis: .Vertical)
        view.addSubview(resetButton)

        

        let outerView = ExplicitIntrinsicContentSizeView(intrinsicContentSize: CGSize(width: 100, height: 100), name: "Red")
        outerView.backgroundColor = UIColor.blueColor().colorWithAlphaComponent(0.75)
        outerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(outerView)
        
        let views: [String:AnyObject] = [
            "instructionLabel": instructionLabel,
            "resetButton": resetButton,
            "tzStackView": tzStackView,
            "redView": redView,
            "outerView": outerView
        ]
        
        let metrics: [String:AnyObject] = [
            "gap": 10,
            "topspacing": 25
        ]
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-gap-[instructionLabel]-[resetButton]-gap-|",
            options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[tzStackView]|",
            options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
        view.addConstraints([
            NSLayoutConstraint.init(item: outerView, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        ])

        
        
        view.addConstraints([
            NSLayoutConstraint.init(item: instructionLabel, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1.0, constant: 25),
            NSLayoutConstraint.init(item: resetButton, attribute: .CenterY, relatedBy: .Equal, toItem: instructionLabel, attribute: .CenterY, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: instructionLabel, attribute: .Bottom, relatedBy: .Equal, toItem: tzStackView, attribute: .Top, multiplier: 1.0, constant: -10),
            NSLayoutConstraint.init(item: tzStackView, attribute: .Bottom, relatedBy: .Equal, toItem: outerView, attribute: .Top, multiplier: 1.0, constant: -10),
        ])
        
    }

    //MARK: - Button Actions
    //--------------------------------------------------------------------------
    func reset() {
        UIView.animateWithDuration(2) {
            for view in self.tzStackView.arrangedSubviews {
                view.hidden = false
            }
        }

    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}