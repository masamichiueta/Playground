import Accelerate
import UIKit

let start = Date()

let image = CIImage(image: #imageLiteral(resourceName: "blur.jpg"))
var filter = CIFilter(name: "CIEdges")!
filter.setValue(image, forKey: kCIInputImageKey)

let cicontext = CIContext()
let result = filter.outputImage!
let cgimage = cicontext.createCGImage(result, from: result.extent)!

let cgcontext = CGContext.init(data: nil, width: cgimage.width, height: cgimage.height, bitsPerComponent: 8, bytesPerRow: 0, space: CGColorSpaceCreateDeviceGray(), bitmapInfo: CGImageAlphaInfo.none.rawValue)!
cgcontext.draw(cgimage, in: CGRect(x: 0, y: 0, width: cgimage.width, height: cgimage.height))
var grayScaleImageRef = cgcontext.makeImage()!

let data = grayScaleImageRef.dataProvider?.data!
var length = CFDataGetLength(data)
var rawData = [UInt8](repeating: 0, count: length)
CFDataGetBytes(data, CFRange(location: 0, length: length), &rawData)

let bb = UIImage(cgImage: grayScaleImageRef)

var a = rawData.map { Double($0) }

//var sum = 0.0
//var vari = 0.0
//
//for d in rawData {
//    vari += Double(d) * Double(d)
//    sum += Double(d)
//}
//
//var avg = sum / Double(rawData.count)
//vari = vari / Double(rawData.count) - avg * avg
//print(vari)

var mn = 0.0
var sddev = 0.0
vDSP_normalizeD(a, 1, nil, 1, &mn, &sddev, vDSP_Length(a.count))

print("mn \(mn)")
print("sddev \(sddev)")

let elapsed = Date().timeIntervalSince(start)
print("elapsed \(elapsed)")

