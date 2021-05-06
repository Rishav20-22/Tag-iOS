//
//  ViewController.swift
//  Newapp24
//
//  Created by Rishav Kumar on 5/6/21.
//

import UIKit
import CocoaMQTT


class ViewController: UIViewController,CocoaMQTTDelegate {
   
    @IBOutlet var imageView: UIImageView!
    func mqtt(_ mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck) {
        mqtt.subscribe("tag/pics")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16) {
        
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishAck id: UInt16) {
        
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16) {
        print((message.string!));
        imageView.image = UIImage(named:message.string!)

        
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopics success: NSDictionary, failed: [String]) {
        
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didUnsubscribeTopics topics: [String]) {
        
    }
    
    func mqttDidPing(_ mqtt: CocoaMQTT) {
        
    }
    
    func mqttDidReceivePong(_ mqtt: CocoaMQTT) {
        
    }
    
    func mqttDidDisconnect(_ mqtt: CocoaMQTT, withError err: Error?) {
        
    }
 

    override func viewDidLoad() {
        

        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let clientID = "CocoaMQTT-" + String(ProcessInfo().processIdentifier)
        let websocket = CocoaMQTTWebSocket(uri: "/mqtt")
        var mqtt = CocoaMQTT(clientID: clientID, host: "192.168.1.4", port: 1884, socket: websocket)
        

              mqtt.keepAlive = 60
              mqtt.delegate = self
          
        print(mqtt.connect())
       
       
    }
  
}


