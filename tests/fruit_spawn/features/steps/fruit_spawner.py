import numpy as np
import stable_baselines3
from gymnasium.vector.utils import spaces

from xumes import Agent, given, when, then, config


@config
def config(context):
    context.driver.set_scene("res://tests/fruit_spawn/fruit_spawn_test.tscn")


@given("first fruit at ({i:d}, {j:d})")
def step_impl(context, i,j):
    context.driver.set_pipes_position(i, j)


@when("knight moves")
def step_impl(context):
    return CatchFruits()


@then("knight should have collected {i:d} fruits")
def step_impl(context, i):
    context.assert_true(context.score >= i)


class CatchFruits(Agent):

    def __init__(self):
        super().__init__(
            observation_space=spaces.Dict({
                "fruit_X": spaces.Box(-int('inf'), int('inf'), shape=(1,), dtype=int),
                "fruit_Y": spaces.Box(-int('inf'), int('inf'), shape=(1,), dtype=int),
            }),
            action_space=spaces.Discrete(4),
            max_episode_length=1000,
            total_timesteps=int(3_000_000),
            algorithm_type="MultiInputPolicy",
            algorithm=stable_baselines3.PPO,
            save_path="./models/knight",
            eval_freq=10000,
            )

        self.points = 0

    def observation(self):
        return {"fruit_X": np.array(self.fruit_X), "fruit_Y": np.array(self.fruit_Y)}

    def reward(self):
        if self.score > self.points:
            self.points = self.score
            return 1

        if self.dead:
            return -1
        return 0

    def terminated(self):
        terminated = self.dead != 0 or self.score >= 2 or self.Game.Bird.position[1] < 0
        if terminated:
            self.points = 0
        return terminated

    def actions(self, raw_actions):
        direction, jump = raw_actions
        actions = []
        if direction == 0:
            actions.append({"type": "ACTION_EVENT", "action_name": "move_left"})
        elif direction == 1:
            actions.append({"type": "ACTION_EVENT", "action_name": "move_right"})
        if jump == 1:
            actions.append({"type": "ACTION_EVENT", "action_name": "jump"})
        return actions
