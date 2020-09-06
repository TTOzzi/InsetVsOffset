//
//  ViewController.swift
//  InsetVsOffset
//
//  Created by TTOzzi on 2020/09/06.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var topOffset: NSLayoutConstraint!
    @IBOutlet private weak var bottomOffset: NSLayoutConstraint!
    @IBOutlet private weak var offsetSlider: UISlider!
    @IBOutlet private weak var offsetValueLabel: UILabel!
    @IBOutlet private weak var topInsetSlider: UISlider!
    @IBOutlet private weak var topInsetValueLabel: UILabel!
    @IBOutlet private weak var bottomInsetSlider: UISlider!
    @IBOutlet private weak var bottomInsetValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateOffsetViews(scrollView)
        configure()
    }
    
    private func configure() {
        configureOffsetSlider()
        configureTopInsetSlider()
        configureBottomInsetSlider()
    }
    
    private func configureOffsetSlider() {
        let offset = scrollView.contentSize.height - scrollView.frame.height
        offsetSlider.minimumValue = 0
        offsetSlider.maximumValue = Float(offset)
        offsetSlider.value = 0
    }
    
    private func configureTopInsetSlider() {
        topInsetSlider.minimumValue = Float(-(scrollView.contentSize.height - scrollView.frame.height))
        topInsetSlider.maximumValue = Float(scrollView.frame.height)
        topInsetSlider.value = 0
    }
    
    private func configureBottomInsetSlider() {
        bottomInsetSlider.minimumValue = Float(-(scrollView.contentSize.height - scrollView.frame.height))
        bottomInsetSlider.maximumValue = Float(scrollView.frame.height)
        bottomInsetSlider.value = 0
    }
    
    private func updateOffsetViews(_ scrollView: UIScrollView) {
        let topOffsetConstant = scrollView.contentOffset.y
        let bottomOffsetConstant = scrollView.contentSize.height - scrollView.frame.height - scrollView.contentOffset.y
        topOffset.constant = topOffsetConstant >= 0 ? topOffsetConstant : 0
        bottomOffset.constant = bottomOffsetConstant >= 0 ? bottomOffsetConstant : 0
    }
    
    @IBAction private func offsetSliderValueChanged(_ sender: UISlider) {
        offsetValueLabel.text = String(Int(sender.value))
        scrollView.contentOffset = CGPoint(x: 0,
                                           y: CGFloat(sender.value))
        updateOffsetViews(scrollView)
    }
    
    @IBAction private func topInsetSliderValueChanged(_ sender: UISlider) {
        topInsetValueLabel.text = String(Int(sender.value))
        let currentInset = scrollView.contentInset
        scrollView.contentInset = UIEdgeInsets(top: CGFloat(sender.value),
                                               left: currentInset.left,
                                               bottom: currentInset.bottom,
                                               right: currentInset.right)
    }
    
    @IBAction private func bottomInsetSliderValueChanged(_ sender: UISlider) {
        bottomInsetValueLabel.text = String(Int(sender.value))
        let currentInset = scrollView.contentInset
        scrollView.contentInset = UIEdgeInsets(top: currentInset.top,
                                               left: currentInset.left,
                                               bottom: CGFloat(sender.value),
                                               right: currentInset.right)
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateOffsetViews(scrollView)
        offsetSlider.value = Float(scrollView.contentOffset.y)
        offsetValueLabel.text = String(Int(scrollView.contentOffset.y))
    }
}
