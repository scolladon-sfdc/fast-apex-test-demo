/**
 * MethodSpy represents an apex method spy on which you can register some value to be returned
 *
 *  - always return the same value using spy.returns(value)
 *  - return value based on calling arguments list
 *        spy.whenCalledWith(param).thenReturn(value)
 *        spy.whenCalledWith(new List<Object>{param1, param2}).thenReturn(value)
 *    note: the matching algorithm is currently based on equality (equals method or reference comparison)
 *
 */
@IsTest
public class MethodSpy {
  // TODO add number of time it has been called
  public String methodName;
  private Boolean hasBeenCalled = false;
  private List<Object> lastCallParams;
  private List<ParameterizedMethodSpyCall> parameterizedMethodCalls = new List<ParameterizedMethodSpyCall>();
  private Object returnValue;
  private Exception exceptionToThrow;

  public MethodSpy(String methodName) {
    this.methodName = methodName;
  }

  public List<Object> getLastCallParams() {
    return this.lastCallParams;
  }

  public Boolean hasBeenCalled() {
    return this.hasBeenCalled;
  }

  public Object call() {
    return this.call(new List<Object>());
  }

  public Object call(Object param) {
    return this.call(new List<Object>{ param });
  }

  public Object call(List<Object> params) {
    this.hasBeenCalled = true;
    this.lastCallParams = params;
    if (this.exceptionToThrow != null) {
      throw this.exceptionToThrow;
    }
    if (this.parameterizedMethodCalls.size() == 0) {
      return this.returnValue;
    }

    for (
      ParameterizedMethodSpyCall parameterizedCall : this.parameterizedMethodCalls
    ) {
      if (parameterizedCall.matches(params)) {
        return parameterizedCall.value;
      }
    }

    throw new IllegalArgumentException(
      this.methodName +
      ': No stub value found for a call with params ' +
      params
    );
  }

  public void returns(Object value) {
    this.returnValue = value;
  }

  public void throwsException(Exception exceptionToThrow) {
    this.exceptionToThrow = exceptionToThrow;
  }

  public ParameterizedMethodSpyCall whenCalledWith(Object param) {
    return whenCalledWith(new List<Object>{ param });
  }

  public ParameterizedMethodSpyCall whenCalledWith(List<Object> params) {
    final ParameterizedMethodSpyCall parameterizedMethodCall = new ParameterizedMethodSpyCall(
      params
    );
    this.parameterizedMethodCalls.add(parameterizedMethodCall);
    return parameterizedMethodCall;
  }
}
