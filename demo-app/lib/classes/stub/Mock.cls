@isTest
public class Mock implements System.StubProvider {
  public Object stub { get; private set; }
  private Map<String, MethodSpy> spies = new Map<String, MethodSpy>();

  private Mock() {
  }

  private Mock(final Type aType) {
    this.stub = Test.createStub(aType, this);
  }

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
      MethodSpy spy = this.spies.get(stubbedMethodName);
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

  public MethodSpy getSpy(final String methodName) {
    return this.spies.get(methodName);
  }

  public static Mock forType(final Type aType) {
    return new Mock(aType);
  }
}
