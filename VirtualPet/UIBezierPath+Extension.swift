//
//  UIBezierPath+Extension.swift
//  BarChart
//
//  Created by Atyanta Awesa Pambharu on 11/04/22.
//

import UIKit

extension UIBezierPath {
    convenience init(lineSegment: LineSegment) {
        self.init()
        self.move(to: lineSegment.startPoint)
        self.addLine(to: lineSegment.endPoint)
    }
}
