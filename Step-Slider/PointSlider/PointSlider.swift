//
//  PointSlider.swift
//  PointSlider
//
//  Created by Pairmi, Vikram (US - Bengaluru) on 8/3/18.
//  Copyright © 2018 vikram. All rights reserved.
//

import UIKit

@IBDesignable class PointSlider: UISlider {
    
    var pathHeight: CGFloat = 1
    var tickColor: UIColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    var isTickRounded: Bool = true

    var trackRect: CGRect {
        return trackRect(forBounds: bounds)
    }
    
    var pathWidth: CGFloat {
        return self.bounds.size.width
    }
    var tickDistance: Double {
        return Double(pathWidth) / Double(ticks)
    }
    var ticks: Int {
        return Int(maximumValue - minimumValue) + 1
    }
    
    override func draw(_ rect: CGRect) {
        drawPath()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbTintColor = #colorLiteral(red: 0.03802147337, green: 0.2730069832, blue: 0.7422717611, alpha: 1)
    }
    
    private func rectForValue(_ value: Float) -> CGRect {
        let trackRect = self.trackRect(forBounds: bounds)
        let rect = thumbRect(forBounds: bounds, trackRect: trackRect, value: value)
        return rect
    }
    
    private func drawPath() {
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 1, height: 1), false, 0.0)
        let transparentImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        setMaximumTrackImage(transparentImage, for: .normal)
        setMinimumTrackImage(transparentImage, for: .normal)
        
        context?.setFillColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
        
        let path = UIBezierPath(rect: trackRect)
        context?.addPath(path.cgPath)
        context?.fillPath()
        
        //Draw Tickpoints
        
        context?.setFillColor(tickColor.cgColor)
        
        for index in 0...ticks {
            var offset: CGFloat = 0
            switch index {
            case Int(minimumValue), Int(maximumValue):
                offset = frame.origin.x + trackRect.origin.x
                isTickRounded = false
            default:
                isTickRounded = true
                break
            }
            
            let x = offset + CGFloat(Double(index) * tickDistance)
            let y = trackRect.midY - CGFloat(5 / 2)

            let stepPath: UIBezierPath
            let rect = CGRect(x: x, y: y, width: CGFloat(5), height: CGFloat(5))
            
            if isTickRounded {
                let radius = CGFloat(5/2)
                stepPath = UIBezierPath(roundedRect: rect, cornerRadius: radius)
            } else {
                let x = CGFloat(Double(index) * tickDistance)
                let y = bounds.midY - CGFloat(20 / 2)
                stepPath = UIBezierPath(rect: CGRect(x: x, y: y, width: CGFloat(1), height: CGFloat(20)))
            }

            context?.addPath(stepPath.cgPath)
            context?.fillPath()
        }
    }
}
