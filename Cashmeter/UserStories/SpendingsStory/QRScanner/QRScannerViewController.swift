//
//  QRScannerViewController.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 15/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit
import AVFoundation

class QRScannerViewController: UIViewController {
    
    let borderWidth: CGFloat = 3
    let borderColor: UIColor = .blue
    let borderSizeMultiplier: CGFloat = 0.8
    
    var video: AVCaptureVideoPreviewLayer!
    
    var moduleOutput: QRScannerModuleOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAVCaptureSession()
        setupSquareView()
    }
    
    func setupSquareView() {
        let squareView: UIView = {
            let squareView = UIView()
            squareView.frame.size.width = borderSizeMultiplier * self.view.frame.width
            squareView.frame.size.height = borderSizeMultiplier * self.view.frame.width
            squareView.center = view.center

            squareView.layer.borderWidth = borderWidth
            squareView.layer.borderColor = borderColor.cgColor
            
            return squareView
        }()
        
        self.view.addSubview(squareView)
        self.view.bringSubview(toFront: squareView)
    }
    
}

extension QRScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    func setupAVCaptureSession() {
        let session = AVCaptureSession()
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            session.addInput(input)
        } catch {
            print ("Can't create input for scan QR code")
        }
        
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        output.metadataObjectTypes = [.qr]
        
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = view.layer.bounds
        view.layer.addSublayer(video)
        
        session.startRunning()
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if !metadataObjects.isEmpty,
            let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject,
            object.type == .qr,
            let scannedString = object.stringValue {
            self.dismiss(animated: true) {
                self.moduleOutput.scanIsFinished(scannedString)
            }
        }
    }
    
}
