#shellcheck shell=sh

Describe "core/matchers/eq.sh"
  Before set_subject intercept_shellspec_matcher
  subject() { false; }

  Describe 'equal matcher'
    Example 'example'
      The value "test" should equal "test"
      The value "test" should eq "test" # alias for equal
      The value "test" should not equal "TEST"
      The value "test" should not eq "TEST" # alias for equal
    End

    Context 'when subject is "foo bar"'
      subject() { shellspec_puts "foo bar"; }

      Example 'should equal "foo bar"'
        When invoke shellspec_matcher equal "foo bar"
        The status should be success
      End

      Example 'should not equal "foo"'
        When invoke shellspec_matcher equal "foo"
        The status should be failure
      End
    End

    Context 'when subject is undefined'
      subject() { false; }
      Example 'should not equal ""'
        When invoke shellspec_matcher equal ""
        The status should be failure
      End
    End

    Example 'outputs error if parameters is missing'
      When invoke shellspec_matcher equal
      The stderr should equal SYNTAX_ERROR_WRONG_PARAMETER_COUNT
      The status should be failure
    End

    Example 'outputs error if parameters count is invalid'
      When invoke shellspec_matcher equal "foo" "bar"
      The stderr should equal SYNTAX_ERROR_WRONG_PARAMETER_COUNT
      The status should be failure
    End
  End
End
