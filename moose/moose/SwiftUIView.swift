//
//  SwiftUIView.swift
//  Moose
//
//  Created by Samuel Brasileiro on 17/11/20.
//

import SwiftUI
struct PaintingView: View{
    @ObservedObject var painting: Painting
    
    var body: some View{
        VStack{
        if painting.image != nil{
            Image(uiImage: painting.image!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(8)
        }
        else{
            
        }
        Text(painting.name)
            .font(.title3)
            .bold()
        if let name = painting.artist{
            Text(name)
                .foregroundColor(Color(.systemGray2))
                .font(.subheadline)
        }
        }
    }
    
}

struct SwiftUIView: View {
    @ObservedObject var bank: PaintingsBank
    var body: some View {
        VStack{
            Spacer()
                .frame(minHeight: 0, idealHeight: 300, maxHeight: 300)
                .background(Color.clear)
            VStack{
                SearchBarView(bank: bank)
                ScrollView(.vertical, showsIndicators: true){
                    LazyVGrid(columns: [GridItem(), GridItem()], alignment: .leading, spacing: 6){
                        ForEach(0..<bank.paintings.count, id: \.self){ index in
                            PaintingView(painting: bank.paintings[index])
                        }
                    }
                    .padding(.leading)
                }
            }
            .padding()
            .background(Color(.systemBackground))
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView(bank: PaintingsBank())
    }
}
