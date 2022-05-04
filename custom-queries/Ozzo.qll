import go

module Ozzo {
  string packagePath() { result = package("github.com/go-ozzo/ozzo-validation/v4", "") }

  class GoOzzoValidateCall extends CallExpr {
    GoOzzoValidateCall() { this.getTarget().hasQualifiedName(packagePath(), ["Validate"]) }
  }

  class GoOzzoValidateStructCall extends CallExpr {
    GoOzzoValidateStructCall() {
      this.getTarget().hasQualifiedName(packagePath(), "ValidateStruct")
    }

    CallExpr getFieldCall() {
      this.getAnArgument() = result and
      result.getCalleeName() = "Field"
    }
  }

  class GoOzzoValidationRules extends CallExpr {
    GoOzzoValidationRules() {
      this.getCalleeName() in [
          "Length", "Match", "RuneLength", "Min", "Max", "Date", "NotNil", "NilOrNotEmpty", "Nil",
          "Empty", "Skip", "MultipleOf"
        ]
    }
  }
}
