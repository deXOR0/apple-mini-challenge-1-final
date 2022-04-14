//
//  BarChart.swift
//  BarChart
//
//  Created by Atyanta Awesa Pambharu on 11/04/22.
//

import Foundation
import QuartzCore
import UIKit

struct TimePlayed {
    let date: Date
    let playTimeInSeconds: Int
    let dayOfWeek: Int
    
    init(date: Date, playTimeInSeconds: Int) {
        self.date = date
        self.playTimeInSeconds = playTimeInSeconds
        
        let calendar = Calendar.current
        self.dayOfWeek = calendar.component(.weekday, from: self.date) - 1
    }
    
}

struct LineSegment {
    let startPoint: CGPoint
    let endPoint: CGPoint
}

struct HorizontalLine {
    let segment: LineSegment
    let weight: CGFloat
    let text: String
    let heightMultiplier: CGFloat
}

class BarChart {
    let mainLayer = CALayer()
    let barChartView: UIView
    let widthMultiplier: [CGFloat] = [
        1.0,
        0.88,
        0.76,
        0.64,
        0.52,
        0.4,
        0.28
    ]
    let dayOfWeek: [String] = [
        "Sun",
        "Mon",
        "Tue",
        "Wed",
        "Thu",
        "Fri",
        "Sat",
    ]
    
    init(barChartView: UIView) {
        self.barChartView = barChartView
    }

    /**
        Generate a bar chart inside a UIView
        - Parameter targetTimeInSeconds: User's target gaming time in seconds format
        - Parameter lastWeekActivity: Array of TimePlayed, representing last week gaming activity
        
        - Returns: A boolean value, true if the food item was found on the inventory and consumed, false if otherwise
    */
    func setupBarChart(targetTimeInSeconds: Int, lastWeekActivity: [TimePlayed]) {
        self.mainLayer.frame = self.barChartView.bounds
        barChartView.layer.addSublayer(self.mainLayer)
        
        addHorizontalLine(targetTimeInSeconds: targetTimeInSeconds)
        addBottomText(lastWeekActivity: lastWeekActivity)
        addHorizontalLineText(targetTimeInSeconds: targetTimeInSeconds)
        addVerticalLineText()
        addBars(lastWeekActivity: lastWeekActivity)
        
    }

    func addHorizontalLine(targetTimeInSeconds: Int) {
        let lines = computeHorizontalLine(targetTimeInSeconds: targetTimeInSeconds)
        
        lines.forEach { (line) in
            mainLayer.addLineLayer(lineSegment: line.segment, color: UIColor.gray.cgColor, weight: line.weight)
        }
    }

    func computeHorizontalLine(targetTimeInSeconds: Int) -> [HorizontalLine] {
        
        var lines = [HorizontalLine]()
        
        let multiplier = (CGFloat(targetTimeInSeconds / 3600)) / 24
        
        let data = [
            (heightMultiplier: CGFloat(multiplier), text: "")
        ]
        
        data.forEach { (heightMultiplier, text) in
            let height = (175 / 24) * CGFloat(targetTimeInSeconds/3600)
            let yPos = CGFloat(self.barChartView.frame.height - height) - 20
            let lineSegment = LineSegment(
                startPoint: CGPoint(x: 50, y: yPos),
                endPoint: CGPoint(x: self.barChartView.frame.width * 0.92, y: yPos))
            lines.append(HorizontalLine(segment: lineSegment, weight: 0.5, text: text, heightMultiplier: heightMultiplier))
        }
        
        return lines
    }
    
    func addVerticalLineText() {
        
        let hours = [24,20,16,12,8,4,0]
        
        hours.forEach { hour in
            let height = (175 / 24) * CGFloat(hour)
            let yPos = CGFloat(self.barChartView.frame.height - height) - 28
            
            mainLayer.addTextLayer (
                frame: CGRect(x: 0, y: Int(yPos), width: 50, height: 50),
                color:UIColor.gray.cgColor,
                fontSize: 12,
                text: String(hour)
            )
        }
    }
    
    func addHorizontalLineText(targetTimeInSeconds: Int) {
        let lines = computeHorizontalLine(targetTimeInSeconds: targetTimeInSeconds)
        
        lines.forEach { (line) in
            let xPos = 0
            let yPos = self.barChartView.frame.height - (line.heightMultiplier * self.barChartView.frame.height) - 8
            
            mainLayer.addTextLayer (
                frame: CGRect(x: xPos, y: Int(yPos), width: 50, height: 50),
                color:UIColor.gray.cgColor,
                fontSize: 12,
                text: line.text
            )
        }
    }
    
    func addBottomText(lastWeekActivity: [TimePlayed]) {
        for (index, day) in lastWeekActivity.enumerated(){
            let xPos = self.barChartView.frame.width - (self.widthMultiplier[index] * self.barChartView.frame.width)
            
            mainLayer.addTextLayer (
                frame: CGRect(x: xPos + 40, y: self.barChartView.frame.height-20, width: 50, height: 50),
                color: UIColor.gray.cgColor,
                fontSize: 12,
                text: self.dayOfWeek[day.dayOfWeek]
            )
            
        }
        
    }
    
    func addBars(lastWeekActivity: [TimePlayed]) {
        
        for (index, day) in lastWeekActivity.enumerated() {
            let widthMultiplier = self.widthMultiplier[index]
            let barHeight: CGFloat = (175 / 24) * CGFloat(day.playTimeInSeconds/3600)
            let barCalculatedHeight = (barHeight / self.barChartView.frame.height) * self.barChartView.frame.height
            
            let xPos = CGFloat(self.barChartView.frame.width - (widthMultiplier * self.barChartView.frame.width))
            let yPos = CGFloat(self.barChartView.frame.height - barCalculatedHeight)
            
            mainLayer.addRectangleLayer(frame: CGRect(x: xPos+55, y: yPos-20, width: 20, height: barCalculatedHeight), color: UIColor.gray.cgColor)
        }
        
    }
    
}

