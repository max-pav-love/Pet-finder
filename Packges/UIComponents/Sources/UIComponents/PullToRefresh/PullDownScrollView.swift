import Foundation
import SwiftUI
import UIKit

public struct PullDownScrollView<Content: View>: UIViewRepresentable {
    
    var content: Content
    var onRefresh: (UIRefreshControl) -> ()
    var refreshControl = UIRefreshControl()
    var title = NSAttributedString(string: "Updating")
    
    public init(
        @ViewBuilder content: @escaping () -> Content,
        onRefresh: @escaping (UIRefreshControl) -> ()
    ) {
        self.content = content()
        self.onRefresh = onRefresh
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    public func makeUIView(context: Context) -> UIScrollView {
        let uiScrollView = UIScrollView()
        
        refreshControl.attributedTitle = title
        refreshControl.tintColor = .gray
        refreshControl.addTarget(
            context.coordinator,
            action: #selector(context.coordinator.onRefresh),
            for: .valueChanged)
        
        setUpView(uiScrollView: uiScrollView)
        
        uiScrollView.refreshControl = refreshControl
        
        return uiScrollView
    }
    
    public func updateUIView(_ uiView: UIScrollView, context: Context) {
        setUpView(uiScrollView: uiView)
    }

    func setUpView(uiScrollView: UIScrollView) {
        let hostView = UIHostingController(rootView: content.frame(maxHeight: .infinity, alignment: .top))
        hostView.view.backgroundColor = .clear
        
        hostView.view.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            hostView.view.topAnchor.constraint(equalTo: uiScrollView.topAnchor),
            hostView.view.bottomAnchor.constraint(equalTo: uiScrollView.bottomAnchor),
            hostView.view.leadingAnchor.constraint(equalTo: uiScrollView.leadingAnchor),
            hostView.view.trailingAnchor.constraint(equalTo: uiScrollView.trailingAnchor),
            hostView.view.widthAnchor.constraint(equalTo: uiScrollView.widthAnchor),
            hostView.view.heightAnchor.constraint(greaterThanOrEqualTo: uiScrollView.heightAnchor, constant: 1)
        ]
        uiScrollView.subviews.last?.removeFromSuperview()
        uiScrollView.addSubview(hostView.view)
        uiScrollView.addConstraints(constraints)
    }
    
    public class Coordinator: NSObject {
        
        var parent: PullDownScrollView
        
        init(parent: PullDownScrollView) {
            self.parent = parent
        }
        
        @objc func onRefresh() {
            parent.onRefresh(parent.refreshControl)
        }
    }
}
