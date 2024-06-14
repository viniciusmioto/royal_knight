Feature: Testing Fruit Spawner


    @easy
    Scenario Outline: Testing spawn positions of the Fruit
        Given first fruit at (<i>, <j>)
        When knight moves
        Then knight should have collected <k> fruit

        Examples:
        |  i  |  j  | k |
        |  53 |  48 | 1 |
        | -10 |  28 | 1 |
        | -90 |  6  | 1 |
        |  12 |  37 | 1 |
        |  70 |  30 | 1 |

    
    @manual
    Scenario: Testing spawn positions of the Fruit manually
        Given first fruit at (53, 48)
        When knight moves
        Then knight should have collected 1 fruit