//
//  SectionPicker.swift
//  Desserts
//
//  Created by Logan Parmeter on 6/21/24.
//

import Foundation
import SwiftUI

struct SectionPicker<SelectionValue, Content>: View
where SelectionValue: Hashable,
      Content: View
{
    @Binding var selection: SelectionValue
    @Binding var items: [SelectionValue]
    
    private var selectionColor: Color = .pink
    
    private var content: (SelectionValue) -> Content
    
    @Namespace private var pickerTransition
    
    init(selection: Binding<SelectionValue>, items: Binding<[SelectionValue]>, selectionColor: Color = .pink, content: @escaping (SelectionValue) -> Content) {
        self._selection = selection
        self._items = items
        self.selectionColor = selectionColor
        self.content = content
    }
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: [GridItem(.flexible())], spacing: 8.0) {
                    ForEach(items, id: \.self) { item in
                        itemView(item: item)
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    selection = item
                                }
                            }
                            .onChange(of: selection) {
                                withAnimation(.easeInOut) {
                                    proxy.scrollTo(selection)
                                }
                            }
                    }
                }
                .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            }}
    }
    
    @ViewBuilder
    func itemView(item: SelectionValue) -> some View {
        let selected = selection == item
        
        VStack {
            if selected {
                content(item).id(item)
                    .font(.subheadline)
                    .foregroundStyle(Color.pink)
                    .padding(.horizontal)
                    .padding(.vertical, 8.0)
                Divider()
                    .frame(height: 4.0)
                    .overlay(Color.pink)
                    .matchedGeometryEffect(id: "picker", in: pickerTransition)
            } else {
                content(item).id(item)
                    .font(.subheadline)
                    .foregroundStyle(Color.black)
                    .padding(.horizontal)
                    .padding(.vertical, 8.0)
                Divider()
                    .frame(height: 4.0)
                    .opacity(0.0)
            }
        }
    }
    
}
