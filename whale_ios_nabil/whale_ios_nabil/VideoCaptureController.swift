//
//  VideoCaptureController.swift
//  whale_ios_nabil
//
//  Created by Nabil K on 2017-05-08.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import UIKit
import AVFoundation

class VideoCaptureController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

    
    let session = AVCaptureSession()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVideoCapture()
        self.view.layer.addSublayer(previewLayer)
        session.startRunning()
        
        // Do any additional setup after loading the view.
    }

    
    lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        let preview =  AVCaptureVideoPreviewLayer(session: self.session)!
        preview.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        preview.position = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
        preview.videoGravity = AVLayerVideoGravityResize
        return preview
    }()

    
    func setupVideoCapture(){
        
        session.sessionPreset = AVCaptureSessionPresetLow
        
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo) as AVCaptureDevice
        
        do {
            let deviceInput = try AVCaptureDeviceInput(device: captureDevice)
            
            session.beginConfiguration()
            
            if (session.canAddInput(deviceInput) == true) {
                session.addInput(deviceInput)
            }
            
            let dataOutput = AVCaptureVideoDataOutput()
            
            dataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString) : NSNumber(value: kCVPixelFormatType_420YpCbCr8BiPlanarFullRange as UInt32)]
            
            dataOutput.alwaysDiscardsLateVideoFrames = true
            
            if (session.canAddOutput(dataOutput) == true) {
                session.addOutput(dataOutput)
            }
            
            session.commitConfiguration()
            
            let queue = DispatchQueue(label: "com.invasivecode.videoQueue")
            dataOutput.setSampleBufferDelegate(self, queue: queue)
            
        }
        catch let error as NSError {
            NSLog("\(error), \(error.localizedDescription)")
        }
    }
    
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
        
        print("getting called here")
        
    }

}
