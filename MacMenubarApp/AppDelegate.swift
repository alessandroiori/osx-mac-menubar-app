//
//  AppDelegate.swift
//  MacMenubarApp
//
//  Created by Alessandro on 03/05/15.
//  Copyright (c) 2015 Alessandro Iori. All rights reserved.
//
//
//  AppDelegate.swift
//  MenuBarApp
//
//  Created by Alessandro on 03/05/15.
//  Copyright (c) 2015 Alessandro Iori. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var statusMenu: NSMenu!
    
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let icon = NSImage(named: "statusIcon")
        icon?.setTemplate(true)
        
        statusItem.image = icon
        statusItem.menu = statusMenu
    }
    
    @IBAction func menuClicked(sender: NSMenuItem) {
        let task = NSTask()
        task.launchPath = "/usr/bin/defaults"
        
        if(sender.state == NSOnState){
            sender.state = NSOffState
            task.arguments = ["write", "com.apple.finder", "AppleShowAllFiles", "NO"]
        } else {
            sender.state = NSOnState
            task.arguments = ["write", "com.apple.finder", "AppleShowAllFiles", "YES"]
        }
        
        task.launch()
        task.waitUntilExit()
        
        let killtask = NSTask()
        killtask.launchPath = "/usr/bin/killall"
        killtask.arguments = ["Finder"]
        killtask.launch()
    }
    
    @IBAction func menuQuitClicked(sender: AnyObject) {
        NSApplication.sharedApplication().terminate(self)
    }
}

