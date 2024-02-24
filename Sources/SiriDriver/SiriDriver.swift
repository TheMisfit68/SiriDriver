import Cocoa
import AVFoundation

// REMARK!!!
// Don't make this class a subclass of AVSpeechSynthesizer (instead of just using it in a composition)
// it would cause the synthesizer to work only once!

@available(OSX 10.14, *)
public class SiriDriver{
    
    var syntheSizer:AVSpeechSynthesizer!
    let voice:AVSpeechSynthesisVoice = AVSpeechSynthesisVoice(language: AVSpeechSynthesisVoice.currentLanguageCode())!
    let rate:Float
    
    public init(speedAsPercentage:Float = 50.0){
               
        let rateAsPercentage = min(max(speedAsPercentage, 0.0), 100.0) // Limit between 0 and 100
        self.rate = (AVSpeechUtteranceMaximumSpeechRate-AVSpeechUtteranceMinimumSpeechRate)*(rateAsPercentage/100.0)
        
    }
    
    public func speak(text: String){
        
        let textToSpeak = AVSpeechUtterance(string: text)
        textToSpeak.voice = self.voice
        textToSpeak.rate = self.rate
        
        syntheSizer = AVSpeechSynthesizer()
        syntheSizer.pauseSpeaking(at: .word)
        syntheSizer.speak(textToSpeak)
    }
    
}
