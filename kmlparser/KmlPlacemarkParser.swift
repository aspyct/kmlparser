//
//  KmlPlacemarkParser.swift
//  DATS Finder
//
//  Created by Antoine d'Otreppe on 02/10/14.
//  Copyright (c) 2014 Aspyct.org. All rights reserved.
//

import Foundation

class KmlPlacemarkParser : NSObject, NSXMLParserDelegate {
    let onFinish: (KmlPlacemark) -> ()
    let kmlPlacemark = KmlPlacemark()
    
    // Need to keep a reference to subparsers
    // otherwise they would die instantly
    var currentSubparser: NSXMLParserDelegate?
    
    init(onFinish: (KmlPlacemark) -> ()) {
        self.onFinish = onFinish
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: [NSObject : AnyObject]) {
        if elementName == "name" {
            currentSubparser = KmlTextParser({ (name) -> () in
                self.kmlPlacemark.name = name
                
                parser.delegate = self
            })
            
            parser.delegate = currentSubparser
        }
        else if elementName == "Point" {
            currentSubparser = KmlPointParser({ (longitude, latitude) -> () in
                self.kmlPlacemark.longitude = longitude
                self.kmlPlacemark.latitude = latitude
                
                parser.delegate = self
            })
            
            parser.delegate = currentSubparser
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String!, qualifiedName qName: String!) {
        if elementName == "Placemark" {
            self.onFinish(kmlPlacemark)
        }
    }
}