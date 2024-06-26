//
//  SectionView.swift
//  Desserts
//
//  Created by Logan Parmeter on 6/21/24.
//

import SwiftUI

/// A generic view that displays custom section content with a given section title.
struct SectionView<Content>: View
where Content: View
{
    var title: LocalizedStringKey
    var content: () -> Content
    
    init(title: LocalizedStringKey, content: @escaping () -> Content) {
        self.title = title
        self.content = content
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Text(title)
                .font(.headline)
            
            content()
        }
    }
}
