@isTest
public class Mock implements System.StubProvider {
  private Map<String, MethodSpy> spies = new Map<String, MethodSpy>();

  public Mock() {
  }

  public Object handleMethodCall(
    Object stubbedObject,
    String stubbedMethodName,
    Type returnType,
    List<Type> listOfParamTypes,
    List<String> listOfParamNames,
    List<Object> listOfArgs
  ) {
    MethodSpy spy = this.getSpy(stubbedMethodName);
    return spy.call(listOfArgs);
  }

  public MethodSpy getSpy(final String methodName) {
    if (!this.spies.containsKey(methodName)) {
      this.spies.put(methodName, new MethodSpy(methodName));
    }
    return this.spies.get(methodName);
  }
}
