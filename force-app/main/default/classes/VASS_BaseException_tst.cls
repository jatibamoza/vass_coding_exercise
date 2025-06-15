@isTest
private class VASS_BaseException_tst {
    @isTest
    static void test_exception_instantiation_and_throwing() {
        Boolean exceptionThrown = false;
        try{
            throw new VASS_BaseException('Test exception message');
        }catch (VASS_BaseException ex) {
            exceptionThrown = true;
            Assert.areEqual('Test exception message', ex.getMessage(), 'The exception message should match the one provided during instantiation');
        }
        Assert.areEqual(true, exceptionThrown, 'VASS_BaseException should have been thrown and caught');
    }
}