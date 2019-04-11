import Foundation
import STT

class ValidatorFieldData {
    
    let rawValue = Dynamic<String?>("")
    let errorValue = Dynamic<String>("")
    let rawValidator: SttValidatorType
    
    init (rawValidator: SttValidatorType) {
        self.rawValidator = rawValidator
    }
    
    func raiseError(_ object: String?) {
        rawValidator.validate(object: object)
        errorValue.value = rawValidator.validationError
    }
}
