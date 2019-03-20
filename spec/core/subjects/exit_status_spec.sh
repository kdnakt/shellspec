#shellcheck shell=sh

Describe "core/subjects/exit_status.sh"
  Before set_exit_status intercept_shellspec_subject
  exit_status() { false; }

  Describe "exit status subject"
    Example 'example'
      func() { return 12; }
      When call func
      The exit status should equal 12
      The status should equal 12 # alias for exit status
    End

    Context 'when exit status is 123'
      exit_status() { shellspec_puts 123; }
      Example 'should equal 123'
        When invoke shellspec_subject status _modifier_
        The stdout should equal 123
      End
    End

    Context 'when exit status is undefind'
      exit_status() { false; }
      Example 'should be failure'
        When invoke shellspec_subject status _modifier_
        The status should be failure
      End
    End

    Example 'outputs error if next word is missing'
      When invoke shellspec_subject status
      The stderr should equal SYNTAX_ERROR_DISPATCH_FAILED
    End
  End
End
