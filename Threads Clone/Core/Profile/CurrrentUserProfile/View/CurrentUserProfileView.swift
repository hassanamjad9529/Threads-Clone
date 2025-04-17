//
//  CurrentUserProfileView.swift
//  Threads Clone
//
//  Created by Hassan Amjad on 23/03/2025.
//

import SwiftUI

struct CurrentUserProfileView: View {

    @StateObject var viewModel = ProfileViewModel()
    var body: some View {

        NavigationStack {
            ScrollView(showsIndicators: false) {

                VStack(spacing: 20) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 12) {

                            VStack(alignment: .leading, spacing: 4) {
                                Text(currentUser?.fullname ?? "")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                Text(currentUser?.username ?? "")
                                    .font(.subheadline)

                            }
                            if let bio = currentUser?.bio {
                                Text(bio)
                                    .font(.footnote)
                            }

                            Text("2 followers")
                                .font(.caption)
                                .foregroundColor(.gray)


                        }
                        Spacer()
                        CircularProfileImageView()
                    }
                    Button {

                    }label: {
                        Text("follow")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: 352, height: 32)
                            .background(.black)
                            .cornerRadius(8)
                    }
                    VStack{
                        HStack{
                            ForEach(ProfileThreadFilter.allCases){
                                filter in VStack {
                                    Text(filter.title)
                                        .font(.subheadline)
                                        .fontWeight(
                                            selectedFilter == filter ? .semibold
                                            : .regular)

                                    if selectedFilter == filter {
                                        Rectangle()
                                            .foregroundColor(.black)
                                            .frame(width: filterBarWidth, height: 1)
                                            .matchedGeometryEffect(
                                                id: "item",
                                                in: animation
                                            )
                                    } else {
                                        Rectangle()
                                            .foregroundColor(.clear)
                                            .frame(width: filterBarWidth, height: 1)
                                    }
                                }.onTapGesture{
                                    withAnimation(.spring()){
                                        selectedFilter = filter
                                    }
                                }
                            }
                        }
                        LazyVStack{
                            ForEach(0...10, id:\.self){
                                thread in ThreadCell()
                            }
                        }
                    }.padding(.vertical, 8)

                }





            }
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        AuthService.shared
                        .signOut()
                        print("DEBUG: Signed Out")
                    }label: {
                        Image(systemName: "line.horizontal.3")
                    }

                }
            }
            .padding(.horizontal)


        }

    }
}

#Preview {
    CurrentUserProfileView()
}
