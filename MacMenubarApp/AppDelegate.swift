//
//  AppDelegate.swift
//  MacMenubarApp
//
//  Created by Alessandro Iori on 03/05/15.
//
//  https://github.com/alessandroiori
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var statusMenu: NSMenu!
    
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
    let icon1 = NSImage(named: "statusIcon1")
    let icon2 = NSImage(named: "statusIcon2")
    
    func KillAllFinder(){
        let killtask = NSTask()
        killtask.launchPath = "/usr/bin/killall"
        killtask.arguments = ["Finder"]
        killtask.launch()
    }
    
    func FinderShow(YN: String){
        let task = NSTask()
        task.launchPath = "/usr/bin/defaults"
        task.arguments = ["write", "com.apple.finder", "AppleShowAllFiles", YN]
        task.launch()
        task.waitUntilExit()
    }
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        icon1?.setTemplate(true)
        icon2?.setTemplate(true)
        
        statusItem.image = icon1
        statusItem.menu = statusMenu
    }
    
    @IBAction func menuClicked(sender: NSMenuItem) {
        
        if(sender.state == NSOnState){
            statusItem.image = icon1
            sender.state = NSOffState
            FinderShow("NO")
        } else {
            statusItem.image = icon2
            sender.state = NSOnState
            FinderShow("YES")
        }
        
        KillAllFinder()
    }
    
    @IBAction func menuQuitClicked(sender: AnyObject) {
        FinderShow("NO")
        KillAllFinder()
        
        NSApplication.sharedApplication().terminate(self)
    }
}

