//
//  ViewController.swift
//  LxWaveLayerDemo
//
//  Created by DeveloperLx on 15/12/12.
//  Copyright © 2015年 DeveloperLx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var _waveContainerView: UIView!
    let _waveLayer = LxWaveLayer()
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        _waveLayer.deployOnView(_waveContainerView)
        _waveLayer.beginWaveAnimation()
    }
    
    @IBAction func heightSliderValueChanged(sender: UISlider) {
    
        _waveLayer.waveHeight = CGFloat(sender.value)
    }

    @IBAction func amplitideSliderValueChanged(sender: UISlider) {
        
        _waveLayer.waveAmplitude = CGFloat(sender.value)
    }

    @IBAction func periodSliderValueChanged(sender: UISlider) {
        
        _waveLayer.wavePeriod = NSTimeInterval(sender.value)
    }
    
    @IBAction func speedSliderValueChanged(sender: UISlider) {
        
        _waveLayer.waveSpeed = CGFloat(sender.value)
    }

    @IBAction func startOrStopSwitchValueChanged(sender: UISwitch) {
    
        if sender.on {
        
            _waveLayer.beginWaveAnimation()
        }
        else {
            
            _waveLayer.stopWaveAnimation()
        }
    }
}

