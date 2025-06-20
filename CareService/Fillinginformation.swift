//
//  Fillinginformation.swift
//  CareService
//
//  Created by Kamila Ponomarova on 2025-05-22.
//



import SwiftUI

struct Fillinginformation1: View {
    @State var firebase = Firebasecode()
    @State private var showAlert = true
    @State private var navigateTo: String?

    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                ZStack {
                    Color("background").ignoresSafeArea()

                    VStack(spacing: 20) {
                        Text("List of symptoms")
                            .font(.title)
                            .fontWeight(.heavy)
                            .padding(.top, 40)

                        VStack(alignment: .leading, spacing: 15) {
                            symptomButton(label: "Weight", destination: BodyWeightView1())
                            symptomButton(label: "Pressure", destination: BloodPressureView1())
                            symptomButton(label: "Oxygen & pulse", destination: OxygenPulseView1())
                            symptomButton(label: "Body temperature", destination: BodyTemperatureView())
                            symptomButton(label: "Sugar level", destination: Frame21View())
                        }
                        .frame(maxWidth: 300)

                        Spacer()
                    }
                    .padding()
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("NOTICE"),
                        message: Text("The information you specify about yourself or your care receiver in these fields will be saved for the purposes of determining optimal procedures of care."),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
        }
    }

    @ViewBuilder
    private func symptomButton<Destination: View>(label: String, destination: Destination) -> some View {
        NavigationLink(destination: destination) {
            HStack {
                Text(label)
                    .foregroundColor(.black)
                    .fontWeight(.medium)
                Spacer()
                Circle()
                    .stroke(lineWidth: 4)
                    .frame(width: 33, height: 33)
                    .overlay(Text("➕"))
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
        }
    }
}

#Preview {
    Fillinginformation1()
}
