//
//  ConsumeManageVC.swift
//  CardSJD
//
//  Created by X on 16/9/19.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit
import SwiftCharts

class ConsumeManageVC: UITableViewController {
    
    @IBOutlet var total: UILabel!
    
    @IBOutlet var tmsg: UILabel!
    
    @IBOutlet var num1: UILabel!
    
    @IBOutlet var num2: UILabel!
    
    @IBOutlet var num3: UILabel!
    
    @IBOutlet var chartView: UIView!
    
    private var chart: Chart? // arc
    
    var hArr:[CGFloat] = [170, 12,55,55,55,55,12,50,100]
    
    
    func showChart()
    {
        let labelSettings = ChartLabelSettings(font: ExamplesDefaults.labelFont,fontColor: APPOrangeColor)
        
        let chartPoints1 = [
            self.createChartPoint(0, 0, labelSettings),
            self.createChartPoint(1, 1, labelSettings),
            self.createChartPoint(2, 0, labelSettings),
            self.createChartPoint(3, 4, labelSettings),
            self.createChartPoint(5, 2, labelSettings),
            self.createChartPoint(6, 3, labelSettings)
        ]
        
        let xValues = [
            ChartAxisValueString("08-20", order: 0, labelSettings: labelSettings),
            ChartAxisValueString("08-21", order: 1, labelSettings: labelSettings),
            ChartAxisValueString("08-22", order: 2, labelSettings: labelSettings),
            ChartAxisValueString("08-23", order: 3, labelSettings: labelSettings),
            ChartAxisValueString("08-24", order: 4, labelSettings: labelSettings),
            ChartAxisValueString("08-25", order: 5, labelSettings: labelSettings),
            ChartAxisValueString("08-26", order: 6, labelSettings: labelSettings)
        ]
        
        let yValues = [
            ChartAxisValueString("", order: 0, labelSettings: labelSettings),
            ChartAxisValueString("", order: 1, labelSettings: labelSettings),
            ChartAxisValueString("", order: 2, labelSettings: labelSettings),
            ChartAxisValueString("", order: 3, labelSettings: labelSettings),
            ChartAxisValueString("", order: 4, labelSettings: labelSettings),
            ChartAxisValueString("", order: 5, labelSettings: labelSettings)
        ]
        
        
        let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "最近7日", settings: labelSettings))
        
        let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "", settings: labelSettings.defaultVertical()))
        
        let chartFrame = CGRectMake(-10, 0, SW, SW)
        
        // calculate coords space in the background to keep UI smooth
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            
            let chartSettings = ExamplesDefaults.chartSettings
            chartSettings.trailing = 15
            
            let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
            
            dispatch_async(dispatch_get_main_queue()) {
                let (xAxis, yAxis, innerFrame) = (coordsSpace.xAxis, coordsSpace.yAxis, coordsSpace.chartInnerFrame)
                
                let lineModel1 = ChartLineModel(chartPoints: chartPoints1, lineColor: APPOrangeColor, animDuration: 1, animDelay: 0)
                
                let chartPointsLineLayer = ChartPointsLineLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, lineModels: [lineModel1])
                
                let settings = ChartGuideLinesDottedLayerSettings(linesColor: UIColor.blackColor(), linesWidth: ExamplesDefaults.guidelinesWidth)
                let guidelinesLayer = ChartGuideLinesDottedLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, settings: settings)
                
                //        self.automaticallyAdjustsScrollViewInsets = false // nested view controller - this is in parent
                
                let chart = Chart(
                    frame: chartFrame,
                    layers: [
                        xAxis,
                        yAxis,
                        guidelinesLayer,
                        chartPointsLineLayer
                    ]
                )
                
                
                self.chartView.addSubview(chart.view)
                self.chart = chart
                
            }
        }
    }
    
    private func createChartPoint(x: Double, _ y: Double, _ labelSettings: ChartLabelSettings) -> ChartPoint {
        return ChartPoint(x: ChartAxisValueDouble(x, labelSettings: labelSettings), y: ChartAxisValueDouble(y))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackButton()
        self.title="消费管理"
        
        let v=UIView()
        v.backgroundColor=UIColor.clearColor()
        tableView.tableFooterView=v
        tableView.tableHeaderView=v
        
        hArr[8] = SW
        
        
        showChart()
        
        
        
        tableView.reloadData()
        
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if indexPath.row == 2
        {
            let vc = "ConsumeDetailVC".VC("Main")
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return hArr[indexPath.row]
    }
    
    let sarr = [0,1,5,6,7]
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if(!sarr.contains(indexPath.row))
        {
            cell.separatorInset=UIEdgeInsetsMake(0, 15, 0, 15)
            if(IOS_Version>=8.0)
            {
                if #available(iOS 8.0, *) {
                    cell.layoutMargins=UIEdgeInsetsMake(0, 15, 0, 15)
                } else {
                    // Fallback on earlier versions
                }
            }
        }
        else
        {
            cell.separatorInset=UIEdgeInsetsMake(0, 0, 0, 0)
            if(IOS_Version>=8.0)
            {
                if #available(iOS 8.0, *) {
                    cell.layoutMargins=UIEdgeInsetsMake(0, 0, 0, 0)
                } else {
                    // Fallback on earlier versions
                }
            }
        }
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        tableView.separatorInset=UIEdgeInsetsMake(0, 0, 0, 0)
        if(IOS_Version>=8.0)
        {
            if #available(iOS 8.0, *) {
                tableView.layoutMargins=UIEdgeInsetsMake(0, 0, 0, 0)
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
