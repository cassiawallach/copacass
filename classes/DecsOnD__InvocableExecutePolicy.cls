/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class InvocableExecutePolicy {
    global InvocableExecutePolicy() {

    }
    @InvocableMethod(label='Decisions on Demand: Invoke Policy' description='Invoke a Decisions on Demand Business Policy on the specified object')
    global static List<DecsOnD.InvocableExecutePolicy.OutputParameter> execute(List<DecsOnD.InvocableExecutePolicy.InputParameter> inputParams) {
        return null;
    }
global class InputParameter {
    @InvocableVariable(label='Create Execution Record' description='Indicate whether the execution record should be created. It can be Yes (default), No or OnFailure.' required=false)
    global String createExecutionRecord;
    @InvocableVariable(label='sObject ID' required=true)
    global Id objectId;
    @InvocableVariable(label='Policy Name' required=true)
    global String policyName;
    global InputParameter() {

    }
}
global class OutputParameter {
    @InvocableVariable(label='Error Message' required=false)
    global String errorMessage;
    @InvocableVariable(label='Result Status' required=false)
    global String resultStatus;
}
}
