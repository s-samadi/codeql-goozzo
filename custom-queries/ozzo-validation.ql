/**
 * @name Missing validation
 * @description Having only one validation check may be indicative of missing sanitization.
 * @id go/missing-validation
 * @kind problem
 * @problem.severity recommendation
 * @precision medium
 * @tags security
 */

import go
import Ozzo::Ozzo

int getValidationRulesCount(CallExpr fieldCall) {
  if fieldCall.getAnArgument*().toString().matches("%Required%")
  then
    result =
      count(GoOzzoValidationRules validationRules | fieldCall.getAnArgument*() = validationRules) +
        1
  else
    result =
      count(GoOzzoValidationRules validationRules | fieldCall.getAnArgument*() = validationRules)
}

from GoOzzoValidateStructCall validateCall, CallExpr fieldCall, int i
where
  validateCall.getFieldCall() = fieldCall and
  i = getValidationRulesCount(fieldCall) and
  i < 2
  or
  fieldCall instanceof GoOzzoValidateCall and i = getValidationRulesCount(fieldCall) and i < 2
select fieldCall, "Insuffient validation checking - no. of attributes checked : " + i
