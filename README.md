#Quake log parser

## Introduction
This is a Ruby implementation of Quake log parser.

### My additional considerations
1. Two kinds of suicides (killed by `<world>` or self)
2. score = kills - suicides, and can be negative

## Run RSpec tests
```
cd quake_log_parser
bundle install
rspec --format doc
```

## Run the parser
Execute the following command line to run the parser.
```
Usage: ruby main.rb [options]

Specific options:
    -f, --file Name                  Specify the log file path.
    -k, --kill-reason                Display aggregation of kill reasons.
    -g, --game-name Name             Display information for a single game.

Common options:
    -h, --help                       Show this message.
```
For example, run the following command to show the scores for all games.
```
ruby main.rb -f <LOG_FILE_PATH>
```
Your can also omit the -f option to parse the default log file in quake_logs folder.
```
ruby main.rb
```
If you want to show scores for a specific game,
```
ruby main.rb -g game_1
```
If you want to show aggregation of kill reason for all games,
```
ruby main.rb -k
```
If you want to show aggregation of kill reason for a specific game,
```
ruby main.rb -k -g game_1
```
