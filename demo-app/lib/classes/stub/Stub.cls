@isTest
public with sharing class Stub {
  public Object instance { get; private set; }
  private Mock mock;
  private Map<String, MethodSpy> spies = new Map<String, MethodSpy>();

  private Stub(final Type aType) {
    this.mock = new Mock();
    this.instance = Test.createStub(aType, this.mock);
  }

  public MethodSpy spyOn(final String methodName) {
    this.spies.put(methodName, this.mock.spyOn(methodName));

    return this.spies.get(methodName);
  }

  public MethodSpy getSpy(final String methodName) {
    return this.spies.get(methodName);
  }

  public static Stub forType(final Type aType) {
    return new Stub(aType);
  }
}
