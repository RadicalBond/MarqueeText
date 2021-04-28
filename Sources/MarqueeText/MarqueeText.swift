import SwiftUI

public struct MarqueeText : View {
    public var text = ""
    public var font: UIFont
    public var leftFade: CGFloat
    public var rightFade: CGFloat
    public var startDelay: Double

    @State private var animate = false

    public var body : some View {
        let stringWidth = text.widthOfString(usingFont: font)
        let stringHeight = text.heightOfString(usingFont: font)
        return ZStack {
            GeometryReader { geometry in
                Group {
                    Text(self.text).lineLimit(1)
                        .font(.init(font))
                        .offset(x: self.animate ? -stringWidth - stringHeight * 2 : 0)
                        .animation(self.animate ? Animation.linear(duration: Double(stringWidth) / 30).delay(startDelay).repeatForever(autoreverses: false) : Animation.linear(duration: 0.0))
                        .onAppear { self.animate = geometry.size.width < stringWidth }
                        .onDisappear { self.animate = false }
                        .fixedSize(horizontal: true, vertical: false)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)

                    Text(self.text).lineLimit(1)
                        .font(.init(font))
                        .offset(x: self.animate ? 0 : stringWidth + stringHeight * 2)
                        .animation(self.animate ? Animation.linear(duration: Double(stringWidth) / 30).delay(startDelay).repeatForever(autoreverses: false) : Animation.linear(duration: 0.0))
                        .fixedSize(horizontal: true, vertical: false)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                }.offset(x: leftFade)
                .marqueeMask(leftFade: leftFade, rightFade: rightFade)
                .frame(width: geometry.size.width + leftFade).offset(x: leftFade * -1)
            }
        }.frame(height: stringHeight)
    }
    
    public init(text: String, font: UIFont, leftFade: CGFloat, rightFade: CGFloat, startDelay: Double) {
        self.text = text
        self.font = font
        self.leftFade = leftFade
        self.rightFade = rightFade
        self.startDelay = startDelay
    }
}

extension String {

    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }

    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }
}
