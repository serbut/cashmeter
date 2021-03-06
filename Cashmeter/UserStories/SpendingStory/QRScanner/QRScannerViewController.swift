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
    let borderColor: UIColor = .primary
    let borderSizeMultiplier: CGFloat = 0.8
    let closeButtonInset: CGFloat = 20.0
    let closeButtonCornerRadius: CGFloat = 8.0
    let closeButtonEdgeInset: CGFloat = 5.0

    let isStatusBarInitiallyHidden = UIApplication.shared.isStatusBarHidden
    
    var video: AVCaptureVideoPreviewLayer!
    
    var moduleOutput: QRScannerModuleOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAVCaptureSession()
        setupSquareView()
        setupCloseButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.isStatusBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.isStatusBarHidden = isStatusBarInitiallyHidden
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func setupSquareView() {
        let squareView: UIView = {
            let squareView = UIView()
            squareView.frame.size.width = borderSizeMultiplier * view.frame.width
            squareView.frame.size.height = borderSizeMultiplier * view.frame.width
            squareView.center = view.center

            squareView.layer.borderWidth = borderWidth
            squareView.layer.borderColor = borderColor.cgColor
            
            return squareView
        }()
        
        view.addSubview(squareView)
        view.bringSubview(toFront: squareView)
    }
    
    private func setupCloseButton() {
        let closeButton: UIButton = {
            let button = UIButton()
            let image = #imageLiteral(resourceName: "close_bar_button").withRenderingMode(.alwaysTemplate)
            button.setImage(image, for: .normal)
            button.tintColor = .white
            button.backgroundColor = .lightGraySemiTransparent
            button.layer.cornerRadius = closeButtonCornerRadius
            button.contentEdgeInsets = UIEdgeInsets(top: closeButtonEdgeInset,
                                                    left: closeButtonEdgeInset,
                                                    bottom: closeButtonEdgeInset,
                                                    right: closeButtonEdgeInset)
            button.addTarget(self, action: #selector(closeModule), for: .touchUpInside)

            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        view.addSubview(closeButton)
        
        let horizontalConstraint = NSLayoutConstraint(item: closeButton,
                                                      attribute: NSLayoutAttribute.top,
                                                      relatedBy: NSLayoutRelation.equal,
                                                      toItem: view,
                                                      attribute: NSLayoutAttribute.top,
                                                      multiplier: 1,
                                                      constant: closeButtonInset)
        let verticalConstraint = NSLayoutConstraint(item: closeButton,
                                                    attribute: NSLayoutAttribute.leading,
                                                    relatedBy: NSLayoutRelation.equal,
                                                    toItem: view,
                                                    attribute: NSLayoutAttribute.leading,
                                                    multiplier: 1,
                                                    constant: closeButtonInset)
        view.addConstraints([horizontalConstraint, verticalConstraint])

        
        view.bringSubview(toFront: closeButton)
    }
    
    @objc func closeModule() {
        dismiss(animated: true, completion: nil)
    }
    
}

extension QRScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    fileprivate func setupAVCaptureSession() {
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
            dismiss(animated: true) {
                self.moduleOutput.scanIsFinished(scannedString)
            }
        }
    }
    
}
