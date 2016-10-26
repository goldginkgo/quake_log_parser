require_relative 'lib/quake_log_parser'

parser = QuakeLogParser.new(ARGV[0])
parser.parse_log_file
puts "====================     Task 1 and Task 2     ===================="
parser.display_game_information
puts "====================          Task 3           ===================="
parser.display_aggregation_kill_reasons