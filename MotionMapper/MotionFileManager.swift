/// Copyright (c) iDarkDuck. All rights reserved.
	

import Foundation

class MotionFileManager: NSObject {
    
    var filename: String
    
    init(filename: String) {
        self.filename = filename
    }
    
    func clearFile() {
        let str = ""
        let fileURL = getFile(filename: self.filename)
        do {
            try str.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
        }
        catch {/* error handling here */}
    }
    
    func readFile2() -> String {
       if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let fileURL = dir.appendingPathComponent(self.filename)
           do {
               let str = try String(contentsOf: fileURL, encoding: .utf8)
               return str
           }
           catch { return "Error"}
       }
        return "Error"
    }
    
    func readFile() -> String {
        let fileURL = getFile(filename: self.filename)
        do {
            let text = try String(contentsOf: fileURL, encoding: String.Encoding.utf8)
            return text
        }
        catch {
            print("Error reading from: ", self.filename)
            return "Error"
        }
    }
    
    func writeToFile(string : String){
        let str = string + "\n \n"
        let fileURL = getFile(filename: self.filename)
//        print("WRITING TO FILE: ", self.filename, str)
        do {
            let fileHandle = try FileHandle(forWritingTo: fileURL)
                 fileHandle.seekToEndOfFile()
                 fileHandle.write(str.data(using: .utf8)!)
                 fileHandle.closeFile()
        }
        catch {/* error handling here */}
    }
    
    func getFile(filename: String) -> URL {
        return getDocumentsDirectory().appendingPathComponent(filename)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
//    func test() {
//        self.clearFile()
//        print("Before: ")
//        self.readFile()
//        self.writeToFile("line 1")
//        self.writeToFile("line 2")
//        print("After: ")
//        self.readFile()
//        print("\n")
//    }
}
