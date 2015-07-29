//
//  DragView.swift
//  FirTools
//
//  Created by Scorpio on 15/7/28.
//  Copyright (c) 2015年 sda. All rights reserved.
//

import Cocoa

class DragView: NSView ,NSDraggingDestination{
    
    var droppedFilePath:String!
    
    
    override func awakeFromNib() {
        registerForDraggedTypes([NSFilenamesPboardType])
    }
    
    override func draggingEntered(sender: NSDraggingInfo) -> NSDragOperation {
         print("entered")
        return .Copy
    }
    
    override func draggingUpdated(sender: NSDraggingInfo) -> NSDragOperation {
         print("updateed")
        return .Copy
    }
    
    override func performDragOperation(sender: NSDraggingInfo) -> Bool {
         if let board = sender.draggingPasteboard().propertyListForType("NSFilenamesPboardType") as? NSArray {
            if let imagePath = board[0] as? String {
                // THIS IS WERE YOU GET THE PATH FOR THE DROPPED FILE
                self.droppedFilePath = imagePath
                return true
            }
        }
        return false
    }
    
}
