//
//  UserListView.swift
//  ShadiDotCom
//
//  Created by Rohit on 16/01/25.
//

import SwiftUI

struct UserListView: View {
    @ObservedObject var viewModel = UserListViewModel()
    
    var body: some View {
        VStack{
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let documentsDirectory = paths[0]
            let _ =   print("******🚫🎩✨🐰DOCUMENT_DIRECTORY\(documentsDirectory)")
            Text("Profile Matches")
                .font(.system(size: 25, weight: .bold, design: .default))
                .foregroundColor(.black)
            Spacer()
            List(viewModel.personList, id: \.self) { item  in
                CardView(userDetail: item,  ansCalback: { userDetail in
                    print("DELETE RECORD FROM DB AND API")
                    viewModel.getUsersLocal()
                })
            } .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
                .listStyle(PlainListStyle())
        }.background(Color.gray.opacity(0.2))
     
        .onAppear {
             viewModel.getUsersLocal()
            viewModel.getApiData()
        }
    }
}


#Preview {
    UserListView()
}
