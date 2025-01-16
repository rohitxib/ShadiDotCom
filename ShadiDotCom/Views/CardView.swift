//
//  CardView.swift
//  ShadiDotCom
//
//  Created by Rohit on 16/01/25.
//

import SwiftUI

struct CardView: View {
     var userDetail: Person
    var ansCalback : (_ userDetail: Person)->()
    
    var body: some View {
        VStack(alignment: .center) {
            
            // load image from server
            AsyncImage(url: URL(string: getProfilPicUrl())) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
            } placeholder: {
                ProgressView()
            }
            
            Text(getName())
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .lineLimit(1)
            
            // Address
            Text(getLocation())
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(2)
            
            // Divider
            Divider()
                .padding(.top, 10)
            if let answered = userDetail.aceptedOrRejected {
                Text(answered)
                    .frame(width: 200,height: 50)
                    .foregroundColor(.white)
                    .background(answered == "Accepted" ?.green :.red)
                    .cornerRadius(15)
            }else{
            HStack{
                Button(action: {
                    print("check")
                    userDetail.aceptedOrRejected = "Accepted"
                    DbManager.shared.saveContext()
                    self.ansCalback(userDetail)
                },
                       label: {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .scaledToFit()
                        .cornerRadius(18)
                        .padding()
                        .foregroundColor(.blue)
                }
                ).buttonStyle(.plain)
                Spacer()
                Button(action: {
                    print("uncheck")
                    userDetail.aceptedOrRejected = "Declinend"
                    DbManager.shared.saveContext()
                    self.ansCalback(userDetail)
                },
                       label: {
                    Image(systemName: "xmark.seal.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .scaledToFit()
                        .cornerRadius(18)
                        .padding()
                        .foregroundColor(.red)
                }
                ).buttonStyle(.plain)
            }.padding([.leading,.trailing],50)
        }
          
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
        //.frame(width: 250)
    }
    
    func getProfilPicUrl() -> String {
        var imgUrl = "https://randomuser.me/api/portraits/med/men/6.jpg"

        if let ansrArray = userDetail.picture {
            let answer = ansrArray as AnyObject
            imgUrl = answer["medium"] as? String ?? "https://randomuser.me/api/portraits/med/men/6.jpg"
        }
        return imgUrl
    }
    func getName() -> String {
        var fullName = ""

        if let ansrArray = userDetail.name {
            let answer = ansrArray as AnyObject
           let fName = answer["first"] as? String ?? ""
            let LName = answer["last"] as? String ?? ""
            fullName = fName + " " + LName
        }
        return fullName
    }
    
    func getLocation() -> String {
        var fullName = ""

        if let ansrArray = userDetail.location {
            let answer = ansrArray as AnyObject
           let postcode = answer["postcode"] as? Int ?? 0
            let city = answer["city"] as? String ?? ""
            let state = answer["state"] as? String ?? ""

            fullName = "\(postcode) \(city) \(state)"
        }
        return fullName
    }
}


//#Preview {
//    CardView()
//}
