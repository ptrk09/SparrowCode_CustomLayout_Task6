import SwiftUI

struct ContentView: View {
    @State var isDiagonalMode: Bool = false

    var body: some View {
        ZStack {
            Content()
                .onTapGesture {
                    withAnimation {
                        isDiagonalMode.toggle()
                    }
                }
        }
    }
}

extension ContentView {
    @ViewBuilder
    private func Content() -> some View {
        let currntLayout = isDiagonalMode
            ? AnyLayout(DiagonalLayout())
            : AnyLayout(HStackLayout())

        currntLayout {
            ForEach(0..<7) {index in
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.link)
                    .aspectRatio(1, contentMode: .fit)
            }
        }
    }
}

private struct DiagonalLayout: Layout {
    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) -> CGSize {
        proposal.replacingUnspecifiedDimensions()
    }

    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) {
        let height = bounds.height / CGFloat(subviews.count)

        for (index, subview) in subviews.enumerated() {
            let x = bounds.minX + CGFloat(index) * (bounds.width - height) / CGFloat(subviews.count - 1)
            let y = (bounds.maxY - height) - (height * CGFloat(index))
            subview.place(
                at: CGPoint(x: x, y: y),
                proposal: ProposedViewSize(width: height, height: height)
            )
        }
    }
}

#Preview {
    ContentView()
}
