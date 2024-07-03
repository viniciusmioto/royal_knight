# royal_knight

    @manual
    Scenario: Testing spawn positions of the Fruit manually
        Given first fruit at 53 48
        When knight moves
        Then knight should have collected 1 fruit