//
//  StatusWidgetPreferencePane.swift
//  Pock
//
//  Created by Pierluigi Galdi on 30/03/2019.
//  Copyright © 2019 Pierluigi Galdi. All rights reserved.
//

import Cocoa
import Preferences
import Defaults

class StatusWidgetPreferencePane: NSViewController, Preferenceable {

    /// UI
    @IBOutlet weak var showWifiItem:                NSButton!
    @IBOutlet weak var showPowerItem:               NSButton!
    @IBOutlet weak var showBatteryIconItem:         NSButton!
    @IBOutlet weak var showBatteryPercentageItem:   NSButton!
    @IBOutlet weak var showDateItem:                NSButton!
    // @IBOutlet weak var showSpotlightItem:           NSButton!
    
    /// Preferenceable
    let toolbarItemTitle: String   = "Status"
    let toolbarItemIcon:  NSImage  = NSImage(named: NSImage.advancedName)!
    
    override var nibName: NSNib.Name? {
        return "StatusWidgetPreferencePane"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadCheckboxState()
    }
    
    private func loadCheckboxState() {
        self.showWifiItem.state              = defaults[.shouldShowWifiItem]          ? .on : .off
        self.showPowerItem.state             = defaults[.shouldShowPowerItem]         ? .on : .off
        self.showBatteryIconItem.state       = defaults[.shouldShowBatteryIcon]       ? .on : .off
        self.showBatteryPercentageItem.state = defaults[.shouldShowBatteryPercentage] ? .on : .off
        self.showDateItem.state              = defaults[.shouldShowDateItem]          ? .on : .off
        // self.showSpotlightItem.state         = defaults[.shouldShowSpotlightItem]     ? .on : .off
    }
    
    @IBAction func didChangeCheckboxValue(_ checkbox: NSButton) {
        var key: Defaults.Key<Bool>
        switch checkbox.tag {
        case 1:
            key = .shouldShowWifiItem
        case 2:
            key = .shouldShowPowerItem
        case 21:
            key = .shouldShowBatteryIcon
        case 22:
            key = .shouldShowBatteryPercentage
        case 3:
            key = .shouldShowDateItem
        /* case 4:
            key = .shouldShowSpotlightItem */
        default:
            return
        }
        defaults[key] = checkbox.state == .on
        NSWorkspace.shared.notificationCenter.post(name: .shouldReloadStatusWidget, object: nil)
    }
    
}
