# Godot Q-Learning

## Descriptions
Godot Q-Learning is a implemetation of a Q-Table for problems of Reinforcement Learning. It is based on the tutorial series ![https://simoninithomas.github.io/Deep_reinforcement_learning_Course/](https://simoninithomas.github.io/Deep_reinforcement_learning_Course/)

## Using the example
You can see the example using Q-Learnign to solve a maze created on `"Scenes/Game.tscn"` and `"Scenes/QFVisualizer.tscn"` to understand how to solve a simple maze problem.

## Docs
### Signals:  
* newEpisode\(\)  
  
    ```
    Executed when a new episode starts
    ```

* executeStep\(action, arrayToUpdate\)  
  
    ```
    Executed when a new step is requested to be executed
    Requires to update the array passed as reference like [newState, reward, done]
    ```

  
### Functions:  
* initQTable(startValue: int) -> void  
  
    ```
    Init a Q-Table
    ```

* initQLearning() -> void  
  
    ```
    Init Q-Learning algorithm
    ```

* qFunctionValue(state, action, newState, reward) -> int  
  
    ```
    Get the value of the new Q(s, a)
    ```

* nextEpisode() -> void  
  
    ```
    Run the next episode
    ```

* runAllEpisodes() -> void  
  
    ```
    Run all episodes
    ```

  
### Variables:  
* actionsN: int = `4`  
  
    ```
    Q-Table Configuration
    Number of actions
    Actions: up, down, left and right
    ```

* statesN: int = `256`  
  
    ```
    Number of states
    Maze of 16 x 16
    ```

* seedToUse: int = `2`  
  
    ```
    Hyperpamater intialization
    Seed to be used on the random number generation, if set to false the seed will be randomized
    ```

* totalEpisodes: int = `100`  
  
    ```
    Number of episoded to generate
    ```

* learningRate: float = `0.8`  
  
    ```
    Learning rate
    ```

* maxSteps: int = `256 \* 5`  
  
    ```
    Max steps per episode
    ```

* gamma: float = `0.95`  
  
    ```
    Discounting rate
    ```

* epsilon: float = `1.0`  
  
    ```
    Exploration parameters
    Exploration rate
    ```

* maxEpsilon: float = `1.0`  
  
    ```
    Exploration probability at start
    ```

* minEpsilon: float = `0.01`  
  
    ```
    Minimum exploration probability
    ```

* decayRate: float = `0.001`  
  
    ```
    Exponential decay rate for exploration pro
    ```

* rewards: Array = `[]`  
  
    ```
    Acumulated rewards
    ```

* qTable: Array = `[]`  
  
    ```
    The generated q-table (statesN x actionsN)
    ```

* currentEpisode: int = `0`  
  
    ```
    Variables for performing the algorithm
    Stores the number of the current episode
    ```

* currentState: int = `0`  
  
    ```
    Stores the current state
    ```

* canRunEpisodes: bool = `false`  
  
    ```
    Store if the algorithm has started
    ```

  
