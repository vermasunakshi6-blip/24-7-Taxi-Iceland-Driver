import Foundation
import AppKit

let fm = FileManager.default
let root = fm.currentDirectoryPath
let srcPath = "\(root)/assets/images/logo.png"
let whiteSrcPath = "\(root)/assets/images/logo_white_bg.png"
let iconsetPath = "\(root)/ios/Runner/Assets.xcassets/AppIcon.appiconset"

guard let srcImage = NSImage(contentsOfFile: srcPath) else {
    fputs("Could not load source image at \(srcPath)\n", stderr)
    exit(1)
}

func flattenedWhite(_ image: NSImage) -> NSImage? {
    guard let tiff = image.tiffRepresentation,
          let rep = NSBitmapImageRep(data: tiff) else { return nil }
    let size = NSSize(width: rep.pixelsWide, height: rep.pixelsHigh)
    let out = NSImage(size: size)
    out.lockFocus()
    NSColor.white.setFill()
    NSRect(origin: .zero, size: size).fill()
    image.draw(in: NSRect(origin: .zero, size: size),
               from: .zero,
               operation: .sourceOver,
               fraction: 1.0)
    out.unlockFocus()
    return out
}

func pngData(from image: NSImage, width: Int, height: Int) -> Data? {
    let size = NSSize(width: width, height: height)
    let scaled = NSImage(size: size)
    scaled.lockFocus()
    NSColor.white.setFill()
    NSRect(origin: .zero, size: size).fill()
    image.draw(in: NSRect(origin: .zero, size: size),
               from: .zero,
               operation: .sourceOver,
               fraction: 1.0)
    scaled.unlockFocus()

    guard let tiff = scaled.tiffRepresentation,
          let rep = NSBitmapImageRep(data: tiff) else { return nil }
    return rep.representation(using: .png, properties: [:])
}

guard let whiteImage = flattenedWhite(srcImage) else {
    fputs("Could not flatten source image\n", stderr)
    exit(1)
}

let outputs: [(String, Int)] = [
    ("Icon-App-20x20@1x.png", 20),
    ("Icon-App-20x20@2x.png", 40),
    ("Icon-App-20x20@3x.png", 60),
    ("Icon-App-29x29@1x.png", 29),
    ("Icon-App-29x29@2x.png", 58),
    ("Icon-App-29x29@3x.png", 87),
    ("Icon-App-40x40@1x.png", 40),
    ("Icon-App-40x40@2x.png", 80),
    ("Icon-App-40x40@3x.png", 120),
    ("Icon-App-60x60@2x.png", 120),
    ("Icon-App-60x60@3x.png", 180),
    ("Icon-App-76x76@1x.png", 76),
    ("Icon-App-76x76@2x.png", 152),
    ("Icon-App-83.5x83.5@2x.png", 167),
    ("Icon-App-1024x1024@1x.png", 1024),
]

for (name, size) in outputs {
    guard let data = pngData(from: whiteImage, width: size, height: size) else {
        fputs("Failed to render \(name)\n", stderr)
        exit(1)
    }
    let outPath = "\(iconsetPath)/\(name)"
    do {
        try data.write(to: URL(fileURLWithPath: outPath), options: .atomic)
        print("Wrote \(name)")
    } catch {
        fputs("Failed writing \(outPath): \(error)\n", stderr)
        exit(1)
    }
}

if let data = pngData(from: whiteImage, width: 1024, height: 1024) {
    do {
        try data.write(to: URL(fileURLWithPath: whiteSrcPath), options: .atomic)
        print("Wrote logo_white_bg.png")
    } catch {
        fputs("Failed writing white source: \(error)\n", stderr)
        exit(1)
    }
}

print("Done.")
