//: Playground - noun: a place where people can play

import UIKit
import Accelerate

func isBlurImage(_ image: UIImage) -> Bool {
    let laplacianKernel: [Int16] = [
        0, -1, 0,
        -1, 4, -1,
        0, -1, 0
    ]
    
    let divisor = 0
    let kernelSide = UInt32(3)

    let imageRef = image.cgImage!
    let aspect = Double(imageRef.height) / Double(imageRef.width)
    let context = CGContext.init(data: nil, width: 255, height: Int(255 * aspect), bitsPerComponent: 8, bytesPerRow: 0, space: CGColorSpaceCreateDeviceGray(), bitmapInfo: CGImageAlphaInfo.none.rawValue)!
    context.draw(imageRef, in: CGRect(x: 0, y: 0, width: 255, height: Int(255 * aspect)))
    var grayScaleImageRef = context.makeImage()!

    var pixelData = grayScaleImageRef.dataProvider!.data!
    var inBuffer = vImage_Buffer(data: UnsafeMutableRawPointer(mutating: CFDataGetBytePtr(pixelData)), height: UInt(grayScaleImageRef.height), width: UInt(grayScaleImageRef.width), rowBytes: grayScaleImageRef.bytesPerRow)

    var pixelBuffer = malloc(grayScaleImageRef.bytesPerRow * grayScaleImageRef.height)
    var outBuffer = vImage_Buffer(data: pixelBuffer, height: UInt(grayScaleImageRef.height), width: UInt(grayScaleImageRef.width), rowBytes: grayScaleImageRef.bytesPerRow)
    var error = vImageConvolve_Planar8(&inBuffer, &outBuffer, nil, 0, 0, laplacianKernel, kernelSide, kernelSide, Int32(divisor), 0, UInt32(kvImageCopyInPlace))

    var colorSpace = CGColorSpaceCreateDeviceGray()

    let length = Int(outBuffer.height) * outBuffer.rowBytes
    let uInt8Ptr = outBuffer.data.bindMemory(to: UInt8.self, capacity: length)
    let uInt8Buffer = UnsafeBufferPointer(start: uInt8Ptr, count: length)
    let output = Array(uInt8Buffer).map { Float($0) }
    free(pixelBuffer)

    var sum: Float = 0.0
    let size = Float(output.count)
    vDSP_sve(output, 1, &sum, vDSP_Length(output.count))

    let avg = sum / size

    let deviationSquare = output.reduce(0.0, { deviationSquare, next in
        return deviationSquare + (Float(next) - avg) * (Float(next) - avg)
    })

    let variance = Float(deviationSquare) / Float(size)
    print(variance)

    if (variance < 200) {
        return true
    }

    return false
}

var cat = #imageLiteral(resourceName: "cat.jpg")
let check = isBlurImage(cat)
print(check) //false

var noblur = #imageLiteral(resourceName: "noblur.jpg")
let check2 = isBlurImage(noblur)
print(check2) //false

var blur = #imageLiteral(resourceName: "blur.jpg")
let check3 = isBlurImage(blur)
print(check3) // true

var lena = #imageLiteral(resourceName: "lena.jpg")
let check4 = isBlurImage(lena)
print(check4) //false

var b1 = #imageLiteral(resourceName: "1.JPG")
let check5 = isBlurImage(b1)
print(check5) // true

var b2 = #imageLiteral(resourceName: "2.JPG")
let check6 = isBlurImage(b2)
print(check6) // true

var b3 = #imageLiteral(resourceName: "3.JPG")
let check7 = isBlurImage(b3)
print(check7) // true
