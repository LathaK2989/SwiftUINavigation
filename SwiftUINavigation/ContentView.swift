//
//  ContentView.swift
//  SwiftUINavigation
//
//  Created by Srilatha on 2024-10-05.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        View1() // View1 handles showing and hiding of View2
    }
}

struct View1: View {
    @State private var showView2 = false  // Local state to manage View2 visibility
    
    var body: some View {
        ZStack {
            Color.blue.opacity(0.3).edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("View 1")
                    .font(.largeTitle)
                    .padding()
                
                Button("Show View 2") {
                    withAnimation {
                        showView2 = true
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
            }

            // Conditionally show View2 within the same ZStack
            if showView2 {
                View2(isPresented: $showView2)
                    .transition(.identity)
                    .zIndex(1)
            }
        }
        .animation(.default, value: showView2) // Animate when showView2 changes
    }
}

struct View2: View {
    @Binding var isPresented: Bool
    @State private var showButtons = false // State for animating buttons

    var body: some View {
        ZStack {
            // Transparent background overlay to dim View1 slightly
            Color.black.opacity(showButtons ? 0.4 : 0)
                .ignoresSafeArea() // Ensures overlay covers entire screen
                .onTapGesture {
                    withAnimation {
                        showButtons = false // Hide button container with animation
                    }
                    // Delay dismissal of View2 until after the animation
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        isPresented = false
                    }
                }
            
            if isPresented {
                VStack {
                    Spacer() // Push content to the bottom

                    // Button container with smooth appearance animation
                    VStack(spacing: 20) {
                        Button("Button 1") {
                            // Handle button 1 action
                        }
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(8)
                        
                        Button("Button 2") {
                            // Handle button 2 action
                        }
                        .font(.headline)
                        .padding()
                        .padding(.bottom, 20) // Add bottom padding to Button 2
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(8)
                    }
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 10)
                    .opacity(showButtons ? 1 : 0) // Opacity transition for smooth appearance
                    .offset(y: showButtons ? 0 : 300) // Slide-in effect
                    .animation(.easeInOut(duration: 0.3), value: showButtons)
                    .onAppear {
                        showButtons = true // Trigger animation on appear
                    }
                }
                .ignoresSafeArea(.all, edges: .bottom) // Ensures container aligns with screen bottom
            }
        }
    }
}
