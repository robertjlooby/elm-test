module ElmTest.Assertion where

{-| The basic component of a test case, an assertion.

# Assert
@docs assertT, assert, assertEqual, assertNotEqual

-}

import List

type Assertion = AssertTrue     (() -> Bool)
               | AssertFalse    (() -> Bool)
               | AssertEqual    (() -> Bool) (() -> String) (() -> String)
               | AssertNotEqual (() -> Bool) (() -> String) (() -> String)

{-| Basic function to create an Assert True assertion. Delays execution until tests are run. -}
assert : (() -> Bool) -> Assertion
assert = AssertTrue

{-| Basic function to create an Assert Equals assertion, the expected value goes on the left. -}
assertEqual : (() -> a) -> (() -> a) -> Assertion
assertEqual a b = AssertEqual (\_ -> a () == b ()) (\_ -> toString <| a ()) (\_ -> toString <| b ())

{-| Given a list of values and another list of expected values,
generate a list of Assert Equal assertions. -}
assertionList : List (() -> a) -> List (() -> a) -> List Assertion
assertionList xs ys = List.map2 assertEqual xs ys

{-| Basic function to create an Assert Not Equals assertion. -}
assertNotEqual : (() -> a) -> (() -> a) -> Assertion
assertNotEqual a b = AssertNotEqual (\_ -> a () /= b ()) (\_ -> toString <| a ()) (\_ -> toString <| b ())
