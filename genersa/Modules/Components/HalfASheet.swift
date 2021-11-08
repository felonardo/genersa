//
//  Modal.swift
//  genersa
//
//  Created by franklynw on 08/11/21.
//

import SwiftUI
import Combine


public struct HalfASheet<Content: View>: View {
    
    @Binding private var isPresented: Bool
    @State private var hasAppeared = false
    @State private var dragOffset: CGFloat = 0
    
    internal var height: HalfASheetHeight = .proportional(0.84) // about the same as a ColorPicker
    internal var contentInsets = EdgeInsets(top: 7, leading: 16, bottom: 12, trailing: 16)
    internal var backgroundColor: UIColor = .tertiarySystemGroupedBackground
    internal var closeButtonColor: UIColor = .gray
    internal var allowsDraggingToDismiss = true
    
    private let title: String?
    private let content: () -> Content
    private let cornerRadius: CGFloat = 15
    private let additionalOffset: CGFloat = 44 // this is so we can drag the sheet up a bit
    
    private var actualContentInsets: EdgeInsets {
        return EdgeInsets(top: contentInsets.top, leading: contentInsets.leading, bottom: cornerRadius + additionalOffset + contentInsets.bottom, trailing: contentInsets.trailing)
    }
    
    
    public init(isPresented: Binding<Bool>, title: String? = nil, @ViewBuilder content: @escaping () -> Content) {
        _isPresented = isPresented
        self.title = title
        self.content = content
    }
    
    
    public var body: some View {
        
        GeometryReader { geometry in
            
            ZStack {
                
                if isPresented {
                    
                    Color.black.opacity(0.15)
                        .onTapGesture {
                            dismiss()
                        }
                        .transition(.opacity)
                        .onAppear { // we don't want the content to slide up until the background has appeared
                            withAnimation {
                                hasAppeared = true
                            }
                        }
                        .onDisappear() {
                            withAnimation {
                                hasAppeared = false
                            }
                        }
                }
                
                if hasAppeared {
                    
                    VStack {
                        
                        Spacer()
                        
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: cornerRadius)
                                .foregroundColor(.white)
                            RoundedRectangle(cornerRadius: cornerRadius)
                                .foregroundColor(Color(backgroundColor))
                            
                            content()
                                .padding(actualContentInsets)
                            
                            titleView
                        }
                        .frame(height: height.value(with: geometry) + cornerRadius + additionalOffset)
                        .offset(y: cornerRadius + additionalOffset + dragOffset)
                    }
                    .transition(.verticalSlide(height.value(with: geometry)))
                    .highPriorityGesture(
                        dragGesture(geometry)
                    )
                    .onDisappear {
                        dragOffset = 0
                    }
                }
            }
        }
    }
}


// MARK: - Private
extension HalfASheet {
    
    private var titleView: IfLet {
        
        let titleView = IfLet(title) { title in
            
            VStack {
                HStack {
                    Image(systemName: "xmark.circle.fill")
                        .font(Font.title.weight(.semibold))
                        .opacity(0)
                        .padding(EdgeInsets(top: 10, leading: 13, bottom: 0, trailing: 0))
                    Spacer()
                    Text(title)
                        .font(Font.headline.weight(.semibold))
                        .padding(EdgeInsets(top: 18, leading: 0, bottom: 0, trailing: 0))
                        .lineLimit(1)
                    Spacer()
//                    closeButton
//                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 13))
                }
                Spacer()
            }
            
        } else: {
            
            VStack {
                HStack {
                    Spacer()
//                    closeButton
//                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 13))
                }
                Spacer()
            }
        }
        
        return titleView
    }
    
    private func dragGesture(_ geometry: GeometryProxy) -> _EndedGesture<_ChangedGesture<DragGesture>> {
        
        let gesture = DragGesture()
            .onChanged {
                
                guard allowsDraggingToDismiss else {
                    return
                }
                
                let offset = $0.translation.height
                dragOffset = offset > 0 ? offset : sqrt(-offset) * -3
            }
            .onEnded {
                
                guard allowsDraggingToDismiss else {
                    return
                }
                
                if dragOffset > 0, $0.predictedEndTranslation.height / $0.translation.height > 2 {
                    dismiss()
                    return
                }
                
                let validDragDistance = height.value(with: geometry) / 2
                if dragOffset < validDragDistance {
                    withAnimation {
                        dragOffset = 0
                    }
                } else {
                    dismiss()
                }
            }
        
        return gesture
    }
    
    private var closeButton: AnyView {
        
        let button = Button {
            dismiss()
        } label: {
            ZStack {
                Image(systemName: "xmark.circle.fill")
                    .font(Font.title.weight(.semibold))
                    .accentColor(Color(UIColor.lightGray.withAlphaComponent(0.2)))
                Image(systemName: "xmark.circle.fill")
                    .font(Font.title.weight(.semibold))
                    .accentColor(Color(closeButtonColor))
            }
        }
        
        return AnyView(button)
    }
    
    private func dismiss() {
        
        withAnimation {
            hasAppeared = false
            isPresented = false
        }
    }
}


public enum HalfASheetHeight {
    case fixed(CGFloat)
    case proportional(CGFloat)
    
    func value(with geometry: GeometryProxy) -> CGFloat {
        switch self {
        case .fixed(let height):
            return height
        case .proportional(let proportion):
            return geometry.size.height * proportion
        }
    }
}


struct If: View {
    
    private let viewProvider: () -> AnyView
    
    
    init<V: View>(_ isTrue: Binding<Bool>, @ViewBuilder _ viewProvider: @escaping () -> V) {
        self.viewProvider = {
            isTrue.wrappedValue ? AnyView(viewProvider()) : AnyView(EmptyView())
        }
    }
    
    init<V: View, O: View>(_ isTrue: Binding<Bool>, @ViewBuilder _ viewProvider: @escaping () -> V, @ViewBuilder else otherViewProvider: @escaping () -> O) {
        self.viewProvider = {
            isTrue.wrappedValue ? AnyView(viewProvider()) : AnyView(otherViewProvider())
        }
    }
    
    init<V: View>(_ condition: @autoclosure @escaping () -> Bool, @ViewBuilder _ viewProvider: @escaping () -> V) {
        self.viewProvider = {
            condition() ? AnyView(viewProvider()) : AnyView(EmptyView())
        }
    }
    
    init<V: View, O: View>(_ condition: @autoclosure @escaping () -> Bool, @ViewBuilder _ viewProvider: @escaping () -> V, @ViewBuilder else otherViewProvider: @escaping () -> O) {
        self.viewProvider = {
            condition() ? AnyView(viewProvider()) : AnyView(otherViewProvider())
        }
    }
    
    var body: some View {
        return viewProvider()
    }
}


struct IfLet: View {
    
    private let viewProvider: () -> AnyView
    
    
    init<T, V: View>(_ item: Binding<T?>, @ViewBuilder _ viewProvider: @escaping (T) -> V) {
        self.viewProvider = {
            AnyView(item.wrappedValue.map {
                viewProvider($0)
            })
        }
    }
    
    init<T, V: View, O: View>(_ item: Binding<T?>, @ViewBuilder _ viewProvider: @escaping (T) -> V, @ViewBuilder else otherViewProvider: @escaping () -> O) {
        self.viewProvider = {
            if let item = item.wrappedValue {
                return AnyView(viewProvider(item))
            } else {
                return AnyView(otherViewProvider())
            }
        }
    }
    
    init<T, V: View>(_ item: T?, @ViewBuilder _ viewProvider: @escaping (T) -> V) {
        self.viewProvider = {
            AnyView(item.map {
                viewProvider($0)
            })
        }
    }
    
    init<T, V: View, O: View>(_ item: T?, @ViewBuilder _ viewProvider: @escaping (T) -> V, @ViewBuilder else otherViewProvider: @escaping () -> O) {
        self.viewProvider = {
            if let item = item {
                return AnyView(viewProvider(item))
            } else {
                return AnyView(otherViewProvider())
            }
        }
    }
    
    var body: some View {
        return viewProvider()
    }
}


fileprivate struct VerticalSlideModifier: ViewModifier {
    
    let offset: CGFloat
    
    func body(content: Content) -> some View {
        
        content
            .offset(CGSize(width: 0, height: offset))
    }
}


extension AnyTransition {
    
    static func verticalSlide(_ offset: CGFloat? = nil) -> AnyTransition {
        
        .modifier(
            active: VerticalSlideModifier(offset: offset ?? UIScreen.main.bounds.height),
            identity: VerticalSlideModifier(offset: 0)
        )
    }
}


extension HalfASheet {
    
    /// The proportion of the containing view's height to use for the height of the HalfASheet
    /// - Parameter height: a HalfASheetHeight case - either .fixed(required height in pixels) or .proportional(proportion of the containing view's height - 1 is 100% of the height)
    public func height(_ height: HalfASheetHeight) -> Self {
        var copy = self
        copy.height = height
        return copy
    }
    
    /// Insets to use around the content of the HalfASheet
    /// - Parameter contentInsets: an EdgeInsets instance
    public func contentInsets(_ contentInsets: EdgeInsets) -> Self {
        var copy = self
        copy.contentInsets = contentInsets
        return copy
    }
    
    /// The background colour for the HalfASheet
    /// - Parameter backgroundColor: a UIColor
    public func backgroundColor(_ backgroundColor: UIColor) -> Self {
        var copy = self
        copy.backgroundColor = backgroundColor
        return copy
    }
    
    /// The color for the close button
    /// - Parameter closeButtonColor: a UIColor
    public func closeButtonColor(_ closeButtonColor: UIColor) -> Self {
        var copy = self
        copy.closeButtonColor = closeButtonColor
        return copy
    }
    
    /// Use this to disable the drag-downwards-to-dismiss functionality
    public var disableDragToDismiss: Self {
        var copy = self
        copy.allowsDraggingToDismiss = false
        return copy
    }
}


extension View {
    
    /// View extension in the style of .sheet - offers no real customisation. If more flexibility is required, use HalfASheet(...) directly, and apply the required modifiers
    /// - Parameters:
    ///   - isPresented: binding to a Bool which controls whether or not to show the partial sheet
    ///   - title: an optional title for the sheet
    ///   - content: the sheet's content
    public func halfASheet<T: View>(isPresented: Binding<Bool>, title: String? = nil, @ViewBuilder content: @escaping () -> T) -> some View {
        modifier(HalfASheetPresentationModifier(content: { HalfASheet(isPresented: isPresented, title: title, content: content) }))
    }
}


struct HalfASheetPresentationModifier<SheetContent>: ViewModifier where SheetContent: View {
    
    var content: () -> HalfASheet<SheetContent>
    
    init(@ViewBuilder content: @escaping () -> HalfASheet<SheetContent>) {
        self.content = content
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
            self.content()
        }
    }
}


