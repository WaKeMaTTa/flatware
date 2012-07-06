Feature: Output
  In order to easily understand results
  I want familiar cucumber output

  Scenario: success
    Given a cucumber suite with two features that each sleep for 1 second
    When I run flatware
    Then the output contains the following:
    """
    ..

    2 scenarios (2 passed)
    2 steps (2 passed)
    """

  Scenario: failure
    Given the following scenario:
    """
    Scenario: failure output
      Given flunk
    """
    When I run flatware
    Then the output contains a backtrace

  Scenario: outlines
    Given the following scenario:
    """
    Scenario Outline: old McDonnald
      Given <animal>
      When on his farm there was a <animal>
      Then there was a <sound> <sound> here and a <sound> <sound> there

    Scenarios:
      | animal | sound |
      | cow    | moo   |
      | flunk  | boom  |
    """
    When I run flatware
    Then the output contains the following:
    """
    ---UUUU
    """
    And the output contains the following:
    """
    2 scenarios (1 failed, 1 undefined)
    6 steps (1 failed, 5 undefined)
    """