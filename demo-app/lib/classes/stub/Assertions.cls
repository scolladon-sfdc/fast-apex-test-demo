@NamespaceAccessible
@IsTest
public class Assertions {
  @NamespaceAccessible
  public interface ParametersMatcher {
    void assertMatches(List<Object> actualParams);
  }

  @NamespaceAccessible
  public class MethodSpyAssert {
    private MethodSpy spy;

    private MethodSpyAssert(MethodSpy spy) {
      this.spy = spy;
    }

    @NamespaceAccessible
    public void hasNotBeenCalled() {
      System.assertEquals(
        false,
        spy.hasBeenCalled(),
        'Method ' +
        spy.methodName +
        ' was called'
      );
    }

    @NamespaceAccessible
    public void hasBeenCalled() {
      System.assertEquals(
        true,
        spy.hasBeenCalled(),
        'Method ' +
        spy.methodName +
        ' was not called'
      );
    }

    @NamespaceAccessible
    public void hasBeenCalledWith(Object params) {
      this.hasBeenCalledWith(new List<Object>{ params });
    }

    @NamespaceAccessible
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

    @NamespaceAccessible
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

  @NamespaceAccessible
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

  @NamespaceAccessible
  public static SObjectAssert assertThat(SObject value) {
    return new SObjectAssert(value);
  }

  @NamespaceAccessible
  public static MethodSpyAssert assertThat(MethodSpy spy) {
    return new MethodSpyAssert(spy);
  }
}
