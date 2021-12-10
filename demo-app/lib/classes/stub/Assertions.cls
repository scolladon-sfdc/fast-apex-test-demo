@IsTest
public class Assertions {
  // TODO handle multiple calls of the same method spy
  public interface ParametersMatcher {
    void assertMatches(List<Object> actualParams);
  }

  public class StubAssert {
    private Stub stub;

    private StubAssert(Stub stub) {
      this.stub = stub;
    }

    public MethodSpyAssert method(final String methodName) {
      final MethodSpy aSPy = this.stub.getSpy(methodName);
      if (aSPy == null) {
        System.assert(false, 'No spy declared for method ' + methodName);
      }
      return new MethodSpyAssert(aSPy);
    }
  }

  public class MethodSpyAssert {
    private MethodSpy spy;

    private MethodSpyAssert(MethodSpy spy) {
      this.spy = spy;
    }

    public void hasNotBeenCalled() {
      System.assertEquals(
        false,
        spy.hasBeenCalled(),
        'Method ' +
        spy.methodName +
        ' was called'
      );
    }

    public void hasBeenCalled() {
      System.assertEquals(
        true,
        spy.hasBeenCalled(),
        'Method ' +
        spy.methodName +
        ' was not called'
      );
    }

    public void hasBeenCalledWith(Object params) {
      this.hasBeenCalledWith(new List<Object>{ params });
    }

    public void hasBeenCalledWith(ParametersMatcher matcher) {
      System.assertNotEquals(
        null,
        spy.getLastCallParams(),
        'Method ' +
        spy.methodName +
        ' was not called'
      );
      matcher.assertMatches(spy.getLastCallParams());
    }

    public void hasBeenCalledWith(List<Object> params) {
      System.assertNotEquals(
        null,
        spy.getLastCallParams(),
        'Method ' +
        spy.methodName +
        ' was not called'
      );
      System.assertEquals(params, spy.getLastCallParams());
    }
  }

  public class SObjectAssert {
    private SObject value;

    private SObjectAssert(SObject value) {
      this.value = value;
    }

    public void is(SObject otherValue) {
      if (otherValue == null) {
        System.assertEquals(null, value);
        return;
      }
      System.assertEquals(
        otherValue.getSObjectType(),
        value.getSObjectType(),
        'sobjects should have the same type'
      );
      System.assertEquals(
        otherValue.getPopulatedFieldsAsMap(),
        value.getPopulatedFieldsAsMap(),
        'sobjects should have same field values'
      );
    }
  }

  public static SObjectAssert assertThat(SObject value) {
    return new SObjectAssert(value);
  }

  public static MethodSpyAssert assertThat(MethodSpy spy) {
    return new MethodSpyAssert(spy);
  }

  public static StubAssert assertThat(Stub stub) {
    return new StubAssert(stub);
  }
}
