//
//  ViewController.swift
//  InsetVsOffset
//
//  Created by TTOzzi on 2020/09/06.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var topOffset: NSLayoutConstraint!
    @IBOutlet weak var bottomOffset: NSLayoutConstraint!
    @IBOutlet weak var offsetSlider: UISlider!
    @IBOutlet weak var offsetValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateOffsetViews(scrollView)
        configureOffsetSlider()
    }
    
    private func configureOffsetSlider() {
        let offset = scrollView.contentSize.height - scrollView.frame.height
        offsetSlider.minimumValue = 0
        offsetSlider.maximumValue = Float(offset)
        offsetSlider.value = 0
    }
    
    private func updateOffsetViews(_ scrollView: UIScrollView) {
        let topOffsetConstant = scrollView.contentOffset.y
        let bottomOffsetConstant = scrollView.contentSize.height - scrollView.frame.height - scrollView.contentOffset.y
        topOffset.constant = topOffsetConstant >= 0 ? topOffsetConstant : 0
        bottomOffset.constant = bottomOffsetConstant >= 0 ? bottomOffsetConstant : 0
    }
    
    @IBAction func offsetSliderValueChanged(_ sender: UISlider) {
        offsetValueLabel.text = String(Int(sender.value))
        scrollView.contentOffset = CGPoint(x: 0, y: CGFloat(sender.value))
        updateOffsetViews(scrollView)
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateOffsetViews(scrollView)
        offsetSlider.value = Float(scrollView.contentOffset.y)
        offsetValueLabel.text = String(Int(scrollView.contentOffset.y))
    }
}
