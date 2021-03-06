//
//  PointSliderView.swift
//  PointSlider
//
//  Created by Pairmi, Vikram (US - Bengaluru) on 8/2/18.
//  Copyright © 2018 vikram. All rights reserved.
//

import UIKit

@IBDesignable class PointSliderView: UIView {
    
    @IBOutlet weak var slider: PointSlider!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        let view =  viewFromNib()
        view.frame = bounds
        // Make the view stretch with containing view
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(view)
        slider.addTarget(self, action: #selector(sliderValueChanged(slider:forEvent:)), for: .valueChanged)
    }
    
    func viewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    @objc func sliderValueChanged(slider: UISlider, forEvent: UIEvent) {
        if let touchEvent = forEvent.allTouches?.first {
            switch touchEvent.phase {
            case .began:
                break
            case .moved:
                break
            case .stationary:
                break
            case .ended:
                slider.setValue(Float(lroundf(slider.value)), animated: true)
            case .cancelled:
                break
            }
        }
        
    }
}
