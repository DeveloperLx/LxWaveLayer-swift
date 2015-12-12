//
//  LxWaveLayer.swift
//  LxWaveLayerDemo
//
//  Created by DeveloperLx on 15/12/12.
//  Copyright © 2015年 DeveloperLx. All rights reserved.
//

import UIKit

private let DEFAULT_WAVE_COLOR = UIColor(red: 0.098, green: 0.651, blue: 0.996, alpha: 1)
private let DEFAULT_WAVE_HEIGHT: CGFloat = 180.0
private let DEFAULT_WAVE_AMPLITUDE: CGFloat = 6.0
private let DEFAULT_WAVE_SPEED: CGFloat = 270.0
private let DEFAULT_WAVE_PHASE: CGFloat = 0.0
private let DEFAULT_WAVE_PERIOD = 240.0

public class LxWaveLayer: CAShapeLayer {

    public var waveHeight = DEFAULT_WAVE_HEIGHT
    public var waveAmplitude = DEFAULT_WAVE_AMPLITUDE
    public var wavePeriod = DEFAULT_WAVE_PERIOD
    public var waveSpeed = DEFAULT_WAVE_SPEED
    public var wavePhase = DEFAULT_WAVE_PHASE
    
    private var _displayLink: CADisplayLink?
    
    override init() {
        super.init()
        
        fillColor = DEFAULT_WAVE_COLOR.CGColor
        addObserver(self, forKeyPath: "bounds", options: .New, context: nil)
    }
    
    override init(layer: AnyObject) {
        super.init(layer: layer)
        print(layer)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        if keyPath == "bounds" {
            let newBounds = change!["new"]!.CGRectValue
            if newBounds.width > 0 && newBounds.height > 0 {
                
                updateBoundary(nil)
            }
        }
    }
    
    func updateBoundary(displayLink: CADisplayLink?) {
    
        let boundaryPath = UIBezierPath()
        
        let layerWidth = self.bounds.width
        let layerHeight = self.bounds.height
        
        boundaryPath.moveToPoint(CGPoint(x: 0, y: layerHeight))
        boundaryPath.addLineToPoint(CGPoint(x: 0, y: layerHeight - waveHeight))
        
        for var x: CGFloat = 0; x <= layerWidth; x++ {
        
//            print(displayLink.timestamp)
            
            if let dl = displayLink {
            
            let sinParameterValue = 2 * CGFloat(M_PI)/CGFloat(wavePeriod) * (x + CGFloat(dl.timestamp) * waveSpeed)
            let y = waveAmplitude * sin(sinParameterValue) + layerHeight - waveHeight
            boundaryPath.addLineToPoint(CGPoint(x: x, y: y))
            }
        }
        
        boundaryPath .addLineToPoint(CGPoint(x: layerWidth, y: layerHeight))
        boundaryPath.closePath()
        
        path = boundaryPath.CGPath
    }
    
    func deployOnView(view: UIView) {
    
        bounds = view.bounds
        anchorPoint = CGPointZero
        view.layer.addSublayer(self)
    }
    
    func beginWaveAnimation() {
    
        _displayLink = CADisplayLink(target: self, selector: Selector("updateBoundary:"))
        _displayLink?.frameInterval = 3
        _displayLink?.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
    }
    
    func stopWaveAnimation() {
     
        _displayLink?.invalidate()
        _displayLink = nil
    }
}
