import numpy as np
import stable_baselines3
from gymnasium import spaces
from xumes import Agent, GodotAction


class CatchFruits(Agent):

    def __init__(self):
        super().__init__(
            observation_space=spaces.Dict(
                {
                    "x_dist": spaces.Box(
                        -float("inf"), float("inf"), shape=(1,), dtype=float
                    ),
                    "y_dist": spaces.Box(
                        -float("inf"), float("inf"), shape=(1,), dtype=float
                    ),
                }
            ),
            action_space=spaces.Discrete(3),
            max_episode_length=1000,
            total_timesteps=int(3_000_000),
            algorithm_type="MultiInputPolicy",
            algorithm=stable_baselines3.PPO,
            save_path="./tests/fruit_spawn/models/",
            eval_freq=10000,
        )


    def observation(self):
        return {
            "x_dist": np.array([self.context.x_dist], dtype=np.float32),
            "y_dist": np.array([self.context.y_dist], dtype=np.float32),
        }

    def reward(self):
        if self.context.score >= 1:
            return 1

        if self.context.dead:
            return -1

        return 0

    def terminated(self):
        terminated = self.context.dead != 0 or self.context.score >= 1
        if terminated:
            print(f"terminated. score: {self.context.score} dead: {self.context.dead}")
        return terminated

    def actions(self, raw_action):
        actions = []
        if raw_action == 0:
            actions.append({"type": "ACTION_EVENT", "action_name": "jump"})
        elif raw_action == 1:
            actions.append({"type": "ACTION_EVENT", "action_name": "move_left"})
        elif raw_action == 2:
            actions.append({"type": "ACTION_EVENT", "action_name": "move_right"})

        return actions

    def reset(self):
        return GodotAction("reset")