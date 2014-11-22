mockito-flex
============
![Logo](https://bitbucket.org/loomis/mockito-flex/wiki/logo.jpg)

## News
__18/11/2014__ - Version 1.4M7 available via maven repository. Please use [sample project](https://bitbucket.org/loomis/mockito-flex/downloads/mockito-flex-maven-sample.zip) as a reference. Also check [wiki](Maven Setup) for the details.

__30/09/2010__ - Latest milestone [1.4.M4](http://bitbucket.org/loomis/mockito-flex/downloads/mockito-1.4M4.zip) has decreased size - no longer linking with unit testing libraries. Also fixes calling arguments as functions for stubs.

__27/08/2010__ - New [1.4 milestone available](https://bitbucket.org/loomis/mockito-flex/downloads/mockito-1.4M3.zip) - provides two enhancements:

* Access to the MockInterceptor on a Mockito class - some users want to have some custom verification
on the invocations made on mock. MockInterceptor provides access to the Invocations collection that holds all invocations made on given mock. 

* Added access to the stub arguments with fluent api. Examples:

```as3
// stubbing function call of a function
function someService(token:AsyncToken, resultFunction:Function, failureFunction:Function):void {...}

given(service.someService(any(), any(), any()))
              .will(useArgument(1).asFunctionAndCall(new ResultObject()));

// stubbing function call of a function
function someService(token:AsyncToken, responder:IResponder):void {...}

given(service.someService(any(), any()))
              .will(useArgument(1).method("result").callWithArgs(new ResultEvent(...)));
```

__10/08/2010__ - New 1.4 milestone available - flexunit 4 updated to 4.1-beta3.26

__10/08/2010__ - RC5 made a [final 1.3 release](http://bitbucket.org/loomis/mockito-flex/downloads/mockito-1.3.zip).

__24/06/2010__ - Released [RC5 of Mockito 1.3](http://bitbucket.org/loomis/mockito-flex/downloads/mockito-1.3-RC5.zip). It allows using FlexUnit4 rules instead of the runner for the mock preparation and assignment.

__03/03/2010__ - Released [RC3 of Mockito 1.3](http://bitbucket.org/loomis/mockito-flex/downloads/mockito-1.3-RC3.zip). Recompiled and updated to the latest [flexunit4](http://www.digitalprimates.net/downloadit/FlexUnit4TurnkeyRC_1.0.zip).

__03/02/2010__ - Released [RC2 of Mockito 1.3](http://bitbucket.org/loomis/mockito-flex/downloads/mockito-1.3-RC2.zip). It allows adding [Mock] metadata on the class level and smart type guessing from a field when autocreating mocks. More details [here](releases/Release1.3).

__02/02/2010__ - Released [RC1 of Mockito 1.3](http://bitbucket.org/loomis/mockito-flex/downloads/mockito-1.3-RC1.zip). It comes with flex unit 4 integration and [more](releases/Release1.3).

A sample test with FlexUnit4:

```as3
import com.acme.TestClass;
import org.mockito.integrations.verify;

[RunWith("org.mockito.integrations.flexunit4.MockitoClassRunner")]
public class MockingWithFlexUnit4
{
    [Mock(type="com.acme.TestClass")]
    public var mockie:TestClass;

    public function MockingWithFlexUnit4()
    {
    }

    [Test]
    public function shouldVerifyMockInvocation():void
    {
        // when
        mockie.argumentless();
        // then
        verify().that(mockie.argumentless());
    }
}
```

For more details please refer [release notes](releases/Release1.3).

__01/10/2009__ - A [new milestone](http://bitbucket.org/loomis/mockito-flex/downloads/mockito-1.2-M1.2.3.zip) available for download. It adds ordered verification.

__30/08/2009__ - A good starter by Shanon [click here](http://www.compactcode.com/index.php/2009/08/unit-testing-flex-mocking/). Thanks for writing it!

__12/08/2009__ - [Mockito 1.1](http://bitbucket.org/loomis/mockito-flex/downloads/mockito-all-1.1-final.zip) released.  Please read [release notes.](releases/Release1.1)

__02/08/2009__ - [Release Candidate 1](http://bitbucket.org/loomis/mockito-flex/downloads/mockito-all-1.1-rc1.zip) is out.  Feedback is welcome. Read [release notes.(releases/Release1.1)

__31/07/2009__ - Integration test case for asunit is [out there](http://blog.hoardinghopes.com/index.php/2009/07/mockito-flex-meets-asunit/)! Thanks James!

__23/07/2009__ - [Mockito 1.01](http://bitbucket.org/loomis/mockito-flex/downloads/mockito-all-1.01.zip) released. Read [release notes](releases/Release1.01).

__09/07/2009__ - Added wiki with basic [tutorial](tutorials/Tutorial1.0)

__08/07/2009__ - Added some asdocs and basic tutorial. Check out the sources.

__08/07/2009__ - Started official [mockito mailing list](http://groups.google.com/group/mockito-flex).

__07/07/2009__ - InfoQ mentions mockito-flex in it's [article](http://www.infoq.com/news/2009/07/mockito-java-flex).

__24/06/2009__ - Mockito 1.0 released. Read [release notes](releases/Release1.0).

### Milestones

__M1.2.3__ - Adds ordered verification:

```as3
inOrder().verify().that(someone.firstFunction());
inOrder().verify().that(someone.secondFunction());
``` 

Please note that you should not pass additional verifiers like times(n) to a verify function. If you do this the behavior is not well defined. I may need to change the API a little bit but for now just please don't use it.

__M1.2.2__ - Upgraded asmock to version 0.9

__M1.2.1__ - Adds support for calling original function for stubs:

```as3
given(someone.something(any())).will(callOriginal());
```

### Story

Mockito for Flex has been created during the __Hack Day__ session in __//Sabre Airline Solutions//__ in just two days. The main idea was to introduce a better and simpler testing for Flex to use with the __//Sabre CSS project//__.
We made hacks on asmock framework and gave it a new face.

More details on motivations behind mockito can be found on [Mockito for java](http://code.google.com/p/mockito/) site.

Many thanks go to __David Endicott__ for letting us publish the results of the Hack Day under open source. 

We would like to thank also __Richard Szalay__, [Asmock](http://asmock.sourceforge.net/) author, for his excellent work.

### How to drink it?

Please download the latest version from the [download section](http://bitbucket.org/loomis/mockito-flex/downloads/), put the libraries in your lib folder.

If you are using flex unit for your unit tests, you can extend a MockitoTestCase and start writing your tests. For other unit testing frameworks please check the [integrations](tutorials/Integrations) wiki.

After that you can start verifying interactions:

```as3
package com.acme
{
    import mx.collections.ArrayCollection;
    
    import org.mockito.MockitoTestCase;

    public class TestArray extends MockitoTestCase
    {
        public function TestArray()
        {
            // you need to specify classes to mock here
            super([Array, ArrayCollection]);
        }
        
        public function testShouldDemoVerificationAPI():void
        {
            // mock creation
            var array:Array = mock(Array) as Array;
            // using mock object - let's pretend the following two lines are part of our SUT 
            array.push("1");
            array.pop();
            // unlike a record-playback frameworks, mockito doesn't throw any "unexpected interaction" exception
             
            // selective & explicit verification
            // later you can verify ONLY what you are interested in
            verify().that(array.push("1"));
            verify().that(array.pop());
        }
        
        public function testShouldDemoStubbingAPI():void
        {
            var list:ArrayCollection = ArrayCollection(mock(ArrayCollection, "collection", [[]]));
            // stubbing - before execution
            given(list.getItemAt(1)).willReturn("A");
            
            // let's pretend the following is executed within SUT:
            // this call returns 'A' because it was stubbed
            assertEquals("A", list.getItemAt(1));

            // this call returns null because list.getItemAt(2) was not stubbed
            assertNull(list.getItemAt(2));
        }
    }
}
```

### Documentation and examples

To get familiar with the framework please take a look at the [tutorial](tutorials/Tutorial1.0). There is asdoc available as well in the [downloads](http://bitbucket.org/loomis/mockito-flex/downloads/) section. 

Also please check the [additions and contributions](Additions) that are not part of the framework yet but you may find them interesting.

Integrations with different unit testing frameworks are described [here](tutorials/Integrations). 

A good starter also can be found [here](http://www.compactcode.com/index.php/2009/08/unit-testing-flex-mocking/)

If you want to use maven please refer to [[Maven Setup|Maven Setup]].
### Releases

[Release history](https://github.com/haysclark/mockito-flex/releases)

### Who is the bartender?

This time flex mockito flavour is served to you by Kris Karczmarczyk and Szczepan Faber. But credits also go to all other contibutors of the mockito for java as we used and tried some of the new concepts.

### How much is it?

[License](https://bitbucket.org/loomis/mockito-flex/wiki/License)
