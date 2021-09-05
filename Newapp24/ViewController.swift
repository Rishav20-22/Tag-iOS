//
//  ViewController.swift
//  Newapp24
//
//  Created by Rishav Kumar on 5/6/21.
//

import UIKit
import CocoaMQTT
import Speech


class ViewController: UIViewController,CocoaMQTTDelegate {
    // speech recog variables decl
    //end
    @IBOutlet var label: UILabel!
    var command_mqtt = "?"
    var old_cmd = ["",""]
   // @IBOutlet var imageView: UIImageView!;
    @IBAction func changeBtnTapped(_ sender: Any) {
        label.text = "Plot point";
        command_mqtt = "plot"
        mqtt_connect()
       }
    @IBAction func changeBtnTapped2(_ sender: Any) {
         
        label.text = "Rotate Left";
        command_mqtt = "MoveTankDegrees 45 -45 360"
        mqtt_connect()
    }
    @IBAction func changeBtnTapped3(_ sender: Any) {
         
        label.text = "Rotate Right";
        command_mqtt = "MoveTankDegrees -45 45 360"
        //mqtt.connect()
        mqtt_connect()
       }
    @IBAction func changeBtnTapped4(_ sender: Any) {
        label.text = "Forward 50";
        command_mqtt = "MoveTank 30 30"
        mqtt_connect()
       }
    @IBAction func changeBtnTapped5(_ sender: Any) {
         
        label.text = "Backward 50";
        command_mqtt = "MoveTank -20 -20"
        mqtt_connect()
       }
    @IBAction func changeBtnTapped6(_ sender: Any) {
         
        label.text = "MoveTank 0 0";
        command_mqtt = "MoveTank 0 0"
        mqtt_connect()
       }
    func mqtt(_ mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck) {
        
//        print("hello")
//        print(command_mqtt)
//        mqtt.publish("tag/networktest", withString: self.command_mqtt)
       
        
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16) {
        
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishAck id: UInt16) {
        
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16) {
        print((message.string!));
        //imageView.image = UIImage(named:message.string!)

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
    


 func mqtt_connect()
 {
    let clientID = "CocoaMQTT-" + String(ProcessInfo().processIdentifier)
    let websocket = CocoaMQTTWebSocket(uri: "/mqtt")
    var mqtt = CocoaMQTT(clientID: clientID, host: "192.168.1.2", port: 1884, socket: websocket)
    print(self.command_mqtt)
    print(mqtt.connect())
    usleep(200000)

    mqtt.publish("tag/networktest", withString: self.command_mqtt)

 }

    override func viewDidLoad() {
        

        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        let clientID = "CocoaMQTT-" + String(ProcessInfo().processIdentifier)
        let websocket = CocoaMQTTWebSocket(uri: "/mqtt")
        var mqtt = CocoaMQTT(clientID: clientID, host: "192.168.1.2", port: 1884, socket: websocket)
        mqtt.allowUntrustCACertificate = true
        mqtt.keepAlive = 60
        mqtt.delegate = self
    
        print(mqtt.connect())

        
    }
  
}


