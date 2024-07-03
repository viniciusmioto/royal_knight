from xumes import config, given, when, then
from tests.fruit_spawn.features.steps.catch_fruits import CatchFruits


@config
def config(context):
    context.driver.set_scene("res://tests/fruit_spawn/fruit_spawn_test.tscn")


@given("first fruit at {i:d} {j:d}")
def step_impl(context, i, j):
    context.driver.set_fruit_position(i, j)


@when("knight moves")
def step_impl(context):
    return CatchFruits()


@then("knight should have collected {k:d} fruit")
def step_impl(context, k):
    context.assert_true(context.score >= k)
