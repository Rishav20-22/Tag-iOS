//
//  ViewController.swift
//  Newapp24
//
//  Created by Rishav Kumar on 5/6/21.
//

import UIKit
import CocoaMQTT
import Speech


class ViewController: UIViewController,CocoaMQTTDelegate,UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // speech recog variables decl
    //end
    let data = ["Square", "Rectangle", "Triangle", "Circle"];

    @IBOutlet weak var Text_x: UITextField!
    
    @IBOutlet weak var Text_y: UITextField!
   

    @IBOutlet weak var Pickerview: UIPickerView!
    @IBOutlet var label: UILabel!
    var command_mqtt = "?"
    var old_cmd = ["",""]
   // @IBOutlet var imageView: UIImageView!;
    
    //Draw_Shape Code
    @IBAction func changeBtnTapped(_ sender: Any) {
       
        // Accesses the value on the Shape Picker(PickerView)
        var num = Pickerview.selectedRow(inComponent: 0)
       
        var text_x: String = Text_x.text!
        var text_y: String = Text_y.text!
        label.text = "Draw "+data[num]+" "+text_x+" "+text_y
        command_mqtt = data[num]+" "+text_x+" "+text_y
        
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


    func pickerView(_ pickerView: UIPickerView,
    numberOfRowsInComponent component: Int) -> Int {

        // Row count: rows equals array length.
        return data.count
}

    func pickerView(_ pickerView: UIPickerView,
    titleForRow row: Int,
    forComponent component: Int) -> String? {

        // Return a string from the array for this row.
        return data[row]
}
    
    override func viewDidLoad() {
      

        initializeHideKeyboard()


        super.viewDidLoad()
        
        self.Pickerview.dataSource = self
        self.Pickerview.delegate = self
        // Do any additional setup after loading the view.
        let clientID = "CocoaMQTT-" + String(ProcessInfo().processIdentifier)
        let websocket = CocoaMQTTWebSocket(uri: "/mqtt")
        var mqtt = CocoaMQTT(clientID: clientID, host: "192.168.1.2", port: 1884, socket: websocket)
        mqtt.allowUntrustCACertificate = true
        mqtt.keepAlive = 60
        mqtt.delegate = self
        
        print(mqtt.connect())

        
    }
    func initializeHideKeyboard(){
    //Declare a Tap Gesture Recognizer which will trigger our dismissMyKeyboard() function
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(
    target: self,
    action: #selector(dismissMyKeyboard))
    //Add this tap gesture recognizer to the parent view
    view.addGestureRecognizer(tap)
    }
    @objc func dismissMyKeyboard(){
    //endEditing causes the view (or one of its embedded text fields) to resign the first responder status.
    //In short- Dismiss the active keyboard.
    view.endEditing(true)
    }
  
  
}


 



