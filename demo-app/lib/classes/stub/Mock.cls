@isTest
public class Mock implements System.StubProvider {
  private Map<String, MethodSpy> spies = new Map<String, MethodSpy>();

  public Object handleMethodCall(
    Object stubbedObject,
    String stubbedMethodName,
    Type returnType,
    List<Type> listOfParamTypes,
    List<String> listOfParamNames,
    List<Object> listOfArgs
  ) {
    // TODO: handle method overloads
    Object result;
    if (this.spies.containsKey(stubbedMethodName)) {
      MethodSpy spy = this.spyOn(stubbedMethodName);
      result = spy.call(listOfArgs);
    }

    return result;
  }

  public MethodSpy spyOn(final String methodName) {
    if (!this.spies.containsKey(methodName)) {
      this.spies.put(methodName, new MethodSpy(methodName));
    }
    return this.spies.get(methodName);
  }
}
