//
//  ViewController.swift
//  Newapp24
//
//  Created by Rishav Kumar on 5/6/21.
//

import UIKit
import CocoaMQTT
import Speech


class ViewController: UIViewController,CocoaMQTTDelegate, SFSpeechRecognizerDelegate  {
    // speech recog variables decl
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
    
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    
    private var recognitionTask: SFSpeechRecognitionTask?
    
    private let audioEngine = AVAudioEngine()
    //end
    
    var stringtillyet = ""
    var command_mqtt = "?"
    var old_cmd = ["",""]
    @IBOutlet var imageView: UIImageView!;
    
    func mqtt(_ mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck) {
        
        mqtt.subscribe("tag/pics")
        
        mqtt.publish("tag/networktest", withString: command_mqtt)
        
        
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
    
    func startRecording() throws {
       
       // Cancel the previous task if it's running.
       recognitionTask?.cancel()
       self.recognitionTask = nil
       print("here")
       // Configure the audio session for the app.
       let audioSession = AVAudioSession.sharedInstance()
       try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
       try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
       let inputNode = audioEngine.inputNode

       // Create and configure the speech recognition request.
       recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
       guard let recognitionRequest = recognitionRequest else { fatalError("Unable to create a SFSpeechAudioBufferRecognitionRequest object") }
       recognitionRequest.shouldReportPartialResults = true
       
       // Keep speech recognition data on device
       if #available(iOS 13, *) {
           recognitionRequest.requiresOnDeviceRecognition = false
       }
       // Create a recognition task for the speech recognition session.
       // Keep a reference to the task so that it can be canceled.
       recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
        var isFinal = false
        
        if let result = result {
            // Update the text view with the results.
            isFinal = result.isFinal
            var actualString = result.bestTranscription.formattedString;
            var listOfWords = actualString.components(separatedBy: " ")
            //print(actualString.components(separatedBy: " "))
            var command = listOfWords.suffix(2)
            let clientID = "CocoaMQTT-" + String(ProcessInfo().processIdentifier)+"2"
            let websocket = CocoaMQTTWebSocket(uri: "/mqtt")
            
            var mqtt = CocoaMQTT(clientID: clientID, host: "192.168.1.2", port: 1884, socket: websocket)
            mqtt.allowUntrustCACertificate = true
            mqtt.keepAlive = 60
            mqtt.delegate = self
            print(command)
            if !self.old_cmd.elementsEqual(Array(command))
            {
            if command == ["rotate","left"]
            {
                self.command_mqtt = "MoveTankDegrees 0 90 720"
                
                mqtt.connect()
                
            }
            if command == ["rotate","right"]
            {
                self.command_mqtt = "MoveTankDegrees 90 0 720"
                mqtt.connect()
            }
            if command == ["stop","stop"]
            {
                self.command_mqtt = "MoveTank 0 0";
                mqtt.connect()
            }
            if command == ["forward","10"]
                {
                    self.command_mqtt = "MoveTank 10 10"
                    mqtt.connect()
                }
            if command == ["forward","20"]
            {
            self.command_mqtt = "MoveTank 20 20"
            mqtt.connect()
            }
            if command == ["forward","30"]
                {
                    self.command_mqtt = "MoveTank 30 30"
                mqtt.connect()
                }
            if command == ["forward","40"]
                {
                    self.command_mqtt = "MoveTank 40 40"
                mqtt.connect()
                }
            if command == ["forward","50"]
                {
                    self.command_mqtt = "MoveTank 50 50"
                mqtt.connect()
                }
            if command == ["forward","60"]
                {
                    self.command_mqtt = "MoveTank 60 60"
                mqtt.connect()
                }
            if command == ["forward","60"]
                {
                    self.command_mqtt = "MoveTank 60 60"
                mqtt.connect()
                }
            if command == ["forward","70"]
                {
                    self.command_mqtt = "MoveTank 70 70"
                mqtt.connect()
                }
            if command == ["forward","80"]
                {
                    self.command_mqtt = "MoveTank 80 80"
                mqtt.connect()
                }
            if command == ["forward","90"]
                {
                    self.command_mqtt = "MoveTank 90 90"
                mqtt.connect()
                }
            if command == ["backward","10"]
                            {
                                self.command_mqtt = "MoveTank -10 -10"
                mqtt.connect()
                            }
                if command == ["backward","20"]
                {
                    self.command_mqtt = "MoveTank -20 -20"
                    mqtt.connect()
                }
                if command == ["backward","30"]
                            {
                                self.command_mqtt = "MoveTank -30 -30"
                    mqtt.connect()
                            }
                if command == ["backward","40"]
                            {
                                self.command_mqtt = "MoveTank -40 -40"
                    mqtt.connect()
                            }
                if command == ["backward","50"]
                            {
                                self.command_mqtt = "MoveTank -50 -50"
                    mqtt.connect()
                            }
                if command == ["backward","60"]
                            {
                                self.command_mqtt = "MoveTank -60 -60"
                    mqtt.connect()
                            }
                if command == ["backward","60"]
                            {
                                self.command_mqtt = "MoveTank -60 -60"
                    mqtt.connect()
                            }
                if command == ["backward","70"]
                            {
                                self.command_mqtt = "MoveTank -70 -70"
                    mqtt.connect()
                            }
                if command == ["backward","80"]
                            {
                                self.command_mqtt = "MoveTank -80 -80"
                    mqtt.connect()
                            }
                if command == ["backward","90"]
                            {
                                self.command_mqtt = "MoveTank -90 -90"
                    mqtt.connect()
                            }
            }
            self.old_cmd = Array(command)
        }
        
               // Update the text view with the results.
               //self.textView.text = result.bestTranscription.formattedStrin
           
           
         
       }
  
       // Configure the microphone input.
       let recordingFormat = inputNode.outputFormat(forBus: 0)
       inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
           self.recognitionRequest?.append(buffer)
       }
       
       audioEngine.prepare()
       try! audioEngine.start()
       // Let the user know to start talking.
       //textView.text = "(Go ahead, I'm listening)"
   }
   

   
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            
        } else {
          
        }
    }

 

    override func viewDidLoad() {
        

        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        let clientID = "CocoaMQTT-" + String(ProcessInfo().processIdentifier)
        let websocket = CocoaMQTTWebSocket(uri: "/mqtt")
        var mqtt = CocoaMQTT(clientID: clientID, host: "192.168.1.4", port: 1884, socket: websocket)
        mqtt.allowUntrustCACertificate = true
        mqtt.keepAlive = 60
        mqtt.delegate = self
    
  print(mqtt.connect())
//        SFSpeechRecognizer.requestAuthorization { authStatus in
//
//            // Divert to the app's main thread so that the UI
//            // can be updated.
//            OperationQueue.main.addOperation {
//                switch authStatus {
//                case .authorized:
//                    print("starting recording")
//                    try! self.startRecording()
//
//                case .denied:
//
//                    print("denied")
//                case .restricted:
//                   print("restricted")
//
//                case .notDetermined:
//                    print("have an egg")
//
//                default:
//                    print("default")
//                }
//            }
//        }
        

         
       
      
        
        
        
       
       
    }
  
}


