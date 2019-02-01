//
//  ViewController.swift
//  UsingFiles
//
//  Created by Tim Richardson on 10/05/2018.
//  Copyright © 2018 iOS Mastery. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController, UIDocumentPickerDelegate {
    
//    @IBAction func writeFiles(_ sender: Any) {
//
////        let file = "\(UUID().uuidString).txt"
//        let file = "test.txt"
//        let contents = "Some text..."
//
//        print(file)
//
//        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//        let fileURL = dir.appendingPathComponent(file)
//
//        print(fileURL)
//
//        do {
//            try contents.write(to: fileURL, atomically: false, encoding: .utf8)
//        }
//        catch {
//            print("Error: \(error)")
//        }
//    }
    
    @IBOutlet weak var tekst: UITextView!
    
    @IBAction func importFiles(_ sender: Any) {
        
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypeCommaSeparatedText as String], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        present(documentPicker, animated: true, completion: nil)
    }
   
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        var readString = ""
        
        guard let selectedFileURL = urls.first else {
            return
        }
        
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let sandboxFileURL = dir.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            print("Already exists! Do nothing")
        }
        else {
            
            do {
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                
                print("Copied file!")
            }
            catch {
                print("Error: \(error)")
            }
        }
        
        // Lese innholdet i filen
        
        do {
            readString = try String(contentsOf: sandboxFileURL)
            print(readString)
            
        } catch let error as NSError {
            print("Failed to read file")
            print(error)
        }
        
        print("Contents of this file: \(readString)")
        
        tekst.text = readString
        
    }
}




























