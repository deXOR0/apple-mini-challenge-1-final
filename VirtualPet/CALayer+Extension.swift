//
//  CALayer+Extension.swift
//  BarChart
//
//  Created by Atyanta Awesa Pambharu on 11/04/22.
//

import UIKit

extension CALayer {
    
    func addLineLayer(lineSegment: LineSegment, color: CGColor, weight: CGFloat) {
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(lineSegment: lineSegment).cgPath
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = color
        layer.lineWidth = weight
        self.addSublayer(layer)
    }
    
    func addTextLayer(frame: CGRect, color: CGColor, fontSize: CGFloat, text: String) {
        let textLayer = CATextLayer()
        textLayer.frame = frame
        textLayer.foregroundColor = color
        textLayer.backgroundColor = UIColor.clear.cgColor
        textLayer.alignmentMode = CATextLayerAlignmentMode.center
        textLayer.contentsScale = UIScreen.main.scale
        textLayer.font = CTFontCreateWithName(UIFont.systemFont(ofSize: 0).fontName as CFString, 0, nil)
        textLayer.fontSize = fontSize
        textLayer.string = text
        self.addSublayer(textLayer)
    }
    
    func addRectangleLayer(frame: CGRect, color: CGColor) {
        let layer = CALayer()
        layer.frame = frame
        layer.backgroundColor = color
        self.addSublayer(layer)
    }
    
}
