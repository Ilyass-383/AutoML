# Test jouet du bandit avant intégration
import random, math

class UCB1Bandit:
    def __init__(self, n_arms):
        self.n = n_arms
        self.counts = [0] * n_arms    # nb fois chaque bras tiré
        self.values = [0.0] * n_arms  # reward moyen de chaque bras
        self.total = 0

    def select(self) -> int:
        # Phase d'initialisation : essaye chaque bras une fois
        for i in range(self.n):
            if self.counts[i] == 0:
                return i
        # UCB1 : score + bonus d'exploration
        ucb = [self.values[i] +
               math.sqrt(2 * math.log(self.total) / self.counts[i])
               for i in range(self.n)]
        return ucb.index(max(ucb))

    def update(self, arm: int, reward: float):
        self.total += 1
        self.counts[arm] += 1
        # Moyenne mobile incrémentale
        n = self.counts[arm]
        self.values[arm] += (reward - self.values[arm]) / n