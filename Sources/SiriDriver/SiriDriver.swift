import Cocoa
import AVFoundation

// MARK: - ⚠️ REMARK!!!
// Don't make this class a subclass of AVSpeechSynthesizer (instead just use it in a composition)
// it would cause the synthesizer to work only once!

/// A Text-to-speach class that can make your program sound like Siri

@available(OSX 10.14, *)
public class SiriDriver{
    
    var syntheSizer:AVSpeechSynthesizer!
    let voice:AVSpeechSynthesisVoice = AVSpeechSynthesisVoice(language: AVSpeechSynthesisVoice.currentLanguageCode())!
    let rate:Float
    
    public init(speedAsPercentage:Float = 50.0){
               
        let rateAsPercentage = min(max(speedAsPercentage, 0.0), 100.0) // Limit between 0 and 100
        self.rate = (AVSpeechUtteranceMaximumSpeechRate-AVSpeechUtteranceMinimumSpeechRate)*(rateAsPercentage/100.0)
        
    }
	
	/// Them main method of this class, it will speak the given text
	/// - Parameter text: Tekt to be spoken
    public func speak(text: String){
        
        let textToSpeak = AVSpeechUtterance(string: text)
        textToSpeak.voice = self.voice
        textToSpeak.rate = self.rate
        
        syntheSizer = AVSpeechSynthesizer()
        syntheSizer.pauseSpeaking(at: .word)
        syntheSizer.speak(textToSpeak)
    }
    
}
