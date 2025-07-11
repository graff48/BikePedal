
import SwiftUI

struct AppIconView: View {
    var body: some View {
        ZStack {
            Color(red: 0.0, green: 0.6, blue: 0.2) // Forest Green
            Image(systemName: "bicycle")
                .font(.system(size: 400, weight: .bold))
                .foregroundColor(.white)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct AppIconView_Previews: PreviewProvider {
    static var previews: some View {
        AppIconView()
    }
}
