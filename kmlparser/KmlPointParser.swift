//
//  KmlPointParser.swift
//  DATS Finder
//
//  Created by Antoine d'Otreppe on 05/10/14.
//  Copyright (c) 2014 Aspyct.org. All rights reserved.
//

import Foundation

class KmlPointParser: NSObject, NSXMLParserDelegate {
    let onFinish: (Double, Double) -> ()
    var longitude: Double = 0
    var latitude: Double = 0
    var currentSubparser: NSXMLParserDelegate?
    
    init(onFinish: (Double, Double) -> ()) {
        self.onFinish = onFinish
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: [NSObject : AnyObject]) {
        if elementName == "coordinates" {
            self.currentSubparser = KmlTextParser(onFinish: { (latlong: String) -> () in
                let parts = latlong.componentsSeparatedByString(",")
                
                self.longitude = NSString(string: parts[0]).doubleValue
                self.latitude = NSString(string: parts[1]).doubleValue
                
                parser.delegate = self
            })
            
            parser.delegate = self.currentSubparser
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String!, qualifiedName qName: String!) {
        if elementName == "Point" {
            self.onFinish(self.longitude, self.latitude)
        }
    }
}