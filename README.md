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
This parses the default log file in quake_logs folder.
```
cd quake_log_parser
ruby main.rb
```
If you want to parser another Quake log file, please use the following commands:
```
cd quake_log_parser
ruby main.rb <LOG_FILE_PATH>
```
