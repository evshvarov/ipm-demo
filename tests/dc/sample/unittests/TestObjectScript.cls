Class shvarov.sample.unittests.TestObjectScript Extends %UnitTest.TestCase
{

Method Test42()
{
	Set tExpected=42
    set tResults= ##class(shvarov.sample.ObjectScript).Test()
	Do $$$AssertEquals(tResults,tExpected,tExpected_" = "_tResults)
}

}
